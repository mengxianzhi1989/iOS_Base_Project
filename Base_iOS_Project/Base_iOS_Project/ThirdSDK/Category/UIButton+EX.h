//
//  UIButton+EX.h
//  CarFinancing
//
//  Created by mengxianzhi on 11/3/15.
//  Copyright (c) 2015 com.mljr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EX)

@property (strong,nonatomic) NSString *hiddenText;

- (void)setHiddenText:(NSString *)hnText;
- (NSString *)hiddenText;

+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title  titleColor:(UIColor *)color cornerRadius:(CGFloat)radius backGroudColor:(UIColor *)bgColor;
+(UIButton *)backBtnWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color;
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title colors:(NSArray *)colors;
+ (UIButton *)buttonWithImageFrame:(CGRect)frame imageName:(NSString *)imageName;
@end
