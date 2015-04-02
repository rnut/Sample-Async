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

    FeedService *feed = [[FeedService alloc] initWithCatagory:@"2"];
    [feed setCompletitionBlock:^(NSMutableArray *list, NSError *err) {
        if (err == nil && list != nil) {
            ArrayObj = list;
            [self.Tableview reloadData];
        }
    }];
    [feed start];
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
    Review *temp = [ArrayObj objectAtIndex:indexPath.row];
    if (!tableView.decelerating || !tableView.dragging) {
        if([self.cachedImages objectForKey:identifier] != nil){
            cell.imageView.image = [self.cachedImages valueForKey:identifier];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
            
            char const * s = [identifier  UTF8String];
//            dispatch_queue_t gQueue = dispatch_queue_create(s, 0);
            dispatch_queue_t gQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(gQueue, ^{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:temp.Thumbnail_Url]];
                if (imgData) {
                    UIImage *image = [UIImage imageWithData:imgData];
                    if (image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if ([tableView indexPathForCell:cell].row == indexPath.row) {
                                
                                [self.cachedImages setValue:image forKey:identifier];
                                NSLog(@"iden : %@",identifier);
                                cell.imageView.image = [self.cachedImages valueForKey:identifier];
                            }
                        });
                    }
                }
            });
        }
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"url : %@",temp.Thumbnail_Url];
    return  cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
