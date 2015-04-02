//
//  FeedService.h
//  Sample-Async
//
//  Created by Rnut on 4/2/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Review.h"
@interface FeedService : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>{
    NSURLConnection * internalConnection;
    NSMutableData * container;
}
@property(nonatomic,copy)NSURLConnection *internalConnection;
@property(nonatomic,copy)NSURLRequest *request;
@property(nonatomic,copy)void (^completitionBlock) (NSMutableArray *listObj,NSError *err);


-(id)initWithCatagory:(NSString*)catagoryId;
-(void)start;
@end
