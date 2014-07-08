//
//  Review.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-8.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M7JSONModel.h"

@interface Review : M7JSONModel
@property (nonatomic, copy) NSString *reviewId;
@property (nonatomic, copy) NSString *reviewText;
@end
