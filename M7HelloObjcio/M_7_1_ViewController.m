//
//  M_7_1_ViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-6.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M_7_1_ViewController.h"

@interface Demo3Model : NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@end

@interface M_7_1_ViewController ()

@end

@implementation M_7_1_ViewController

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
    
    // demo1：字符串排序
//    NSArray *srcArr = @[@"b", @"1", @"a", @"ab"];
//    NSArray *destArr = [srcArr sortedArrayUsingSelector:@selector(localizedCompare:)];
//    NSLog(@"before（%@） after（%@）  %s", srcArr, destArr, __func__);

    // demo2：数字排序
//    NSArray *srcArr = @[@6, @1.2, @-2, @2];
//    NSArray *destArr = [srcArr sortedArrayUsingSelector:@selector(compare:)];
//    NSLog(@"before（%@） after（%@）  %s", srcArr, destArr, __func__);
    
    // demo3：对象比较
//    NSMutableArray *srcArr = [NSMutableArray array];
//    Demo3Model *model = nil;
//    model = [Demo3Model new];
//    model.identifier = @"b";
//    model.name = @"B";
//    [srcArr addObject:model];
//    model = [Demo3Model new];
//    model.identifier = @"c";
//    model.name = @"C";
//    [srcArr addObject:model];
//    model = [Demo3Model new];
//    model.identifier = @"a";
//    model.name = @"A";
//    [srcArr addObject:model];
//    NSArray *destArr = [srcArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [((Demo3Model *)obj1).identifier localizedCompare: ((Demo3Model *)obj2).identifier];
//    }];
//    NSLog(@"before（%@） after（%@）  %s", srcArr, destArr, __func__);
    
    // demo4：过滤，速度一般
//    NSArray *srcArr = @[@"b", @"1", @"a", @"ab"];
//    __weak typeof(self) weakSelf = self;
//    NSIndexSet *indexSet = [srcArr indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
//        return [weakSelf passingTestFromDemo4:obj];
//    }];
//    NSArray *destArr = [srcArr objectsAtIndexes:indexSet];
//    NSLog(@"before（%@） after（%@）  %s", srcArr, destArr, __func__);
    
    // demo5：谓词过滤，速度很慢
//    NSArray *srcArr = @[@"b", @"1", @"a", @"ab"];
//    __weak typeof(self) weakSelf = self;
//    NSArray *destArr = [srcArr filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
//        return [weakSelf passingTestFromDemo4:evaluatedObject];
//    }]];
//    NSLog(@"before（%@） after（%@）  %s", srcArr, destArr, __func__);
    
    // demo6：for in 过滤，速度较快
//    NSArray *srcArr = @[@"b", @"1", @"a", @"ab"];
//    NSMutableArray *destArr = [NSMutableArray array];
//    NSString *item = nil;
//    for (item in srcArr) {
//        if ([self passingTestFromDemo4:item]) {
//            [destArr addObject:item];
//        }
//    }
//    NSLog(@"before（%@） after（%@）  %s", srcArr, destArr, __func__);
    
    // demo7：enumerate 过滤，速度较慢
//    NSArray *srcArr = @[@"b", @"1", @"a", @"ab"];
//    __weak typeof(self) weakSelf = self;
//    NSMutableArray *destArr = [NSMutableArray array];
//    [srcArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([weakSelf passingTestFromDemo4:obj]) {
//            [destArr addObject:obj];
//        }
//    }];
//    NSLog(@"before（%@） after（%@）  %s", srcArr, destArr, __func__);
    
    // demo8：dictionary的enumerate过滤要比for in的方式快
//    NSDictionary *srcDict = @{@"b":@"B", @"1":@"1", @"a":@"A", @"ab":@"AB"};
//    NSMutableDictionary *destDict = [NSMutableDictionary dictionary];
//    __weak typeof(self) weakSelf = self;
//    [srcDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        if ([weakSelf passingTestFromDemo4:key]) {
//            [destDict setObject:obj forKey:key];
//        }
//    }];
//    NSLog(@"before（%@） after（%@）  %s", srcDict, destDict, __func__);
    
    
}

// from demo4 to x
- (BOOL)passingTestFromDemo4:(id)obj{
    NSRange range = [((NSString *)obj) rangeOfString:@"a" options:NSAnchoredSearch];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
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

@implementation Demo3Model
- (NSString *)description{
    return [NSString stringWithFormat:@"id(%@) name(%@)", self.identifier, self.name];
}
@end
