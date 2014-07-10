//
//  CacheReview.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "CacheJSONModel.h"

@interface CacheReview : CacheJSONModel
@property (nonatomic, copy) NSString *reviewId;
@property (nonatomic, copy) NSString *reviewText;
@end
