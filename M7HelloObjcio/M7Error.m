//
//  M7Error.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-8.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M7Error.h"

NSString * const kM7EErrorDomainBusiness = @"kM7EErrorDomainBusiness";
NSString * const kM7EErrorDomainNetwork = @"kM7EErrorDomainNetwork";

NSString * const kErrorTableName = @"ErrorTable";

@implementation M7Error
static NSDictionary *s_codeKeyStringMapping = nil;
+ (NSString *)keyStringFromCode:(NSInteger)code{
    if (!s_codeKeyStringMapping) {
        s_codeKeyStringMapping = @{@"1000": @"BusinessErrorText1000",
                                   @"1001": @"BusinessErrorText1001"};
    }
    return [s_codeKeyStringMapping objectForKey:[NSString stringWithFormat:@"%d", code]];
}

- (NSString *)description{
    if ([self.domain isEqualToString:kM7EErrorDomainBusiness]) {
        return NSLocalizedStringFromTable([M7Error keyStringFromCode:self.code], kErrorTableName, nil);
    }else if ([self.domain isEqualToString:kM7EErrorDomainNetwork]) {
        NSString *errorString = NSLocalizedStringFromTable(@"NetworkErrorText", kErrorTableName, nil);
        return errorString;
    }else {
        return [super description];
    }
}
@end
