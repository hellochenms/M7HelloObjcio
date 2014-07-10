//
//  M7CacheEngine.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"

typedef void (^M7CEArrayBlock) (NSArray *array);
typedef void (^M7CEErrorBlock) (NSError *error);

@interface M7CacheEngine : MKNetworkEngine

+ (M7CacheEngine *)sharedInstance;
- (MKNetworkOperation *)requestMenuItemsWithCompletionHandler:(M7CEArrayBlock)arrayBlock errorHandler:(M7CEErrorBlock)errorBlock;
@end
