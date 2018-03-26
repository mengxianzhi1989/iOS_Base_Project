//
//  UIButton+EX.m
//  CarFinancing
//
//  Created by mengxianzhi on 11/3/15.
//  Copyright (c) 2015 com.mljr. All rights reserved.
//

#import "UIButton+EX.h"

static void *strKey = &strKey;

#import <objc/runtime.h>


@implementation UIButton (EX)


@dynamic hiddenText;

- (void)setHiddenText:(NSString *)hText{
    objc_setAssociatedObject(self, &strKey, hText, OBJC_ASSOCIATION_COPY);
}

- (NSIndexPath *)hiddenText{
    return objc_getAssociatedObject(self, &strKey);
}

+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color cornerRadius:(CGFloat)radius backGroudColor:(UIColor *)bgColor {
    
    UIButton *btn = [[self alloc]initWithFrame:frame];
    [btn.layer setMasksToBounds:YES];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setBackgroundImage:[PublicClass createImageWithColor:bgColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = radius;
    return btn;
}

+(UIButton *)backBtnWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color{
 
    UIButton *btn = [[self alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:16.0];
    return btn;
}

+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title colors:(NSArray *)colors
{
    UIButton *btn = [[self alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:colors[0] forState:UIControlStateNormal];
    [btn setTitleColor:colors[1] forState:UIControlStateSelected];
    return btn;
    
//    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(15,kFootViewH - kButtonH - 11, kScreenWidth - 30, kButtonH)];
//    [confirmButton setTitle:@"保存" forState:UIControlStateNormal];
//    [confirmButton setBackgroundImage:[PublicClass createImageWithColor:UIColorFromRGB(0x4677ea)] forState:UIControlStateNormal];
//    [confirmButton addTarget:self action:@selector(reqAddCustomerAction) forControlEvents:UIControlEventTouchUpInside];
    
}

+ (UIButton *)buttonWithImageFrame:(CGRect)frame imageName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton backBtnWithFrame:frame
                                            title:nil
                                       titleColor:UIColorFromRGB(0x00a0e9)];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

@end
