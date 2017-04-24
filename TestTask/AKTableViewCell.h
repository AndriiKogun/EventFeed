//
//  AKPostTableViewCell.h
//  TestTask
//
//  Created by Infoservice on 4/18/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AKPostDelegate <NSObject>

- (void)commentButton:(UIButton *)sender;
- (void)likeButton:(UIButton *)sender;
- (void)sheetButton:(UIButton *)sender;

@end

@class AKPost;

@interface AKTableViewCell : UITableViewCell

@property (weak, nonatomic) id <AKPostDelegate> delegate;

@property (strong, nonatomic) AKPost *post;

@property (weak, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@property (weak, nonatomic) IBOutlet UILabel *ownerPostDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *likedByLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topCommentImageView;

@property (weak, nonatomic) IBOutlet UIImageView *bottomCommentImageView;
@property (weak, nonatomic) IBOutlet UILabel *topCommentatorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomCommentatorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *allCommentsLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

- (IBAction)actionSheetButton:(UIButton *)sender;
- (IBAction)actionLikeButton:(UIButton *)sender;
- (IBAction)actionCommentButton:(UIButton *)sender;


@end
