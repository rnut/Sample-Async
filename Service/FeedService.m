//
//  FeedService.m
//  Sample-Async
//
//  Created by Rnut on 4/2/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import "FeedService.h"

@implementation FeedService
@synthesize request,completitionBlock,internalConnection;

-(id)initWithCatagory:(NSString*)catagoryId{
    self = [super init];
    if (self) {
        request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mstage.truelife.com/women2014/api/music.php?method=getListMusic&limit=50&offset=0&category=%@",catagoryId]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:25.0f];
    }
    return self;
}
-(void)start{
    container = [[NSMutableData alloc] init];
    internalConnection = [[NSURLConnection alloc] initWithRequest:[self request] delegate:self startImmediately:YES];
}

#pragma mark NSURLConnectionDelegate methods
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [container appendData:data];
}

//If finish, return the data and the error nil
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if([self completitionBlock])
    {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:container options:NSJSONReadingMutableLeaves error:&error];
        for (NSDictionary *d in dict[@"response"][@"data"][@"items"][@"item"]) {
                Review *r = [[Review alloc] initWithContent_ID:[d objectForKey:@"content_id"] Thumbnail_URL:[d objectForKey:@"thumbnail"] Title:[d objectForKey:@"title"] View:[d objectForKey:@"view"] Share_Url:[d objectForKey:@"music"]];
                [temp addObject:r];
        }
        [self completitionBlock](temp,nil);
    }
    
    
//    [sharedConnectionList removeObject:self];
    
}

//If fail, return nil and an error
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    if([self completitionBlock])
        [self completitionBlock](nil,error);
    
//    [sharedConnectionList removeObject:self];
    
}


@end
