//
//  AKCommentTableViewCell.h
//  TestTask
//
//  Created by Andrii on 4/20/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTableViewCell.h"

@class AKComment;

@interface AKCommentTableViewCell : AKTableViewCell

@property (strong, nonatomic) AKComment *comment;

@end
