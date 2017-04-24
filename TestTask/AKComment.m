//
//  AKComment.m
//  TestTask
//
//  Created by Andrii on 4/20/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKComment.h"

@implementation AKComment

- (instancetype)initWithResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        
        self.dateOfPost = [[response objectForKey:@"date"] doubleValue];
        self.userID = [response objectForKey:@"from_id"];
        self.text = [response objectForKey:@"text"];
    }
    return self;
}

@end
