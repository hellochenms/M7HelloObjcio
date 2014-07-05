//
//  AsynURLOperation.h
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-5.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import <Foundation/Foundation.h>

// NS的注释中有下面一段，可见schedule到线程只负责delegate的通知，而下载会在别的线程；
/* Scheduling of an NSURLConnection specifies the context in
 which delegate callbacks will be made, but the actual IO may
 occur on a separate thread and should be considered an
 implementation detail.*/
// 由此可知，connection直接schedule到主线程即可，这样就不用再delegate方法中派发到主线程通知UI了；
// 所以本类的写法就有点啰嗦了，按objccn.io 2-2中的写法确实更好；

@interface _MyDeprecatedAsynURLOperation : NSOperation
- (id)initWithUrlString:(NSString *)urlString;
@property (nonatomic, copy)     void (^progressHandler)(float progress);
@property (nonatomic, copy)     void (^completionHandler)(_MyDeprecatedAsynURLOperation *completionOperation);
@property (nonatomic, copy)     void (^errorHandler)(_MyDeprecatedAsynURLOperation *completionOperation, NSError *error);
@property (nonatomic, readonly) NSData *data;
@end
