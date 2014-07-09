//
//  CacheReview.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "CacheReview.h"

@implementation CacheReview
#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.reviewId forKey:@"reviewId"];
    [aCoder encodeObject:self.reviewText forKey:@"reviewText"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.reviewId = [aDecoder decodeObjectForKey:@"reviewId"];
        self.reviewText = [aDecoder decodeObjectForKey:@"reviewText"];
    }
    return self;
}

#pragma mark -
- (NSString *)description{
    return [NSString stringWithFormat:@"reviewId(%@), reviewText(%@)", self.reviewId, self.reviewText];
}
@end
