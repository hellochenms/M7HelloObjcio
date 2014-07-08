//
//  MenuItem.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-8.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "MenuItem.h"
#import "Review.h"

@implementation MenuItem
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"reviews"]) {
        NSDictionary *reviewDict = nil;
        Review *review = nil;
        NSMutableArray *reviews = [NSMutableArray array];
        for (reviewDict in value) {
            review = [[Review alloc] initWithDictionary:reviewDict];
            [reviews addObject:review];
        }
        self.reviews = [reviews copy];
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.identifier = [value copy];
    }else{
        [super setValue:value forUndefinedKey:key];
    }
}

- (NSString *)description{
    return [NSString stringWithFormat:@"id(%@), name(%@), reviews count(%d)", self.identifier, self.name, [self.reviews count]];
}
@end
