//
//  M_13_1View.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonViewModel;

@interface M_13_1View : UIView
- (void)reloadDataFromViewModel:(PersonViewModel *)personViewModel;
@end
