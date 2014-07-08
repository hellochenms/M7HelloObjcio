//
//  M7JSONModel.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-8.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M7JSONModel.h"

@implementation M7JSONModel
- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

- (id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"undefinedKey(%@)  %s", key, __func__);
    return nil;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"undefinedKey(%@)  %s", key, __func__);
}

@end
