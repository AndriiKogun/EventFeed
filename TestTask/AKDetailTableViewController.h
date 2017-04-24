//
//  AKDetailTableViewController.h
//  TestTask
//
//  Created by Andrii on 4/20/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKPost;

@interface AKDetailTableViewController : UITableViewController

@property (strong, nonatomic) NSString *groupID;
@property (strong, nonatomic) AKPost *post;

@end
