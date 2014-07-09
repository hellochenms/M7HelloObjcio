//
//  CacheMenuItem.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "CacheJSONModel.h"

@interface CacheMenuItem : CacheJSONModel
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray  *reviews;
@end
