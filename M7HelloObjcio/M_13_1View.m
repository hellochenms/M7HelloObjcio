//
//  M_13_1View.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "M_13_1View.h"
#import "PersonViewModel.h"

@interface M_13_1View()
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *birthDateLabel;
@end

@implementation M_13_1View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.bounds) - 20, 30)];
        _nameLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:_nameLabel];
        
        _birthDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameLabel.frame) + 10, CGRectGetWidth(self.bounds) - 20, 30)];
        _birthDateLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:_birthDateLabel];
    }
    return self;
}


#pragma mark - 
- (void)reloadDataFromViewModel:(PersonViewModel *)personViewModel{
    self.nameLabel.text = personViewModel.nameText;
    self.birthDateLabel.text = personViewModel.birthDateText;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
