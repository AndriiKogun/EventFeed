//
//  AKObject.h
//  TestTask
//
//  Created by Andrii on 4/12/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKObject : NSObject

@property (strong, nonatomic) NSString *ID;

@property (strong, nonatomic) NSURL *imgUrlBig;
@property (strong, nonatomic) NSURL *imgUrlMedium;
@property (strong, nonatomic) NSURL *imgUrlSmall;

@property (assign, nonatomic) NSTimeInterval dateOfPost;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
