//
//  AKPostTableViewCell.m
//  TestTask
//
//  Created by Andrii on 4/12/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKPostTableViewCell.h"
#import "UIImageView+AFNetworking.h"

#import "AKPost.h"
#import "AKUser.h"

@implementation AKPostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setPost:(AKPost *)post {
    [super setPost:post];
    
    self.allCommentsLabel.text = @"It's comment";
    
}


@end
