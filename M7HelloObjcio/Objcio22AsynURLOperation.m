//
//  MObjcio22AsynURLOperation.m
//  M7HelloObjcio
//
//  Created by Chen Meisong on 14-7-5.
//  Copyright (c) 2014年 chenmsm2. All rights reserved.
//

#import "Objcio22AsynURLOperation.h"

@interface Objcio22AsynURLOperation()<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, copy) NSString    *urlString;
@property (nonatomic) NSURLConnection   *connection;
@property (nonatomic) BOOL              isExecuting;
@property (nonatomic) BOOL              isFinished;
@property (nonatomic) long long         expectedContentLength;
@property (nonatomic) NSMutableData     *buffer;
@property (nonatomic) NSData            *data;
@end

@implementation Objcio22AsynURLOperation
- (id)initWithUrlString:(NSString *)urlString{
    self = [super init];
    if (self) {
        self.urlString = urlString;
    }
    
    return self;
}

- (void)start{
    @autoreleasepool {
        self.isFinished = NO;
        self.isExecuting = YES;
        if (self.urlString) {
            __weak typeof(self) weakSelf = self;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                weakSelf.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weakSelf.urlString]] delegate:weakSelf];
            }];
        }
    }
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"isMainThread(%d)  %s", [NSThread isMainThread], __func__);
    self.expectedContentLength = response.expectedContentLength;
    self.buffer = [NSMutableData data];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.buffer appendData:data];
    if (self.progressHandler) {
        self.progressHandler([self.buffer length] * 1.0 / self.expectedContentLength);
    }
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"isMainThread(%d)  %s", [NSThread isMainThread], __func__);
    self.data = self.buffer;
    self.buffer = nil;
    if (self.completionHandler) {
        self.completionHandler(self);
    }
    self.isExecuting = NO;
    self.isFinished = YES;
}
#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    self.buffer = nil;
    if (self.errorHandler) {
        self.errorHandler(self, error);
    }
    self.isExecuting = NO;
    self.isFinished = YES;
}

#pragma mark -
- (BOOL)isConcurrent{
    return YES;
}
- (void)setIsExecuting:(BOOL)isExecuting{
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = isExecuting;
    [self didChangeValueForKey:@"isExecuting"];
}
- (void)setIsFinished:(BOOL)isFinished{
    [self willChangeValueForKey:@"isFinished"];
    _isFinished = isFinished;
    [self didChangeValueForKey:@"isFinished"];
}

#pragma mark -
- (void)cancel{
    [super cancel];
    [self.connection cancel];
    self.connection = nil;
    self.buffer = nil;
    self.data = nil;
    self.isExecuting = NO;
    self.isFinished = YES;
}
@end
