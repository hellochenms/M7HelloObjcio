//
//  M_1_4_ViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-4.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M_1_4_ViewController.h"
#import "M_1_4_Sub_ViewController.h"

#define M14VC_Tag_Offset 6000

@interface M_1_4_ViewController ()
@property (nonatomic) UIButton *leftButton;
@property (nonatomic) UIButton *middleButton;
@property (nonatomic) UIButton *rightButton;
@property (nonatomic) UIView *contentAreaView;
@property (nonatomic) NSMutableArray *subViewControllers;
@end

@implementation M_1_4_ViewController

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
    
    // control buttons
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(10, 10, 100, 30);
    _leftButton.backgroundColor = [UIColor blueColor];
    _leftButton.tag = 0 + M14VC_Tag_Offset;
    [_leftButton setTitle:@"显示左" forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftButton];
    
    _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _middleButton.frame = CGRectMake(0, 10, 80, 30);
    _middleButton.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, _middleButton.center.y);
    _middleButton.backgroundColor = [UIColor blueColor];
    _middleButton.tag = 1 + M14VC_Tag_Offset;
    [_middleButton setTitle:@"显示中" forState:UIControlStateNormal];
    [_middleButton addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_middleButton];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 10 - 100, 10, 100, 30);
    _rightButton.backgroundColor = [UIColor blueColor];
    _rightButton.tag = 2 + M14VC_Tag_Offset;
    [_rightButton setTitle:@"显示右" forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightButton];
    
    // content area view
    _contentAreaView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 300, 200)];
    _contentAreaView.clipsToBounds = YES;
    [self.view addSubview:_contentAreaView];
    
    // sub view controllers
    _subViewControllers = [NSMutableArray array];
    M_1_4_Sub_ViewController *leftSubViewController = [M_1_4_Sub_ViewController new];
    [_subViewControllers addObject:leftSubViewController];
    [self addChildViewController:leftSubViewController];
    leftSubViewController.view.frame = _contentAreaView.bounds;
    [_contentAreaView addSubview:leftSubViewController.view];
    [leftSubViewController didMoveToParentViewController:self];
    
    M_1_4_Sub_ViewController *middleSubViewController = [M_1_4_Sub_ViewController new];
    middleSubViewController.view.frame = _contentAreaView.bounds;
    [_subViewControllers addObject:middleSubViewController];
    
    M_1_4_Sub_ViewController *rightSubViewController = [M_1_4_Sub_ViewController new];
    rightSubViewController.view.frame = _contentAreaView.bounds;
    [_subViewControllers addObject:rightSubViewController];
}

#pragma mark -
- (void)onTapButton:(UIButton *)sender{
    M_1_4_Sub_ViewController *curSubViewController = [self.childViewControllers objectAtIndex:0];
    M_1_4_Sub_ViewController *targetSubViewController = [_subViewControllers objectAtIndex:sender.tag - M14VC_Tag_Offset];
    if (curSubViewController == targetSubViewController) {
        return;
    }
    
    // 左右翻转
    UIViewAnimationOptions animaOptions = ([_subViewControllers indexOfObject:curSubViewController] > [_subViewControllers indexOfObject:targetSubViewController]
                                           ? UIViewAnimationOptionTransitionFlipFromLeft
                                           : UIViewAnimationOptionTransitionFlipFromRight);
    [curSubViewController willMoveToParentViewController:nil];
    [self addChildViewController:targetSubViewController];
    [self transitionFromViewController:curSubViewController
                      toViewController:targetSubViewController
                              duration:0.6
                               options:animaOptions
                            animations:nil
                            completion:^(BOOL finished) {
                                [curSubViewController removeFromParentViewController];
                                [targetSubViewController didMoveToParentViewController:self];
                            }];
    
    // 自定义动画，左右平移
//    UIViewAnimationOptions isToRight = ([_subViewControllers indexOfObject:curSubViewController] > [_subViewControllers indexOfObject:targetSubViewController]);
//    [curSubViewController willMoveToParentViewController:nil];
//    CGRect targetFrame = targetSubViewController.view.frame;
//    targetFrame.origin.x = targetFrame.size.width * (isToRight ? -1 : 1);
//    targetSubViewController.view.frame = targetFrame;
//    [self addChildViewController:targetSubViewController];
//    [self transitionFromViewController:curSubViewController
//                      toViewController:targetSubViewController
//                              duration:0.3
//                               options:UIViewAnimationOptionTransitionNone
//                            animations:^{
//                                CGRect curFrame = curSubViewController.view.frame;
//                                curFrame.origin.x = curFrame.size.width * (isToRight ? 1 : -1);
//                                curSubViewController.view.frame = curFrame;
//                                CGRect targetFrame = targetSubViewController.view.frame;
//                                targetFrame.origin.x = 0;
//                                targetSubViewController.view.frame = targetFrame;
//                            }
//                            completion:^(BOOL finished) {
//                                [curSubViewController removeFromParentViewController];
//                                CGRect curFrame = curSubViewController.view.frame;
//                                curFrame.origin.x = 0;
//                                curSubViewController.view.frame = curFrame;
//                                [targetSubViewController didMoveToParentViewController:self];
//                            }];
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
