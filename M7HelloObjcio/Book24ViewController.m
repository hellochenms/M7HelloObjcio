//
//  Book24ViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "Book24ViewController.h"
#import "M7CacheEngine.h"
#import "CacheMenuItem.h"
#import "M7AppCachePlus.h"

@interface Book24ViewController ()
@property (nonatomic) MKNetworkOperation *operation;
@property (nonatomic) NSArray *menuItems;
@end

@implementation Book24ViewController

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 读缓存
    self.menuItems = [[M7AppCachePlus sharedInstance] readMenuItemsFromCacheForIndex:1];
    if ([self.menuItems count] > 0) {
        NSLog(@"从缓存读取MenuItems成功  %s", __func__);
        [self printMenuItems:self.menuItems];
        // 检查过期
        if ([[M7AppCachePlus sharedInstance] checkIfMenuItemsCacheOutOfTimeForIndex:1]) {//TODO:
            NSLog(@"缓存过期  %s", __func__);
            [self requestMenuItems];
        }
    }else{
        [self requestMenuItems];
    }
}


#pragma mark -
- (void)printMenuItems:(NSArray *)menuItems{
    CacheMenuItem *menuItem = nil;
    for (menuItem in menuItems) {
        NSLog(@"menuItem(%@)  %s", menuItem, __func__);
        NSLog(@"menuItem.reviews(%@)  %s", menuItem.reviews, __func__);
    }
}

- (void)requestMenuItems{
    [self.operation cancel];
    __weak typeof(self) weakSelf = self;
    self.operation = [[M7CacheEngine sharedInstance] requestMenuItemsWithCompletionHandler:^(NSArray *array) {
        weakSelf.menuItems = array;
        NSLog(@"请求MenuItems成功  %s", __func__);
        // 写缓存
        [[M7AppCachePlus sharedInstance] writeMenuItemsToCache:self.menuItems forIndex:0];
        
        // for test
//        [[M7AppCachePlus sharedInstance] writeMenuItemsToCache:self.menuItems forIndex:1];
//        [[M7AppCachePlus sharedInstance] writeMenuItemsToCache:self.menuItems forIndex:2];
//        [[M7AppCachePlus sharedInstance] writeMenuItemsToCache:self.menuItems forIndex:3];
        
        [weakSelf printMenuItems:weakSelf.menuItems];
    } errorHandler:^(NSError *error) {
        NSLog(@"error(%@)  %s", error, __func__);
    }];
}

#pragma mark -
- (void)viewDidDisappear:(BOOL)animated{
    // 取消请求
    [self.operation cancel];
    self.operation = nil;
    // 写缓存
    [[M7AppCachePlus sharedInstance] writeMenuItemsToCache:self.menuItems forIndex:0];
    
    // for test
//    [[M7AppCachePlus sharedInstance] writeMenuItemsToCache:self.menuItems forIndex:1];
//    [[M7AppCachePlus sharedInstance] writeMenuItemsToCache:self.menuItems forIndex:2];
//    [[M7AppCachePlus sharedInstance] writeMenuItemsToCache:self.menuItems forIndex:3];
    
    [super viewDidDisappear:animated];
}

@end
