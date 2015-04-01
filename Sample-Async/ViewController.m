//
//  ViewController.m
//  Sample-Async
//
//  Created by Rnut on 4/1/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import "ViewController.h"
#import "Service-Load.h"
@interface ViewController ()
{
//    UIView *loadingView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cachedImages = [[NSMutableDictionary alloc] init];
//    loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    [loadingView setCenter:self.view.center];
//    [loadingView setBackgroundColor:[UIColor blackColor]];
    
   
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&hl=th&q=steve&rsz=5"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0f];
    Service_Load * connection = [[Service_Load alloc]initWithRequest:req];
    
    [connection setCompletitionBlock:^(id obj, NSError *err) {
        
        if (!err) {
            NSError *err;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableLeaves error:&err];
            if (err == nil) {
//                [loadingView removeFromSuperview];
                ArrayObj = [[dict objectForKey:@"responseData"] objectForKey:@"results"];
                [self.Tableview reloadData];
            }
        } else {
            NSLog(@"err");
        }
        
    }];
    [connection start];
//    [self.view addSubview:loadingView];
    
}
#pragma matableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ArrayObj count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    
    NSString *identifier = [NSString stringWithFormat:@"Cell%ld",(long)indexPath.row];
    
    if([self.cachedImages objectForKey:identifier] != nil){
        cell.imageView.image = [self.cachedImages valueForKey:identifier];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
        
        char const * s = [identifier  UTF8String];
        dispatch_queue_t gQueue = dispatch_queue_create(s, 0);
//        dispatch_queue_t gQueue = dispatch_queue_create("downloadQue", NULL);
        dispatch_async(gQueue, ^{
            NSString *strURL = [[ArrayObj objectAtIndex:indexPath.row] objectForKey:@"tbUrl"];
            NSURL *url = [NSURL URLWithString:strURL];
            
            NSData *imgData = [NSData dataWithContentsOfURL:url];
            if (imgData) {
                UIImage *image = [UIImage imageWithData:imgData];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //code from http://kemal.co/index.php/2013/02/loading-images-asynchronously-on-uitableview/
                        if ([tableView indexPathForCell:cell].row == indexPath.row) {
                            
                            [self.cachedImages setValue:image forKey:identifier];
                            
                            cell.imageView.image = [self.cachedImages valueForKey:identifier];
                        }
                        //---------
                        
                        //                    cell.imageView.image = image;
                        
                        //from stack over flow
                        //                    UITableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        //                    if (updateCell)
                        //                        updateCell.imageView.image = image;
                        //-------------------------------------
                    });
                }
            }
        });
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"url : %@",[[ArrayObj objectAtIndex:indexPath.row] objectForKey:@"url"]];
    
    
    return  cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
