//
//  M_1_4_Sub_ViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-4.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M_1_4_Sub_ViewController.h"

@interface M_1_4_Sub_ViewController ()
@property (nonatomic) UILabel *label;
@end

@implementation M_1_4_Sub_ViewController

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
    _label = [[UILabel alloc] initWithFrame:self.view.bounds];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _label.backgroundColor = RandomColor;
    _label.text = [self description];
    [self.view addSubview:_label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
