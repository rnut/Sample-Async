//
//  Object.m
//  Sample-Async
//
//  Created by Rnut on 4/1/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import "Object.h"

@implementation Object
-(id)init{
    self = [super init];
    if (self) {
        _netData = [[NSMutableData alloc] init];
    }
    return self;
}
-(id)initWithURL:(NSString *)strURL{
    self = [super init];
    if (self) {
        url = strURL;
    }
    return self;
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [_netData appendData:data];
}
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if( error != nil)
        NSLog(@"Error: %@", error.description);
}
@end
