//
//  Review.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-8.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "Review.h"

@implementation Review
- (NSString *)description{
    return [NSString stringWithFormat:@"reviewId(%@), reviewText(%@)", self.reviewId, self.reviewText];
}
@end
