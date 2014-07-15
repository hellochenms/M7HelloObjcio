//
//  Book14ViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-8.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "Book14ViewController.h"
#import "M7Engine.h"
#import "MenuItem.h"
#import "M7NetworkOperation.h"

@interface Book14ViewController ()
@property (nonatomic) M7NetworkOperation *operation;
@end

@implementation Book14ViewController

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
    
    UIButton *requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    requestButton.frame = CGRectMake(10, 10, 100, 30);
    requestButton.backgroundColor = [UIColor blueColor];
    [requestButton setTitle:@"request" forState:UIControlStateNormal];
    [requestButton addTarget:self action:@selector(onTapRequestButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:requestButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 10 - 100, 10, 100, 30);
    cancelButton.backgroundColor = [UIColor blueColor];
    [cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(onTapCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

#pragma mark - 
- (void)onTapRequestButton{
    [self.operation cancel];
    self.operation = [[M7Engine sharedInstance] requestMenuItemsWithCompletionHandler:^(NSArray *array) {
        MenuItem *menuItem = nil;
        for (menuItem in array) {
            NSLog(@"menuItem(%@)  %s", menuItem, __func__);
            NSLog(@"menuItem.reviews(%@)  %s", menuItem.reviews, __func__);
        }
    } errorHandler:^(NSError *error) {
        NSLog(@"error(%@)  %s", error, __func__);
    }];
}

- (void)onTapCancelButton{
   [self.operation cancel];
}

@end
