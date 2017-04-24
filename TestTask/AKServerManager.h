//
//  AKServerManager.h
//  HomeTask_43_Client_Server_APIs_Part_1_Basics
//
//  Created by Andrii on 10/9/16.
//  Copyright © 2016 Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@class AKUser, AKAccessToken;

@interface AKServerManager : AFHTTPSessionManager

@property (strong, nonatomic) AKAccessToken *accessToken;

+ (AKServerManager *)sharedManager;


#pragma mark - User


- (NSURLSessionDataTask *)getUserWithUserID:(NSString *)userID
                                resultBlock:(void(^)(AKUser *user, NSError *error))block;


- (NSURLSessionDataTask *)getWallPostsWithUserID:(NSString *)userID
                                          offset:(NSInteger)offset
                                           count:(NSInteger)count
                                     resultBlock:(void(^)(NSArray *posts, NSError *error, NSInteger statusCode))block;

- (NSURLSessionDataTask *)getCommentsFromGroupID:(NSString *)groupID
                                      withPostID:(NSString *)postID
                                      withOffset:(NSInteger)offset
                                           count:(NSInteger)count
                                     resultBlock:(void(^)(NSArray *comments, NSError *error))block;
@end
