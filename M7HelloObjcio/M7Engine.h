//
//  M7Engine.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-8.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "MKNetworkEngine.h"
@class M7NetworkOperation;

typedef void (^M7EArrayBlock) (NSArray *array);
typedef void (^M7EErrorBlock) (NSError *error);

@interface M7Engine : MKNetworkEngine
+ (M7Engine *)sharedInstance;
- (M7NetworkOperation *)requestMenuItemsWithCompletionHandler:(M7EArrayBlock)arrayBlock errorHandler:(M7EErrorBlock)errorBlock;
@end
