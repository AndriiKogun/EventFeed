//
//  AKVideoTableViewCell.h
//  TestTask
//
//  Created by Andrii on 4/12/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTableViewCell.h"

@interface AKVideoTableViewCell : AKTableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoHeight;

@end
