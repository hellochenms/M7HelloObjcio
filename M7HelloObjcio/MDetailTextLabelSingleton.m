//
//  _tempSingleton.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-15.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "MDetailTextLabelSingleton.h"

@implementation MDetailTextLabelSingleton
+ (instancetype)sharedInstance{
    static MDetailTextLabelSingleton *s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [MDetailTextLabelSingleton new];
    });
    
    return s_instance;
}
@end
