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
    
    NSString *keyCache = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    Review *temp = [ArrayObj objectAtIndex:indexPath.row];
    //if (!tableView.decelerating || !tableView.dragging) {
    
    if([self.cachedImages objectForKey:keyCache] != nil){
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *imm = [self.cachedImages valueForKey:keyCache];
            [cell.imageView setImage:imm];
        });
    }else{
        cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
//        char const * s = [keyCache  UTF8String];
//        dispatch_queue_t gQueue = dispatch_queue_create(s, 0);
        dispatch_queue_t gQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(gQueue, ^{
//            NSLog(@"index : %@ loading..",keyCache);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0ul), ^{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:temp.Thumbnail_Url]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (imgData) {
//                        NSLog(@"index : %@ ,update img",keyCache);
                        UIImage *image = [UIImage imageWithData:imgData];
                        if (image) {
                            
                            //if ([tableView indexPathForCell:cell].row == indexPath.row) {
                            
                            [self.cachedImages setObject:image forKey:keyCache];
                            //                        NSLog(@"iden : %@",keyCache);
                            //                        NSLog(@"cell : %@",temp.Thumbnail_Url);
                            cell.imageView.image = [self.cachedImages valueForKey:keyCache];
                            //}
                            
                        }
                    }
                    else{
                        NSLog(@"index : %@ ,data not complete",keyCache);
                    }
                });
            });
//            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:temp.Thumbnail_Url]];
            
        });
    }
    //}
    
    cell.textLabel.text = [NSString stringWithFormat:@"url : %@",temp.Thumbnail_Url];
//    NSLog(@"indexpath : %lu  , url : %@",indexPath.row,cell.textLabel.text);
    return  cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [Review setSharedReview:[ArrayObj objectAtIndex:indexPath.row]] ;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
