//
//  AKImageTableViewCell.m
//  TestTask
//
//  Created by Andrii on 4/12/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKImageTableViewCell.h"
#import "UIImageView+AFNetworking.h"

#import "AKPost.h"
#import "AKUser.h"
#import "AKGroup.h"

@implementation AKImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(AKPost *)post {
    [super setPost:post];
    
    self.allCommentsLabel.text = @"It's Image";
    
    if (post.width) {
        self.imageHeightConstraint.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * (post.height / post.width);
    } else {
        self.imageHeightConstraint.constant = 0;
    }
    
    NSURLRequest *postImageRequest = [NSURLRequest requestWithURL:post.photo_604];
    
    [self.ownerPostImageView setImageWithURLRequest:postImageRequest
                                   placeholderImage:nil
                                            success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
      //  self.ownerPostImageView.image = image;

        [UIView transitionWithView:self.ownerPostImageView
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                               self.ownerPostImageView.image = image;
                               
                           } completion:nil];
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"Error %@",[error localizedDescription]);
    }];
}




@end
