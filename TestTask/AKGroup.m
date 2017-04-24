//
//  AKGroup.m
//  HomeTask_43_Client_Server_APIs_Part_1_Basics
//
//  Created by Andrii on 10/10/16.
//  Copyright © 2016 Andrii. All rights reserved.
//

#import "AKGroup.h"

@implementation AKGroup

- (instancetype)initWithResponse:(NSDictionary *)response {

    self = [super init];
    if (self) {
        
        self.name = [response objectForKey:@"name"];
        self.imgUrlMedium = [NSURL URLWithString:[response objectForKey:@"photo_100"]];
    }
    
    return self;
}
    
@end
