//
//  UIFont+CLTheme.m
//  Base_iOS_Project
//
//  Created by mengxianzhi on 2017/11/15.
//  Copyright © 2017年 mengxianzhi. All rights reserved.
//

#import "UIFont+CLTheme.h"

@implementation UIFont (CLTheme)

+(instancetype)lightFontWithSize:(CGFloat)size {
    if ([CLSystemHelper deviceSystemMajorVersion] < 9) {
        return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
    }
    return [UIFont fontWithName:@"PingFang-SC-Light" size:size];
}

+(instancetype)mediumFontWithSize:(CGFloat)size {
    if ([CLSystemHelper deviceSystemMajorVersion] < 9) {
        return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
    }
    return [UIFont fontWithName:@"PingFang-SC-Medium" size:size];
}

+(instancetype)regularFontWithSize:(CGFloat)size {
    if ([CLSystemHelper deviceSystemMajorVersion] < 9) {
        return [UIFont fontWithName:@"HelveticaNeue" size:size];
    }
    return [UIFont fontWithName:@"PingFang-SC-Regular" size:size];
}

@end
