//
//  YJBaseVCtr.h
//  youjie
//
//  Created by mengxianzhi on 16/2/28.
//  Copyright (c) 2015年 mljr.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface YJBaseVCtr : UIViewController

//是否监听网络加载状态 NO:不监听 YES:则当前页面请求完成时才可以左滑返回
@property (nonatomic,assign) BOOL isListenerLoading;
//是否正在进行网络请求
@property (assign,nonatomic) BOOL isLoading;
//nav背景
@property (nonatomic, strong) UIImageView *mNavImgView;
//状态栏高度
@property (nonatomic, assign) CGFloat mIncrease;
//nav高度
@property (nonatomic, assign) CGFloat mNavBarH;
//tabBar 高度
@property (nonatomic, assign) CGFloat mTabBarH;
//是否是dismissViewControllerAnimated进入
@property (nonatomic, assign) BOOL isDismissing;
//成功回调
@property (nonatomic, copy) void (^successHandel)(void);
@property (nonatomic, copy) void (^doActionHandel)(void);
#pragma mark - init初始化
- (instancetype)init;
//#pragma mark - load状态 接收点击事件
//-(void)initWaitView;
//#pragma mark - 带aStr 接收点击事件
//-(void)initWaitViewWithString:(NSString*)aStr;
//
//#pragma mark - 当前Window禁止交互
//-(void)initBlockWaitWithString:(NSString*)aStr;
//#pragma mark - 导航栏接收点击事件的提示信息
//-(void)initBlockWaitUnderNavigationaBarWithString:(NSString*)aStr;
//#pragma mark - 清除提示信息
//-(void)clearWaitView;

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


/**
 toast控件

 @param aMessage toast信息
 @param aDuration toast展示时间
 @param offsety 0 默认居中 -1 顶部 1 底部 其他值（只改变Y坐标）
 */
-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration offSetY:(CGFloat)offsety;

#pragma mark - 根据图片名创建导航栏右侧按钮
- (void)createNavRightButtonWithImageName:(NSString *)imageName
                                   action:(SEL)action;
#pragma mark - 根据图片名创建导航栏右侧第二个按钮
- (void)createNavSecondRightButtonWithImageName:(NSString *)imageName
                                       action:(SEL)action;
#pragma mark - 根据图片名创建导航栏右侧按钮
- (void)createNavLeftButtonWithImageName:(NSString *)imageName
                                   action:(SEL)action;

#pragma mark - 根据title名创建导航栏右侧按钮
- (void)createNavRightButtonWithTitle:(NSString *)title
                               action:(SEL)action;
#pragma mark - 返回上一页
- (void)pop;

//返回(包括左滑返回)时 需要刷新首页信息RootVc
- (void)needLoadRootVc;
//如果当前页面禁用左滑返回手势 需要在当前VC backAction 手动调用此方法
- (void)loadRootVc;

@end

