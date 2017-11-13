//
//  YJBaseVCtr.h
//  youjie
//
//  Created by kongfugen on 15/2/28.
//  Copyright (c) 2015年 youjie8.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface YJBaseVCtr : UIViewController

//背景view
@property (nonatomic, strong) UIImageView*      mBackGroudImageView;
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
//waitView
-(void)initWaitView;
//带提示的等待
-(void)initWaitViewWithString:(NSString*)aStr;
-(void)clearWaitView;
//block wait view
-(void)initBlockWaitWithString:(NSString*)aStr;
-(void)initBlockWaitUnderNavigationaBarWithString:(NSString*)aStr;
-(void)clearBlockWaitView;
-(void)alertShow:(NSString *)message;
-(void)alertShow:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle;
//backButton
-(void)initBackButton;
-(void)initBackButtonImage:(UIImage *)image;
-(void)setBackButton:(UIImage *)aImg withPress:(UIImage *)aPressImg;
-(void)back:(UIButton *)aBtn;

//TitleView
-(void)initTitleView:(NSString *)aTitleStr;

-(void)initTitleView:(NSString *)aTitleStr textColor:(UIColor *)textColor;
-(void)setTitleColor:(UIColor *)aColor;

//提示信息
-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration;
-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration offSetY:(CGFloat)offsety;


@end
