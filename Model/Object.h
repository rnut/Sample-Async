//
//  Object.h
//  Sample-Async
//
//  Created by Rnut on 4/1/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Object : NSObject<NSURLSessionDataDelegate>
{
    NSString *url;
}
@property(nonatomic,strong)NSMutableData *netData;
-(id)initWithURL:(NSString *)strURL;
@end
