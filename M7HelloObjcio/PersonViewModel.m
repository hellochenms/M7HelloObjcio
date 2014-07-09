//
//  PersonViewModel.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "PersonViewModel.h"
#import "PersonModel.h"

@implementation PersonViewModel
- (id)initWithPersonModel:(PersonModel *)personModel{
    self = [super init];
    if (self) {
        [self reloadDataFromPersonModel:personModel];
    }
    
    return self;
}

- (void)reloadDataFromPersonModel:(PersonModel *)personModel{
    // name
    if ([personModel.salutation length] > 0) {
        self.nameText = [NSString stringWithFormat:@"%@ %@ %@", personModel.salutation, personModel.firstName, personModel.lastName];
    }else{
        self.nameText = [NSString stringWithFormat:@"%@ %@", personModel.firstName, personModel.lastName];
    }
    
    // birthDate
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy年M月d日";
    self.birthDateText = [formatter stringFromDate:personModel.birthDate];
}
@end
