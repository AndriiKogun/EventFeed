//
//  AKGroup.h
//  HomeTask_43_Client_Server_APIs_Part_1_Basics
//
//  Created by Andrii on 10/10/16.
//  Copyright © 2016 Andrii. All rights reserved.
//

#import "AKObject.h"


@interface AKGroup : AKObject

@property (strong, nonatomic) NSString *name;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
