//
//  M_9_3_ViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-2.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M_9_3_ViewController.h"

@interface M_9_3_ViewController ()
@property (nonatomic) UILabel *someLabel;
@end

@implementation M_9_3_ViewController

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
    
    _someLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    _someLabel.backgroundColor = [UIColor blueColor];
    _someLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_someLabel];
    
    // demo1：
//    NSString *string = NSLocalizedString(@"m_9_3_hello_world", nil);
//    _someLabel.text = string;
    
    // demo2：
//    NSString *string = NSLocalizedStringFromTable(@"m_9_3_hello_table", @"HelloTable", nil);
//    _someLabel.text = string;
    
    // demo3：
//    NSString *string = NSLocalizedString(@"m_9_3_hello_argv_%d_%.2f", nil);
//    _someLabel.text = [NSString localizedStringWithFormat:string, 20, 30.0];
    
    // demo4：
    NSString *string = NSLocalizedString(@"m_9_3_hello_argv_modify_order_%d_%.2f", nil);
    _someLabel.text = [NSString localizedStringWithFormat:string, 20, 30.0];
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
