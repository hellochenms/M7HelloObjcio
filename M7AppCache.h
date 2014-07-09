//
//  M7AppCache.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M7AppCache : NSObject
+ (instancetype)sharedInstance;
// MenuItems
- (NSArray *)readMenuItemsFromCache;
- (BOOL)writeMenuItemsToCache:(NSArray *)menuItems;
- (BOOL)checkIfMenuItemsCacheOutOfTime;
@end
