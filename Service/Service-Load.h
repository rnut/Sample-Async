//
//  Service-Load.h
//  Sample-Async
//
//  Created by Rnut on 4/1/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service_Load : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSURLConnection * internalConnection;
    NSMutableData * container;
}
@property (nonatomic,copy)NSURLConnection * internalConnection;
@property (nonatomic,copy)NSURLRequest *request;
@property (nonatomic,copy)void (^completitionBlock) (id obj, NSError * err);

-(id)initWithRequest:(NSURLRequest *)req;
-(void)start;
@end
