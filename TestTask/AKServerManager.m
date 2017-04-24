//
//  AKServerManager.m
//  HomeTask_43_Client_Server_APIs_Part_1_Basics
//
//  Created by Andrii on 10/9/16.
//  Copyright © 2016 Andrii. All rights reserved.
//

#import "AKServerManager.h"
#import "AFNetworking.h"
#import "AKAccessToken.h"

#import "AKPost.h"
#import "AKUser.h"
#import "AKGroup.h"
#import "AKComment.h"

static NSString * const AKBaseURL = @"https://api.vk.com/method/";
static NSString *myID = @"62700252";
static NSString *APIv = @"5.59";

@interface AKServerManager ()

@end

@implementation AKServerManager

+ (AKServerManager *)sharedManager {
    static AKServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AKServerManager alloc]initWithBaseURL:[NSURL URLWithString:AKBaseURL]];
    });
    return manager;
}

#pragma mark - User

- (NSURLSessionDataTask *)getUserWithUserID:(NSString *)userID
                                resultBlock:(void(^)(AKUser *user, NSError *error))block {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userID,                                     @"user_ids",
                                @"photo_50,photo_100,photo_200",            @"fields",
                                @5.63,                                      @"v",nil];
    
    return [[AKServerManager sharedManager] GET:@"users.get" parameters:parameters progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        
        NSArray *responseArray = [responseObject objectForKey:@"response"];
        AKUser *user = [[AKUser alloc]initWithResponse:[responseArray firstObject]];
        
        block(user,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        block(nil,error);
    }];
}

- (NSURLSessionDataTask *)getGroupWithID:(NSString *)groupID
                             resultBlock:(void(^)(AKGroup *group, NSError *error))block {
    
    if ([groupID containsString:@"-"]) {
        groupID = [groupID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                groupID,                     @"group_id",
                                @5.59,                       @"v",nil];
    
    return [[AKServerManager sharedManager] GET:@"groups.getById" parameters:parameters progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        
        NSArray *responseArray = [responseObject objectForKey:@"response"];
        NSDictionary *responseDictionary = [responseArray firstObject];
        AKGroup *group = [[AKGroup alloc] initWithResponse:responseDictionary];
        
        if (block) {
            block(group, nil);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

#pragma mark - Post

- (NSURLSessionDataTask *)getWallPostsWithUserID:(NSString *)userID
                                          offset:(NSInteger)offset
                                           count:(NSInteger)count
                                     resultBlock:(void(^)(NSArray *posts, NSError *error, NSInteger statusCode))block {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userID,                 @"owner_id",
                                @(offset),              @"offset",
                                @(count),               @"count",
                                //@"others",              @"filter",owner
                                @"owner",               @"filter",
                                @(1),                   @"extended",
                                @5.63,                  @"v",nil];
    
    return [[AKServerManager sharedManager] GET:@"wall.get" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
       // NSURL *url = task.currentRequest.URL;
        //NSString *string = [url absoluteString];
//        NSLog(@"//////////////////////////////////%@",string);
        
      //  NSLog(@"%@", responseObject);
        
        
        NSDictionary *response = [responseObject objectForKey:@"response"];
        NSArray *items = [response objectForKey:@"items"];
        
        NSMutableArray *posts = [NSMutableArray array];
        
        dispatch_group_t myGroup = dispatch_group_create();
        
        for (id object in items) {
            if ([object isKindOfClass:[NSDictionary class]]) {
                AKPost *wallPost = [[AKPost alloc]initWithResponse:object];
                
                    dispatch_group_enter(myGroup);
                
                if ([wallPost.ownerID containsString:@"-"]) {
                    [self getGroupWithID:wallPost.ownerID resultBlock:^(AKGroup *group, NSError *error) {
                        wallPost.group = group;
                        [posts addObject:wallPost];
                        
                        dispatch_group_leave(myGroup);
                    }];
                    
                } else {
                    [self getUserWithUserID:wallPost.ownerID resultBlock:^(AKUser *user, NSError *error) {
                        wallPost.user = user;
                        [posts addObject:wallPost];
                        
                        dispatch_group_leave(myGroup);
                    }];
                }
            }
        }
        
        dispatch_group_notify(myGroup, dispatch_get_main_queue(), ^{
            block(posts,nil,0);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
        
        NSInteger statusCode = 0;
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        
        if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
            statusCode = httpResponse.statusCode;
        }
        
        if (block) {
            block([NSArray array],error,statusCode);
        }
    }];
    
    return nil;
}

#pragma mark - Comment

- (NSURLSessionDataTask *)getCommentsFromGroupID:(NSString *)groupID
                                      withPostID:(NSString *)postID
                                      withOffset:(NSInteger)offset
                                           count:(NSInteger)count
                                     resultBlock:(void(^)(NSArray *comments, NSError *error))block {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                groupID,                @"owner_id",
                                postID,                 @"post_id",
                                @(count),               @"count",
                                @(offset),              @"offset",
                                @1,                     @"need_likes",
                                @"desc",                @"sort",
                                self.accessToken.token, @"access_token",
                                @5.59,                  @"v",nil];;
    
    return [[AKServerManager sharedManager] GET:@"wall.getComments"
                                     parameters:parameters
                                       progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        
        NSMutableArray *comments = [NSMutableArray array];
        NSDictionary *response = [responseObject objectForKey:@"response"];
        NSArray *items = [response objectForKey:@"items"];
        
        dispatch_group_t group = dispatch_group_create();
        
        for (NSDictionary *dictionary in items) {
            AKComment *comment = [[AKComment alloc]initWithResponse:dictionary];
            
            dispatch_group_enter(group);
            
            [self getUserWithUserID:comment.userID resultBlock:^(AKUser *user, NSError *error) {
                comment.user = user;
                [comments addObject:comment];
                
                dispatch_group_leave(group);
            }];
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            block(comments,nil);
        });
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}


@end
