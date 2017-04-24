//
//  AKCommentTableViewCell.m
//  TestTask
//
//  Created by Andrii on 4/20/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKCommentTableViewCell.h"

#import "AKComment.h"
#import "AKUser.h"

@implementation AKCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setComment:(AKComment *)comment {
    _comment = comment;
    
    __block NSString *name = nil;
    __block NSString *dateOfPost = nil;//
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static NSDateFormatter *formatter = nil;
        if (!formatter) {
            formatter = [[NSDateFormatter alloc]init];
        }
        
        [formatter setDateFormat:@"MMMM dd 'at' HH:mm"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:comment.dateOfPost];
        
        dateOfPost = [formatter stringFromDate:date];
        name = [NSString stringWithFormat:@"%@ %@", comment.user.firstName, comment.user.lastName];
            
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ownerName.text = name;
            self.ownerPostDateLabel.text = dateOfPost;
        });
    });
    
    
    self.ownerTextLabel.text = comment.text;
    
}

@end
