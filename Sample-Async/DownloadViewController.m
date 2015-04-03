//
//  DownloadViewController.m
//  Sample-Async
//
//  Created by Rnut on 4/3/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController ()

@end

@implementation DownloadViewController
@synthesize Choosed;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Choosed  = [Review sharedReview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)downloadasNSURLSession:(id)sender{
    NSLog(@"url : %@",Choosed.Thumbnail_Url);

    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:Choosed.Thumbnail_Url]];
    
   
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError) {
                               if (data != nil) {
                                   UIImage *img = [UIImage imageWithData:data];
                                   if (img) {
                                       self.ImageView.image = img;
                                   }
                               }
                           }];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"location : %@",location);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
