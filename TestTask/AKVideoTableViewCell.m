//
//  AKVideoTableViewCell.m
//  TestTask
//
//  Created by Andrii on 4/12/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKVideoTableViewCell.h"

#import <WebKit/WebKit.h>

static NSString *stringUrl = @"https://www.youtube.com/watch?v=8r5ocJ_-UWI";

@implementation AKVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setPost:(AKPost *)post {
    [super setPost:post];
    
    self.allCommentsLabel.text = @"It's Video";
    self.videoHeight.constant = 285;
    
    [self.webView.scrollView setScrollEnabled:NO];
    self.webView.mediaPlaybackRequiresUserAction = NO;
    
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}




@end
