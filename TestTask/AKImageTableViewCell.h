//
//  AKImageTableViewCell.h
//  TestTask
//
//  Created by Andrii on 4/12/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTableViewCell.h"

@class AKPost;

@interface AKImageTableViewCell : AKTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ownerPostImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;

@end
