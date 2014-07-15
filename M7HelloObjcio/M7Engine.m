//
//  M7Engine.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-8.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M7Engine.h"
#import "MenuItem.h"
#import "M7NetworkOperation.h"

static NSString *const kHostName = @"restfulengine.iosptl.com";

@implementation M7Engine

+ (M7Engine *)sharedInstance{
    static M7Engine *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[M7Engine alloc] initWithHostName:kHostName];
        [s_instance registerOperationSubclass:[M7NetworkOperation class]];
    });
    
    return s_instance;
}

#pragma mark -
- (M7NetworkOperation *)requestMenuItemsWithCompletionHandler:(M7EArrayBlock)arrayBlock errorHandler:(M7EErrorBlock)errorBlock{
    // 这句能转换为子类，是因为这句[s_instance registerOperationSubclass:[M7NetworkOperation class]];
    M7NetworkOperation *operation = (M7NetworkOperation *)[self operationWithPath:@"menuitem"];
    
    // TODO: test network error
//   M7NetworkOperation *operation = (M7NetworkOperation *)[self operationWithPath:@"404"];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        NSLog(@"%@  %s", completedOperation.responseJSON, __func__);
        NSDictionary *responseDict = completedOperation.responseJSON;
        NSArray *menuItemsJSON = [responseDict objectForKey:@"menuitems"];
        NSMutableArray *menuItems = [NSMutableArray array];
        [menuItemsJSON enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [menuItems addObject:[[MenuItem alloc] initWithDictionary:obj]];
        }];
        if (arrayBlock) {
            arrayBlock(menuItems);
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        NSLog(@"%@  %s", error, __func__);
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    [self enqueueOperation:operation];
    
    return operation;
}

@end
