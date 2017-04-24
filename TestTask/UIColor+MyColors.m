//
//  UIColor+MyColors.m
//  TestTask
//
//  Created by Andrii on 4/13/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "UIColor+MyColors.h"

@implementation UIColor (MyColors)

+ (UIColor *)myYellowColor {
    return [UIColor colorWithRed:252.0 / 255 green:188.0 / 255 blue:10.0 / 255 alpha:1.0];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
