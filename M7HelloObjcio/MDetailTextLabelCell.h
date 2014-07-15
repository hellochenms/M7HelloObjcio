//
//  _tempTableViewCell.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-15.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDetailTextLabelSingleton.h"

@interface MDetailTextLabelCell : UITableViewCell
- (void)reloadData:(MDetailTextLabelSingleton *)data;
@end
