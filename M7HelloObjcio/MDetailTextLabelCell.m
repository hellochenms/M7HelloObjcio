//
//  _tempTableViewCell.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-15.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "MDetailTextLabelCell.h"

@interface MDetailTextLabelCell()
@property (nonatomic) MDetailTextLabelSingleton *data;
@end

@implementation MDetailTextLabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.frame = CGRectMake(10, 0, 200, 30);
    }
    return self;
}

- (void)reloadData:(MDetailTextLabelSingleton *)data{
    [self.data removeObserver:self forKeyPath:@"num"];
    self.data = data;
    [self.data addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"num"]) {
        BOOL isNil = (arc4random() % 2 == 0);
//        坑：使用UITableViewCell的原生子view detailTextLabel时，如果将其text置为nil，再将text置为某字符串，字符串不显示，可能系统在text == nil时对该view的frame做了处理，一直到下次该cell被reload时text才会再显示；
//        由此方式一是没数据时不将text置nil，而是置@" "（有空格不是空串）；
//        方式二就是不使用detailTextLabel，用自定义的子view；
        
        // 再注：detailTextLabel的优势是当cell进入编辑模式时，能很好的调整位置；
        // 如果是自定义的子view，很容易和系统的子view（如拖动排序的view）重叠；
        // 如果有编辑需求，还是可以用detailTextLabel，而数据置空时用置@" "替代；
        
        if (isNil) {
            self.detailTextLabel.text = nil;
        }else{
            self.detailTextLabel.text = [NSString stringWithFormat:@"%d", _data.num];
        } 
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc{
    [self.data removeObserver:self forKeyPath:@"num"];
}

@end
