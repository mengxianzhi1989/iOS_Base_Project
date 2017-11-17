//
//  YJBaseVCtr.h
//  youjie
//
//  Created by mengxianzhi on 16/2/28.
//  Copyright (c) 2015年 youjie8.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface YJBaseVCtr : UIViewController

//nav背景
@property (nonatomic, strong) UIImageView *mNavImgView;
//状态栏高度
@property (nonatomic, assign) CGFloat mIncrease;
//nav 高度
@property (nonatomic, assign) CGFloat mNavBarH;
//tabBar 高度
@property (nonatomic, assign) CGFloat mTabBarH;
//是否是dismissViewControllerAnimated进入
@property (nonatomic, assign) BOOL isDismissing;
//成功回调
@property (nonatomic, copy) void (^successHandel)(void);

#pragma mark - init初始化
- (instancetype)init;
#pragma mark - load状态 接收点击事件
-(void)initWaitView;
#pragma mark - 带aStr 接收点击事件
-(void)initWaitViewWithString:(NSString*)aStr;

#pragma mark - 当前Window禁止交互
-(void)initBlockWaitWithString:(NSString*)aStr;
#pragma mark - 导航栏接收点击事件的提示信息
-(void)initBlockWaitUnderNavigationaBarWithString:(NSString*)aStr;
#pragma mark - 清除提示信息
-(void)clearWaitView;

#pragma mark - 弹出框
-(void)alertShow:(NSString *)message;
#pragma mark - AlertView
-(void)alertShow:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle;
#pragma mark - 设置BackButton
-(void)initBackButton;
#pragma mark - 设置BackButton+Image
-(void)initBackButtonImage:(UIImage *)image;
#pragma mark - 设置BackButton+NoneImage+HighlightedImage
-(void)setBackButton:(UIImage *)aImg withPress:(UIImage *)aPressImg;
#pragma mark - 返回事件
-(void)backAction:(UIButton *)aBtn;
#pragma mark - 设置Title
-(void)initTitleView:(NSString *)aTitleStr;
#pragma mark - 设置加字体颜色
-(void)initTitleView:(NSString *)aTitleStr textColor:(UIColor *)textColor;
#pragma mark - 提示信息View
-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration;
#pragma mark - 提示信息View aDuration上线偏移量越大越靠上
-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration offSetY:(CGFloat)offsety;

@end

