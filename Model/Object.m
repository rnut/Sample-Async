//
//  Object.m
//  Sample-Async
//
//  Created by Rnut on 4/1/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import "Object.h"

@implementation Object

-(id)initWithURL:(NSString *)strURL{
    self = [super init];
    if (self) {
        url = strURL;
    }
    return self;
}


@end
