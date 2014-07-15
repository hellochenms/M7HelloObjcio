//
//  _tempSingleton.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-15.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDetailTextLabelSingleton : NSObject
@property (nonatomic) NSInteger num;
+ (instancetype)sharedInstance;
@end
