//
//  AKTableViewCell.m
//  TestTask
//
//  Created by Infoservice on 4/18/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKPostTableViewCell.h"

#import "UIImageView+AFNetworking.h"

#import "AKPost.h"
#import "AKUser.h"
#import "AKGroup.h"

@implementation AKTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(AKPost *)post {
    _post = post;
    
    __block NSString *name = nil;
    __block NSString *dateOfPost = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static NSDateFormatter *formatter = nil;
        if (!formatter) {
            formatter = [[NSDateFormatter alloc]init];
        }
        
        [formatter setDateFormat:@"MMMM dd 'at' HH:mm"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:post.dateOfPost];
        
        dateOfPost = [formatter stringFromDate:date];
        
        if (post.user) {
            name = [NSString stringWithFormat:@"%@ %@", post.user.firstName, post.user.lastName];
            
        } else {
            name = post.group.name;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ownerName.text = name;
            self.ownerPostDateLabel.text = dateOfPost;
        });
    });
    
    
    self.ownerTextLabel.text = post.text;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:post.user.imgUrlMedium];
    
    if (post.user) {
        request = [NSURLRequest requestWithURL:_post.user.imgUrlMedium];
        
    } else {
        request = [NSURLRequest requestWithURL:_post.group.imgUrlMedium];
    }
    
    self.ownerImageView.image = nil;

    [self.ownerImageView setImageWithURLRequest:request
                               placeholderImage:nil
                                        success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CALayer *imageLayer = self.ownerImageView.layer;
            imageLayer.cornerRadius = 10;
            imageLayer.masksToBounds = YES;
            self.ownerImageView.image = image;
            
        });
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"Error %@",[error localizedDescription]);
    }];
}

#pragma mark - AKPostDelegate

- (IBAction)performSheet:(UIButton *)sender {
    [self.delegate sheetHandler:sender];
}

- (IBAction)performLike:(UIButton *)sender {
    [self.delegate likeHandler:sender];
}

- (IBAction)performComment:(UIButton *)sender {
    [self.delegate commentHandler:sender];
}


@end
