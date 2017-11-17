//
//  MUIButton.m
//  Base_iOS_Project
//
//  Created by mengxianzhi on 2017/11/18.
//  Copyright © 2017年 mengxianzhi. All rights reserved.
//

#import "MUIButton.h"

@implementation MUIButton

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    [super sendAction:action to:target forEvent:event];
    
    DLog(@"target = %@ --- action = %@",target,NSStringFromSelector(action));
}

@end
