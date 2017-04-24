//
//  UIView+MyCell.m
//  TestTask
//
//  Created by Andrii on 4/20/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "UIView+MyCell.h"

@implementation UIView (MyCell)

- (UITableViewCell *)superCell {
    if (!self.superview) {
        return nil;
        
    } else if ([self.superview isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell *) self.superview;
        
    } else {
        return [self.superview superCell];
    }
}

@end
