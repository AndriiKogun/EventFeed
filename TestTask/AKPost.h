//
//  AKWallPost.h
//  HomeTask_43_Client_Server_APIs_Part_1_Basics
//
//  Created by Andrii on 10/11/16.
//  Copyright © 2016 Andrii. All rights reserved.
//

#import "AKObject.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AKPostType) {
    AKPostTypeComment,
    AKPostTypeImage,
    AKPostTypeVideo
};

@class AKUser, AKGroup;

@interface AKPost : AKObject

@property (assign, nonatomic) AKPostType type;

@property (strong, nonatomic) AKUser *user;
@property (strong, nonatomic) AKGroup *group;

@property (strong, nonatomic) NSString *ownerID;
@property (assign, nonatomic) NSInteger count;

@property (strong, nonatomic) NSString *text;

@property (assign, nonatomic) NSInteger likesCount;
@property (assign, nonatomic) NSInteger comentsCount;

@property (strong, nonatomic) NSURL *photo_130;
@property (strong, nonatomic) NSURL *photo_320;
@property (strong, nonatomic) NSURL *photo_640;

@property (strong, nonatomic) NSURL *photo_604;
@property (strong, nonatomic) NSURL *photo_807;
@property (strong, nonatomic) NSURL *photo_1280;

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

@end
