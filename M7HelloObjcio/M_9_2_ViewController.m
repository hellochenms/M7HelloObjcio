//
//  M_9_2_ViewController.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-3.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M_9_2_ViewController.h"

@interface M_9_2_ViewController ()
@property (nonatomic) UILabel *someLabel;
- (NSString *)buildStringWithFormat:(NSString *)format,...NS_FORMAT_FUNCTION(1,2);
@end

@implementation M_9_2_ViewController

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
//    NSString *string = [self buildStringWithFormat:@"%d_%.2f_0x%x_%@", 1, 2.2, 10, @"hello"];
//    _someLabel.text = string;
    
    // demo2：
//    NSString *string = @"012345\n6789";
//    [string enumerateSubstringsInRange:NSMakeRange(0, string.length)
//                               options:NSStringEnumerationByLines //NSStringEnumerationByComposedCharacterSequences
//                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
//                                NSLog(@"%@ %@ %@", substring, NSStringFromRange(substringRange), NSStringFromRange(enclosingRange));
//                            }];
    
    // demo3：编译器隐藏特性；
//    NSString *multiPartString = @"head "
//    @"part "
//    @"part "
//    @"part "
//    @"part "
//    @"part "
//    @"tail";
//    _someLabel.text = multiPartString;
    
    // demo4：去除后缀（搜索与删除）
//    NSString *srcString = @"hello9-2.jpg";
//    NSString *suffix = @".jpg";
//    NSRange suffixRange = [srcString rangeOfString:suffix options:NSAnchoredSearch|NSBackwardsSearch];
//    NSString *destString = [srcString stringByReplacingCharactersInRange:suffixRange withString:@""];
//    _someLabel.text = destString;
    
    // demo5：分解与连接
    NSString *srcString = @"0,1,2,3,4,5,6,7,8,9";
    NSArray *array = [srcString componentsSeparatedByString:@","];
    NSString *destString = [array componentsJoinedByString:@"-"];
    _someLabel.text = destString;
    
    // demo6：遍历目录
    NSError *error = nil;
    NSURL *cacheURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:&error];
    NSArray *properties = @[NSURLLocalizedNameKey, NSURLCreationDateKey];
    NSDirectoryEnumerator *dirEnumerator = [[NSFileManager defaultManager] enumeratorAtURL:cacheURL includingPropertiesForKeys:properties options:0 errorHandler:^BOOL(NSURL *url, NSError *error) {
        NSLog(@"error(%@)  %s", error, __func__);
        return YES;
    }];
    NSURL *fileURL = nil;
    NSString *name = nil;
    NSDate *date = nil;
    for (fileURL in dirEnumerator) {
        [fileURL getResourceValue:&name forKey:NSURLLocalizedNameKey error:nil];
        [fileURL getResourceValue:&date forKey:NSURLCreationDateKey error:nil];
        NSLog(@"name(%@) date(%@)  %s", name, date, __func__);
    }
}

// demo1:
- (NSString *)buildStringWithFormat:(NSString *)format,...{
    va_list ap;
    va_start(ap, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    return string;
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
