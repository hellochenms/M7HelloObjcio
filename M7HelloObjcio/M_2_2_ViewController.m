//
//  M_2_2_ViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-5.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M_2_2_ViewController.h"
#import "Objcio22AsynURLOperation.h"

@interface M_2_2_ViewController ()
@property (nonatomic) UIProgressView    *progressView;
@property (nonatomic) NSOperationQueue  *operationQueue;
@property (nonatomic) Objcio22AsynURLOperation  *asynURLOperation;
@end

@implementation M_2_2_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _operationQueue = [NSOperationQueue new];
        _operationQueue.maxConcurrentOperationCount = 1;
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
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 50, CGRectGetWidth(self.view.bounds) - 10 * 2, 20)];
    [self.view addSubview:_progressView];
}

#pragma mark -
- (void)onTapRequestButton{
    [self cancelOperation];
    self.asynURLOperation = [[Objcio22AsynURLOperation alloc] initWithUrlString:@"http://ipv4.download.thinkbroadband.com/5MB.zip"];
    __weak typeof(self) weakSelf = self;
    self.asynURLOperation.progressHandler = ^(float progress){
        weakSelf.progressView.progress = progress;
    };
    self.asynURLOperation.completionHandler = ^(Objcio22AsynURLOperation *completionOperation){
        weakSelf.progressView.progress = 1;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"下载成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    };
    self.asynURLOperation.errorHandler = ^(Objcio22AsynURLOperation *completionOperation, NSError *error){
        weakSelf.progressView.progress = 0;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"下载失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    };
    [self.operationQueue addOperation:self.asynURLOperation];
}
- (void)onTapCancelButton{
    [self cancelOperation];
}
- (void)cancelOperation{
    [self.asynURLOperation cancel];
    self.asynURLOperation = nil;
    self.progressView.progress = 0;
}

@end
