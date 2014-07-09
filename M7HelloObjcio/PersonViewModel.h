//
//  PersonViewModel.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-9.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonModel;

@interface PersonViewModel : NSObject
@property (nonatomic, copy) NSString *nameText;
@property (nonatomic, copy) NSString *birthDateText;
- (id)initWithPersonModel:(PersonModel *)personModel;
- (void)reloadDataFromPersonModel:(PersonModel *)personModel;
@end
