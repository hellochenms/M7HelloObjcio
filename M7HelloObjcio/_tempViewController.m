//
//  _tempViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-1.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "_tempViewController.h"

@interface _tempViewController ()
@end

@implementation _tempViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    if (isIOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

@end
