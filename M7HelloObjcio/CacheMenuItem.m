//
//  CacheMenuItem.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "CacheMenuItem.h"
#import "CacheReview.h"

@implementation CacheMenuItem
#pragma mark - 
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"reviews"]) {
        NSDictionary *reviewDict = nil;
        CacheReview *review = nil;
        NSMutableArray *reviews = [NSMutableArray array];
        for (reviewDict in value) {
            review = [[CacheReview alloc] initWithDictionary:reviewDict];
            [reviews addObject:review];
        }
        self.reviews = reviews;
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.identifier = value;
    }else{
        [super setValue:value forUndefinedKey:key];
    }
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.reviews forKey:@"reviews"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.identifier = [aDecoder decodeObjectForKey:@"identifier"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.reviews = [aDecoder decodeObjectForKey:@"reviews"];
    }
    return self;
}

#pragma mark -
- (NSString *)description{
    return [NSString stringWithFormat:@"id(%@), name(%@), reviews count(%d)", self.identifier, self.name, [self.reviews count]];
}
@end
