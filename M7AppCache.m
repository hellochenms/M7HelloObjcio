//
//  M7AppCache.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M7AppCache.h"

static NSTimeInterval const kM7ACMaxCachedSeconds = 20;

@interface M7AppCache()
@property (nonatomic, copy) NSString *cacheDir;
@end

@implementation M7AppCache

+ (instancetype)sharedInstance{
    static M7AppCache *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[M7AppCache alloc] init];
    });
    
    return s_instance;
}

- (id)init{
    self = [super init];
    if (self) {
        // 准备缓存目录
        [self prepareCacheDir];
        // 应用版本更新时清除缓存
        [self tryClearCacheIfAppVersionChanged];
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

static NSString * const kM7ACUserDefaultsKeyCacheAppVersion = @"kM7ACUserDefaultsKeyCacheAppVersion";
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

#pragma mark - logic
#pragma mark MenuItems
static NSString * const kM7ACMenuItemFileName = @"MenuItems.cache";
- (NSArray *)readMenuItemsFromCache{
    NSLog(@"读缓存  %s", __func__);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self.cacheDir stringByAppendingPathComponent:kM7ACMenuItemFileName]];
}
- (BOOL)writeMenuItemsToCache:(NSArray *)menuItems{
    NSLog(@"写缓存  %s", __func__);
    return [NSKeyedArchiver archiveRootObject:menuItems toFile:[self.cacheDir stringByAppendingPathComponent:kM7ACMenuItemFileName]];
}
- (BOOL)checkIfMenuItemsCacheOutOfTime{
    return [self checkIfCacheOutOfTimeForPath:[self.cacheDir stringByAppendingPathComponent:kM7ACMenuItemFileName]];
}

@end
