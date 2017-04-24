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

    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 260) configuration:theConfiguration];
    [webView.scrollView setScrollEnabled:NO];
    
    webView.backgroundColor = [UIColor blackColor];
    webView.tintColor = [UIColor blackColor];

    NSURL *nsurl=[NSURL URLWithString:stringUrl];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webView loadRequest:nsrequest];
    [self.videoView addSubview:webView];
    
    
    
//    [self.webView.scrollView setScrollEnabled:NO];
//    self.webView.mediaPlaybackRequiresUserAction = NO;
//    
//    NSURL *url = [NSURL URLWithString:stringUrl];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self.webView loadRequest:request];
//    });
//    
    
    
    
    
    
    
}




@end
