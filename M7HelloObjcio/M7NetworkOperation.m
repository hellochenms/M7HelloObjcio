//
//  M7NetworkOperation.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-15.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M7NetworkOperation.h"
#import "M7Error.h"

@implementation M7NetworkOperation

- (void)operationSucceeded{
    NSDictionary *errDict = [self.responseJSON objectForKey:@"error"];
    if (errDict) {
        M7Error *m7Error = [[M7Error alloc] initWithDomain:kM7EErrorDomainBusiness
                                                      code:[[errDict objectForKey:@"code"] integerValue]
                                                  userInfo:errDict];
        [super operationFailedWithError:m7Error];
    }else {
        [super operationSucceeded];
    }
}

- (void)operationFailedWithError:(NSError *)error{
    M7Error *m7Error = [[M7Error alloc] initWithDomain:kM7EErrorDomainNetwork
                                                  code:error.code
                                              userInfo:error.userInfo];
    [super operationFailedWithError:m7Error];
}

@end
