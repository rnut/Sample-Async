//
//  Review.m
//  Sample-Async
//
//  Created by Rnut on 4/2/2558 BE.
//  Copyright (c) 2558 Rnut. All rights reserved.
//

#import "Review.h"
static NSMutableArray *sharedReviewList = nil;
static Review *sharedReview = nil;
@implementation Review


-(id)initWithContent_ID:(NSString *)conId Thumbnail_URL:(NSString*)thumbUrl Title:(NSString*)title View:(NSString*)view Share_Url:(NSString*)shareUrl{
    self = [super init];
    if (self) {
        [self setContent_Id:conId];
        [self setThumbnail_Url:thumbUrl];
        [self setTitle:title];
        [self setView:view];
        [self setShare_Url:shareUrl];
    }
    return self;
}
+(id)sharedReviewList{
    if (sharedReviewList == nil) {
        sharedReviewList = [[NSMutableArray alloc] init];
    }
    return sharedReviewList;
}
+(id)sharedReview{
    if (sharedReview == nil) {
        sharedReview = [[Review alloc] init];
    }
    return sharedReview;
}
+(id)setSharedReview:(Review*)changed{
    if (changed == nil) {
        sharedReview = [[Review alloc] init];
    }
    else sharedReview = changed;
    return sharedReview;
}
@end
