//
//  M7AppCachePlus.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M7AppCachePlus.h"

static NSString * const kM7ACUserDefaultsKeyCacheAppVersion = @"kM7ACUserDefaultsKeyCacheAppVersion";
static NSTimeInterval const kM7ACMaxCachedSeconds = 20;
static NSInteger const kM7ACMemoryCacheMaxItemCount = 2;

@interface M7AppCachePlus()
@property (nonatomic, copy) NSString        *cacheDir;
@property (nonatomic) NSMutableDictionary   *memoryCache;
@property (nonatomic) NSMutableArray        *recentlyAccessedKeys;
@end

@implementation M7AppCachePlus
+ (instancetype)sharedInstance{
    static M7AppCachePlus *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[M7AppCachePlus alloc] init];
    });
    
    return s_instance;
}

- (id)init{
    self = [super init];
    if (self) {
        // 内存缓存
        _memoryCache = [NSMutableDictionary dictionary];
        _recentlyAccessedKeys = [NSMutableArray array];
    
        // 准备缓存目录
        [self prepareCacheDir];
        // 应用版本更新时清除缓存
        [self tryClearCacheIfAppVersionChanged];
        
        // 系统通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(writeMemoryCacheToDisk) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(writeMemoryCacheToDisk) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(writeMemoryCacheToDisk) name:UIApplicationWillTerminateNotification object:nil];
    }
    
    return self;
}

#pragma mark - core
- (void)prepareCacheDir{
    _cacheDir = [[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"AppCache"] copy];
    BOOL isDir = NO;
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:_cacheDir isDirectory:&isDir];
    NSError *error = nil;
    if (!isExists || !isDir) {
        [[NSFileManager defaultManager] createDirectoryAtPath:_cacheDir
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
    }
}

- (void)tryClearCacheIfAppVersionChanged{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *oldVersion = [userDefaults objectForKey:kM7ACUserDefaultsKeyCacheAppVersion];
    NSString *appVersion = [self appVersion];
    NSLog(@"oldVersion(%@) appVersion(%@)  %s", oldVersion, appVersion, __func__);
    if (oldVersion && [oldVersion compare:appVersion] == NSOrderedAscending) {
        [self clearCache];
    }
    [userDefaults setObject:appVersion forKey:kM7ACUserDefaultsKeyCacheAppVersion];
    [userDefaults synchronize];
}
- (NSString *)appVersion{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleVersion"];//TODO:
    
    return version;
}
- (void)clearCache{
    NSLog(@"清空缓存  %s", __func__);
    NSArray *cacheItems = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.cacheDir error:nil];
    NSString *itemPath = nil;
    for (itemPath in cacheItems) {
        [[NSFileManager defaultManager] removeItemAtPath:[self.cacheDir stringByAppendingPathComponent:itemPath] error:nil];
    }
}

- (BOOL)checkIfCacheOutOfTimeForPath:(NSString *)cachePath{
    NSTimeInterval cachedSeconds = [[[[NSFileManager defaultManager] attributesOfItemAtPath:cachePath error:nil] fileModificationDate] timeIntervalSinceNow] * (-1);
    NSLog(@"cachedSeconds(%f)  %s", cachedSeconds, __func__);
    
    return (cachedSeconds > kM7ACMaxCachedSeconds);
}

// 优先写内存缓存，内存缓存满了则按LRU（最近最少使用）算法将多余的item写硬盘；
- (void)tryWriteData:(NSData *)data toFileName:(NSString *)fileName{
    [self.memoryCache setObject:data forKey:fileName];
    if ([self.recentlyAccessedKeys containsObject:fileName]) {
        [self.recentlyAccessedKeys removeObject:fileName];
    }
    [self.recentlyAccessedKeys insertObject:fileName atIndex:0];
    [self keepMemoryItemCountRight];
}
- (NSData *)tryReadDataFromFileName:(NSString *)fileName{
    NSData *data = [self.memoryCache objectForKey:fileName];
    if (data) {
        [self.recentlyAccessedKeys removeObject:fileName];
        [self.recentlyAccessedKeys insertObject:fileName atIndex:0];
    }else{
        data = [NSData dataWithContentsOfFile:[self.cacheDir stringByAppendingPathComponent:fileName]];
        if (data) {
            [self.memoryCache setObject:data forKey:fileName];
            [self.recentlyAccessedKeys insertObject:fileName atIndex:0];
            [self keepMemoryItemCountRight];
        }
    }
    
    return data;
}

- (void)keepMemoryItemCountRight{
    if ([self.recentlyAccessedKeys count] > kM7ACMemoryCacheMaxItemCount) {
        NSString *leastRecentlyUsedFileName = [self.recentlyAccessedKeys lastObject];
        [self.recentlyAccessedKeys removeObject:leastRecentlyUsedFileName];
        NSData *leastRecentlyUsedData = [self.memoryCache objectForKey:leastRecentlyUsedFileName];
        [self.memoryCache removeObjectForKey:leastRecentlyUsedFileName];
        [leastRecentlyUsedData writeToFile:[self.cacheDir stringByAppendingPathComponent:leastRecentlyUsedFileName] atomically:YES];
    }
}

- (void)writeMemoryCacheToDisk{
    NSString *fileName = nil;
    NSArray *fileNames = [self.memoryCache allKeys];
    NSData *data = nil;
    for (fileName in fileNames) {
        data = [self.memoryCache objectForKey:fileName];
        [data writeToFile:[self.cacheDir stringByAppendingPathComponent:fileName] atomically:YES];
    }
    [self.memoryCache removeAllObjects];
    [self.recentlyAccessedKeys removeAllObjects];
}

#pragma mark - logic
#pragma mark MenuItems
static NSString * const kM7ACMenuItemFileName = @"MenuItems.cache";
- (NSArray *)readMenuItemsFromCache{
    NSLog(@"读缓存  %s", __func__);
    return [NSKeyedUnarchiver unarchiveObjectWithData:[self tryReadDataFromFileName:kM7ACMenuItemFileName]];
}
- (void)writeMenuItemsToCache:(NSArray *)menuItems{
    NSLog(@"写缓存  %s", __func__);
    [self tryWriteData:[NSKeyedArchiver archivedDataWithRootObject:menuItems] toFileName:kM7ACMenuItemFileName];
}
- (BOOL)checkIfMenuItemsCacheOutOfTime{
    return [self checkIfCacheOutOfTimeForPath:[self.cacheDir stringByAppendingPathComponent:kM7ACMenuItemFileName]];
}

#pragma mark - for test
static NSString * const kM7ACMenuItemFileNameForTest = @"MenuItems.cache";
- (NSArray *)readMenuItemsFromCacheForIndex:(NSInteger)index{
    NSLog(@"读缓存  %s", __func__);
    return [NSKeyedUnarchiver unarchiveObjectWithData:[self tryReadDataFromFileName:[NSString stringWithFormat:@"%@%d", kM7ACMenuItemFileName, index]]];
}
- (void)writeMenuItemsToCache:(NSArray *)menuItems forIndex:(NSInteger)index{
    NSLog(@"写缓存  %s", __func__);
    [self tryWriteData:[NSKeyedArchiver archivedDataWithRootObject:menuItems] toFileName:[NSString stringWithFormat:@"%@%d", kM7ACMenuItemFileName, index]];
}
- (BOOL)checkIfMenuItemsCacheOutOfTimeForIndex:(NSInteger)index{
    return [self checkIfCacheOutOfTimeForPath:[self.cacheDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d", kM7ACMenuItemFileName, index]]];
}
@end
