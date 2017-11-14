//
//  YJBaseVCtr.h
//  youjie
//
//  Created by kongfugen on 15/2/28.
//  Copyright (c) 2015年 youjie8.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface YJBaseVCtr : UIViewController

//nav背景
@property (nonatomic, strong) UIImageView*      mNavImgView;
//状态栏高度
@property (nonatomic, assign) CGFloat mIncrease;
//nav 高度
@property (nonatomic, assign) CGFloat mNavBarH;
//tabBar 高度
@property (nonatomic, assign) CGFloat mTabBarH;
//是否是dismissViewControllerAnimated进入
@property (nonatomic, assign) BOOL    isDismissing;
//成功回调
@property (nonatomic, copy) void (^successHandel)(void);


- (instancetype)init;
//load状态 接收点击事件
-(void)initWaitView;
//带aStr 接收点击事件
-(void)initWaitViewWithString:(NSString*)aStr;

//禁止交互
-(void)initBlockWaitWithString:(NSString*)aStr;
//导航栏接收点击事件
-(void)initBlockWaitUnderNavigationaBarWithString:(NSString*)aStr;

-(void)clearWaitView;

//确定
-(void)alertShow:(NSString *)message;
//alertView
-(void)alertShow:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle;

//设置backButton
-(void)initBackButton;
-(void)initBackButtonImage:(UIImage *)image;
-(void)setBackButton:(UIImage *)aImg withPress:(UIImage *)aPressImg;
-(void)back:(UIButton *)aBtn;

//标题
-(void)initTitleView:(NSString *)aTitleStr;
-(void)initTitleView:(NSString *)aTitleStr textColor:(UIColor *)textColor;
-(void)setTitleColor:(UIColor *)aColor;

//提示信息
-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration;
-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration offSetY:(CGFloat)offsety;


@end
