//
//  AKAccessToken.h
//  Lesson_44_Client Server_APIs_Part 2 
//
//  Created by Andrii on 10/15/16.
//  Copyright © 2016 Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKAccessToken : NSObject

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDate *expiredDate;
@property (strong, nonatomic) NSString *userID;

@end
