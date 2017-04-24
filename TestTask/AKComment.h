//
//  AKComment.h
//  TestTask
//
//  Created by Andrii on 4/20/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKObject.h"

@class AKUser;

@interface AKComment : AKObject

@property (strong, nonatomic) AKUser *user;

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *text;

@end
