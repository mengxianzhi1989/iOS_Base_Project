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
    DLog(@"\n UIButton点击事件 VC_Name = %@的%@被执行",NSStringFromClass([target class]),NSStringFromSelector(action));
}

@end
