//
//  ViewController.h
//  Sample-Async
//
//  Created by Rnut on 4/1/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedService.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *ArrayObj;
}
@property(nonatomic,weak)IBOutlet UITableView *Tableview;
@property (strong ,nonatomic) NSMutableDictionary *cachedImages;
@end

