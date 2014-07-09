//
//  CacheJSONModel.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "CacheJSONModel.h"

@implementation CacheJSONModel
#pragma mark -
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

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    return self;
}

@end
