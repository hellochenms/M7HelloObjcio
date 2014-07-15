//
//  RootViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-1.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) NSArray       *datas;
@property (nonatomic) UITableView   *tableView;
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _datas  = @[
                    @[@"临时测试", @"_tempViewController"],
                    @[@"1-4ViewController容器", @"M_1_4_ViewController"],
                    @[@"2-2并发常见实践", @"M_2_2_ViewController"],
                    @[@"7-1基础集合类", @"M_7_1_ViewController"],
                    @[@"9-2玩转字符串", @"M_9_2_ViewController"],
                    @[@"9-3字符串本地化", @"M_9_3_ViewController"],
                    @[@"12-1动画解释", @"M_12_1_ViewController"],
                    @[@"13-1MMVM架构", @"M_13_1_ViewController"],
                    @[@"book-14-RESTful架构", @"Book14ViewController"],
                    @[@"book-24-数据模型缓存", @"Book24ViewController"],
                    @[@"m-detailTextLabel的坑", @"MDetailTextLabelKengViewController"],
                    ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datas count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[_datas objectAtIndex:indexPath.row] objectAtIndex:0];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = [[_datas objectAtIndex:indexPath.row] objectAtIndex:1];
    UIViewController *subViewController = [NSClassFromString(className) new];
    [self.navigationController pushViewController:subViewController animated:YES];
}

@end
