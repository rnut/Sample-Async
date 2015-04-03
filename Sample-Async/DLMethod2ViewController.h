//
//  DLMethod2ViewController.h
//  Sample-Async
//
//  Created by Rnut on 4/3/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"
#import "Object.h"
@interface DLMethod2ViewController : UIViewController<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
@property(nonatomic,strong)Review *Choosed;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
- (IBAction)start:(id)sender;

@end
