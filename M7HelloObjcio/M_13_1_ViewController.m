//
//  M_13_1ViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M_13_1_ViewController.h"
#import "M_13_1View.h"
#import "PersonModel.h"
#import "PersonViewModel.h"

@interface M_13_1_ViewController ()
@property (nonatomic) M_13_1View *mainView;
@property (nonatomic) PersonViewModel *personViewModel;
@end

@implementation M_13_1_ViewController

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
    
    self.mainView = [[M_13_1View alloc] initWithFrame:self.view.bounds];
    self.mainView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mainView];
    
    UIButton *updateDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    updateDataButton.frame = CGRectMake(10, 100, 100, 30);
    updateDataButton.backgroundColor = [UIColor blueColor];
    [updateDataButton setTitle:@"更新数据" forState:UIControlStateNormal];
    [updateDataButton addTarget:self action:@selector(onTapUpdateDataButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateDataButton];
}

- (void)onTapUpdateDataButton{
    // model
    PersonModel *personModel = [self genetatePersonModel];
    
    // model -> view model
    if (!self.personViewModel) {
        self.personViewModel = [[PersonViewModel alloc] initWithPersonModel:personModel];
    }else{
        [self.personViewModel reloadDataFromPersonModel:personModel];
    }
    
    // view use view model
    [self.mainView reloadDataFromViewModel:self.personViewModel];
}

- (PersonModel *)genetatePersonModel{
    PersonModel *personModel = [PersonModel new];
    personModel.salutation = (arc4random() % 2 == 0 ? @"Mr." : nil);
    personModel.firstName = @[@"FirstA", @"FirstB" , @"FirstC"][arc4random() % 3];
    personModel.lastName = @[@"LastA", @"LastB", @"LastC"][arc4random() % 3];
    personModel.birthDate = [NSDate dateWithTimeIntervalSinceNow:(arc4random() % (60 * 60 * 24 * 365 * 20)) * (-1)];
    NSTimeInterval num = arc4random() % (60 * 60 * 24 * 365 * 20);
    personModel.birthDate = [NSDate dateWithTimeIntervalSinceNow:-num];
    
    return personModel;
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
