//
//  M_12_1_ViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-1.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M_12_1_ViewController.h"

@interface M_12_1_ViewController ()
@property (nonatomic) UIView *someView;
@property (nonatomic) UIView *twoView;
@property (nonatomic) CALayer *someLayer;
@property (nonatomic) CALayer *twoLayer;
@end

@implementation M_12_1_ViewController

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
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(10, 10, 60, 30);
    startButton.backgroundColor = [UIColor blueColor];
    [startButton setTitle:@"start" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(onTapStartButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame = CGRectMake(CGRectGetMaxX(startButton.frame) + 10, 10, 60, 30);
    resetButton.backgroundColor = [UIColor blueColor];
    [resetButton setTitle:@"reset" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(onTapResetButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    
    _someView = [[UIView alloc] initWithFrame: CGRectMake(10, 100, 40, 40)];

    _someView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_someView];
    // demo4
//    _someView.hidden = YES;
    
    _twoView = [[UIView alloc] initWithFrame: CGRectMake(10, 150, 40, 40)];
    _twoView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_twoView];
    
    // demo6：
//    _someView.backgroundColor = [UIColor clearColor];
//    _someView.center = CGPointMake(160, _someView.center.y);
//    
//    _someLayer = [CALayer layer];
//    _someLayer.frame = _someView.bounds;
//    _someLayer.backgroundColor = [UIColor redColor].CGColor;
//    _twoLayer.zPosition = 0;
//    [_someView.layer addSublayer:_someLayer];
//    
//    _twoLayer = [CALayer layer];
//    _twoLayer.frame = _someView.bounds;
//    _twoLayer.backgroundColor = [UIColor greenColor].CGColor;
//    _twoLayer.zPosition = 1;
//    [_someView.layer addSublayer:_twoLayer];
}

#pragma mark - 
- (void)onTapStartButton{
    // demo1：示范CA动画，并指出直接修改layer的属性来解决动画结束后跳回的问题。
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anima.fromValue = @(_someView.center.x);
    anima.toValue = @320;
    anima.duration = 1;
    [_someView.layer addAnimation:anima forKey:nil];
    _someView.layer.position = CGPointMake(320, _someView.center.y);
    
    // demo2：指出动画被add时会复制一份，所以add到someView后修改anima再add到twoView上不影响someView；
    // 指出延迟执行动画时，由于我们直接修改了layer的属性，会出现layer先闪到目标位置，延时到了闪回fromValue位置开始动画；
    // 所以我们要设置fillMode为kCAFillModeBackwards，这样延迟阶段layer会在fromValue处显示。
//    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position.x"];
//    anima.fromValue = @(_someView.center.x);
//    anima.toValue = @320;
//    anima.duration = 1;
//    [_someView.layer addAnimation:anima forKey:nil];
//    _someView.layer.position = CGPointMake(320, _someView.center.y);
//    anima.beginTime = CACurrentMediaTime() + 0.5;
//    anima.fromValue = @(_twoView.center.x);
////    anima.fromValue = @(_twoView.center.x + 100);
//    anima.fillMode = kCAFillModeBackwards;
//    [_twoView.layer addAnimation:anima forKey:nil];
//    _twoView.layer.position = CGPointMake(320, _twoView.center.y);
    
    // demo3：additive设置为YES，则values的值会计算入modelLayer？换句话说，values的值看上去就像相对值了。
    // 这样，这个动画就可以加载任何需要的layer上，而不用考虑position的真实值；CABasicAnimation也可用。
//    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
//    anima.values = @[@0, @10, @-10, @10, @0];
//    anima.keyTimes = @[@0, @0.2, @0.5, @0.8, @1];
//    anima.duration = 0.3;
//    anima.additive = YES;
//    [_someView.layer addAnimation:anima forKey:nil];
    
    // demo4：
//    _someView.hidden = NO;
//    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    anima.path = CFAutorelease(CGPathCreateWithEllipseInRect(CGRectMake(-100, -100, 200, 200), NULL));
//    anima.duration = 2;
//    anima.additive = YES;
//    anima.repeatCount = HUGE_VALF;
//    anima.calculationMode = kCAAnimationPaced;
//    anima.rotationMode = kCAAnimationRotateAuto;
//    [_someView.layer addAnimation:anima forKey:nil];
    
    // demo5：
//    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position.x"];
//    anima.fromValue = @(_someView.center.x);
//    anima.toValue = @320;
//    anima.duration = 1;
//    anima.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.3:1:0.7:0];
//    [_someView.layer addAnimation:anima forKey:nil];
//    _someView.layer.position = CGPointMake(320, _someView.center.y);
    
    // demo6：
//    BOOL isSomeLayerTarget = (_someLayer.zPosition < _twoLayer.zPosition);
//    CGFloat bigZPosition = MAX(_someLayer.zPosition, _twoLayer.zPosition);
//    if (bigZPosition >= 9) {
//        if (isSomeLayerTarget) {
//            _someLayer.zPosition = 0;
//            _twoLayer.zPosition = 1;
//        }else{
//            _twoLayer.zPosition = 0;
//            _someLayer.zPosition = 1;
//        }
//    }
//    
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    
//    CALayer *targetLayer = (isSomeLayerTarget ? _someLayer : _twoLayer);
//    CGFloat srcZPosition = MIN(_someLayer.zPosition, _twoLayer.zPosition);
//    CGFloat destZPosition = MAX(_someLayer.zPosition, _twoLayer.zPosition) + 1;
//    CAAnimationGroup *targetGroup = [self demo6AnimaGroupForLayerWantsZPositionBigger:YES srcZPosition:srcZPosition destZPosition:destZPosition];
//    [targetLayer addAnimation:targetGroup forKey:nil];
//    targetLayer.zPosition = destZPosition;
//    
//    CALayer *keepLayer = (isSomeLayerTarget ? _twoLayer : _someLayer);
//    CAAnimationGroup *keepGroup = [self demo6AnimaGroupForLayerWantsZPositionBigger:NO srcZPosition:MAXFLOAT destZPosition:MAXFLOAT];
//    [keepLayer addAnimation:keepGroup forKey:nil];
//
//    [CATransaction commit];
}
- (void)onTapResetButton{
    // demo1
    _someView.frame = CGRectMake(10, 100, 40, 40);
    
    // demo2
//    _someView.frame = CGRectMake(10, 100, 40, 40);
//    _twoView.frame = CGRectMake(10, 150, 40, 40);
    
    // demo3
    
    // demo4
//    _someView.hidden = YES;
//    [_someView.layer removeAllAnimations];
    
    // demo5：
//    _someView.frame = CGRectMake(10, 100, 40, 40);
//    [_someView.layer removeAllAnimations];
    
    // demo6：

}

#pragma mark - for demo6
- (CAAnimationGroup *)demo6AnimaGroupForLayerWantsZPositionBigger:(BOOL)wantsZPositionBigger srcZPosition:(CGFloat)srcZPosition destZPosition:(CGFloat)destZPosition{
    
    CABasicAnimation *zPosition = nil;
    if (wantsZPositionBigger) {
        zPosition = [CABasicAnimation animationWithKeyPath:@"zPosition"];
        zPosition.fromValue = @(srcZPosition);
        zPosition.toValue = @(destZPosition);
        zPosition.duration = 1;
    }
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.values = @[@0, @(M_PI / 12.0 * (wantsZPositionBigger ? -1 : 1)) , @0];
    rotation.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 ];
    rotation.duration = 1;
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    position.values = @[
                        [NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(20 * (wantsZPositionBigger ? -1 : 1), 0)],
                        [NSValue valueWithCGPoint:CGPointZero],
                        ];
    position.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 ];
    position.duration = 1;
    position.additive = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup new];
    if (wantsZPositionBigger) {
        group.animations = @[zPosition, rotation, position];
    }else{
        group.animations = @[rotation, position];
    }
    group.duration = 1;
    group.beginTime = 0;// 文章中设置了0.5，实测中不会执行动画，暂时不知道原因。
    
    return group;
}

@end
