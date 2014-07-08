//
//  M7Engine.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-8.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M7Engine.h"
#import "MenuItem.h"
#import "M7Error.h"

static NSString *const kHostName = @"restfulengine.iosptl.com";

@implementation M7Engine

+ (M7Engine *)sharedInstance{
    static M7Engine *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[M7Engine alloc] initWithHostName:kHostName];
    });
    
    return s_instance;
}

#pragma mark -
- (MKNetworkOperation *)requestMenuItemsWithCompletionHandler:(M7EArrayBlock)arrayBlock errorHandler:(M7EErrorBlock)errorBlock{
    MKNetworkOperation *operation = [self operationWithPath:@"menuitem"];
    
    // TODO: test network error
//    MKNetworkOperation *operation = [self operationWithPath:@"404"];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        NSLog(@"%@  %s", completedOperation.responseJSON, __func__);
        NSDictionary *responseDict = completedOperation.responseJSON;

        // TODO: test business error
//        NSMutableDictionary *responseDict = [completedOperation.responseJSON mutableCopy];
//        [responseDict setObject:@{@"code": @(1000)} forKey:@"error"];
        
        NSDictionary *errDict = [responseDict objectForKey:@"error"];
        if (!errDict) {
            NSArray *menuItemsJSON = [responseDict objectForKey:@"menuitems"];
            NSMutableArray *menuItems = [NSMutableArray array];
            [menuItemsJSON enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [menuItems addObject:[[MenuItem alloc] initWithDictionary:obj]];
            }];
            if (arrayBlock) {
                arrayBlock(menuItems);
            }
        }else if(errorBlock){
            M7Error *m7Error = [[M7Error alloc] initWithDomain:kM7EErrorDomainBusiness
                                                          code:[[errDict objectForKey:@"code"] integerValue]
                                                      userInfo:errDict];
            errorBlock(m7Error);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        NSLog(@"%@  %s", error, __func__);
        M7Error *m7Error = [[M7Error alloc] initWithDomain:kM7EErrorDomainNetwork
                                                      code:error.code
                                                  userInfo:error.userInfo];
        if (errorBlock) {
            errorBlock(m7Error);
        }
    }];
    [self enqueueOperation:operation];
    return operation;
}

@end
