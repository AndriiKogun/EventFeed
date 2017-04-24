//
//  AKUser.m
//  TestTask
//
//  Created by Andrii on 4/13/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKUser.h"

@implementation AKUser

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.ID = [response objectForKey:@"id"];
        self.firstName = [response objectForKey:@"first_name"];
        self.lastName = [response objectForKey:@"last_name"];
        
        self.imgUrlSmall = [NSURL URLWithString:[response objectForKey:@"photo_50"]];
        self.imgUrlMedium = [NSURL URLWithString:[response objectForKey:@"photo_100"]];
        self.imgUrlBig = [NSURL URLWithString:[response objectForKey:@"photo_200"]];
    }
    return self;
}

@end
