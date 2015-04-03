//
//  DLMethod2ViewController.m
//  Sample-Async
//
//  Created by Rnut on 4/3/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import "DLMethod2ViewController.h"

@interface DLMethod2ViewController ()
{
    NSMutableData *netData;
}
@end

@implementation DLMethod2ViewController
@synthesize Choosed;
- (void)viewDidLoad {
    [super viewDidLoad];
    Choosed  = [Review sharedReview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)start:(id)sender {
    
//    NSString* readme = @"https://dl.dropboxusercontent.com/u/7585756/smith.json";
    NSURL* url = [NSURL URLWithString:Choosed.Thumbnail_Url];
    
    Object* delegate = [[Object alloc] init];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration
                                         defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:delegate
                                                     delegateQueue:nil];
    
    NSURLSessionDataTask* task = [session dataTaskWithURL:url];
    [task resume];
    
    NSDate *start = [NSDate date];
    
    // Wait until the task is finished
    while (task.state == NSURLSessionTaskStateRunning)
    {
        NSTimeInterval timeInterval = [start timeIntervalSinceNow];
        if( fabs(timeInterval) > 3)
        {
            NSLog(@"Server response time is too long");
            [task cancel];
        }
    }
    
    if( [delegate.netData length] > 0)
    {
//        NSString* text = [[NSString alloc] initWithData:delegate.netData
//                                               encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", text);
        UIImage *img = [UIImage imageWithData:delegate.netData];
        self.ImageView.image = img;
    }
}


@end
