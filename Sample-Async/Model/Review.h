//
//  Review.h
//  Sample-Async
//
//  Created by Rnut on 4/2/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject
{

}
@property(nonatomic,strong) NSString *Content_Id;
@property(nonatomic,strong) NSString *Thumbnail_Url;
@property(nonatomic,strong) NSString *Title;
@property(nonatomic,strong) NSString *View;
@property(nonatomic,strong) NSString *Share_Url;
+(id)sharedReviewList;
-(id)initWithContent_ID:(NSString *)conId Thumbnail_URL:(NSString*)thumbUrl Title:(NSString*)title View:(NSString*)view Share_Url:(NSString*)shareUrl;
@end
