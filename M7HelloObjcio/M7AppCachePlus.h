//
//  M7AppCachePlus.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M7AppCachePlus : NSObject
+ (instancetype)sharedInstance;
// MenuItems
- (NSArray *)readMenuItemsFromCache;
- (void)writeMenuItemsToCache:(NSArray *)menuItems;
- (BOOL)checkIfMenuItemsCacheOutOfTime;

#pragma mark - for test
- (NSArray *)readMenuItemsFromCacheForIndex:(NSInteger)index;
- (void)writeMenuItemsToCache:(NSArray *)menuItems forIndex:(NSInteger)index;
- (BOOL)checkIfMenuItemsCacheOutOfTimeForIndex:(NSInteger)index;
@end
