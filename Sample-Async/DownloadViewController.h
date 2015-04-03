//
//  DownloadViewController.h
//  Sample-Async
//
//  Created by Rnut on 4/3/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"
@interface DownloadViewController : UIViewController<NSURLSessionDataDelegate,NSURLSessionDelegate,NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate,NSUserActivityDelegate>
@property(nonatomic,strong)Review *Choosed;
@property(nonatomic,weak)IBOutlet UIImageView *ImageView;
-(IBAction)downloadasNSURLSession:(id)sender;
@end
