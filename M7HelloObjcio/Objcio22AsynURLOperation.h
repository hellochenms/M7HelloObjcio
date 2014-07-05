//
//  MObjcio22AsynURLOperation.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-5.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Objcio22AsynURLOperation : NSOperation
- (id)initWithUrlString:(NSString *)urlString;
@property (nonatomic, copy)     void (^progressHandler)(float progress);
@property (nonatomic, copy)     void (^completionHandler)(Objcio22AsynURLOperation *completionOperation);
@property (nonatomic, copy)     void (^errorHandler)(Objcio22AsynURLOperation *completionOperation, NSError *error);
@property (nonatomic, readonly) NSData *data;
@end
