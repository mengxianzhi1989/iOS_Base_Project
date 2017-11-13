//
//  YJBaseVCtr.m
//  youjie
//
//  Created by kongfugen on 15/2/28.
//  Copyright (c) 2015年 youjie8.com. All rights reserved.
//

#import "YJBaseVCtr.h"
#import "AppDelegate.h"
#import "DQAlertView.h"


@interface YJBaseVCtr ()

//等待提示view
@property (nonatomic, retain) UIView*           mWaitBgView;
//提示信息背景view
@property (nonatomic, strong) UIView*           mTipsMessageBgView;
//title str
@property (nonatomic, strong) NSString*         mTitleStr;

@end

@implementation YJBaseVCtr
@synthesize mWaitBgView;
@synthesize mBackGroudImageView;
@synthesize mNavImgView;
@synthesize mIncrease;
@synthesize mNavBarH;
@synthesize mTabBarH;
@synthesize isDismissing;
@synthesize mTipsMessageBgView;
@synthesize mTitleStr;

-(void)dealloc {
    [self clearBlockWaitView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, kScreenWidth, kScreenHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.isDismissing = NO;
    }
    return self;
}


- (CGFloat)mIncrease {
    mIncrease = 0;
    if (SYS_VER_BEYOND_AND_EQUAL_7) {
        mIncrease = [[UIApplication sharedApplication] statusBarFrame].size.height;
        if (mIncrease == 40) {
            mIncrease = 20;
        }
    }
    return mIncrease;
}

- (CGFloat)mNavBarH {
    mNavBarH = 0;
    if (SYS_VER_BEYOND_AND_EQUAL_7) {
        mNavBarH = self.navigationController.navigationBar.frame.size.height;
    }
    if (isDismissing == YES) {
        mNavBarH = 44;
    }
    return mNavBarH;
}

- (CGFloat)mTabBarH {
    mTabBarH = 0;
    if (self.hidesBottomBarWhenPushed == NO) {
        mTabBarH = self.tabBarController.tabBar.frame.size.height;
    }
    return mTabBarH;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark -- BackGroundView
-(UIImageView *)mBackGroudImageView {
    if (!mBackGroudImageView) {
        mBackGroudImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        mBackGroudImageView.userInteractionEnabled = YES;
        mBackGroudImageView.backgroundColor = UIColorFromRGB(0xf6f6f6);
        [self.view addSubview:mBackGroudImageView];
    }
    
    return mBackGroudImageView;
}

#pragma mark -- mNavImgView
-(UIImageView *)mNavImgView {
    if (!mNavImgView) {
        //隐藏nav
        [self.navigationController setNavigationBarHidden:YES];
        //标题图片
        mNavImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth,self.mNavBarH + self.mIncrease)];
        mNavImgView.userInteractionEnabled = YES;
        mNavImgView.image = [[UIImage imageNamed:@"a1_titlebackground"] stretchableImageWithLeftCapWidth:6 topCapHeight:6];
        [self.mBackGroudImageView addSubview:mNavImgView];
    }
    return mNavImgView;
}

#pragma mark -- WaitView
-(void)initWaitView {
    [self clearWaitView];
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.mWaitBgView = bgview;
    [mWaitBgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f]];
    [mWaitBgView.layer setMasksToBounds:YES];
    [mWaitBgView.layer setCornerRadius:3.0f];
    mWaitBgView.center = self.mBackGroudImageView.center;
    [self.view addSubview:mWaitBgView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = CGPointMake(mWaitBgView.frame.size.width/2, mWaitBgView.frame.size.height/2);
    [mWaitBgView addSubview:activityIndicator];
    activityIndicator.color = [UIColor whiteColor];
    [activityIndicator startAnimating];
}

//带提示的等待
-(void)initWaitViewWithString:(NSString*)aStr {
    [self clearWaitView];
    CGSize textSize = [PubilcClass string:aStr withFont:13 withLimitWidth:80];
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30 + textSize.height + 2*10 + 10)];
    self.mWaitBgView = bgview;
    
    [mWaitBgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f]];
    [mWaitBgView.layer setMasksToBounds:YES];
    [mWaitBgView.layer setCornerRadius:3.0f];
    mWaitBgView.center = self.mBackGroudImageView.center;
    [self.view addSubview:mWaitBgView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((bgview.width - 30)/2, 10, 30, 30)];
    [mWaitBgView addSubview:activityIndicator];
    activityIndicator.color = [UIColor whiteColor];
    [activityIndicator startAnimating];
    
    UILabel* tipsLabel = [[UILabel alloc] init];
    [tipsLabel setText:aStr];
    [tipsLabel setFont:[UIFont systemFontOfSize:13]];
    [tipsLabel setTextColor:[UIColor whiteColor]];
    [tipsLabel setTextAlignment:NSTextAlignmentCenter];
    [tipsLabel setFrame:CGRectMake(10, activityIndicator.bottom + 10, textSize.width, textSize.height)];
    tipsLabel.numberOfLines = 0;
    [mWaitBgView addSubview:tipsLabel];
}

-(void)clearWaitView {
    if(mWaitBgView != nil) {
        [mWaitBgView removeFromSuperview];
        mWaitBgView = nil;
    }
}

-(void)initBlockWaitWithString:(NSString*)aStr {
    if ([PubilcClass isExitingGolbalView:YJ_GView_WaitBg]) {
        [PubilcClass removeGlobalView:YJ_GView_WaitBg];
    }
    UIView* bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen ].bounds];
    [bgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
    [PubilcClass addGlobalView:bgView withType:YJ_GView_WaitBg];
    
    CGSize textSize = [PubilcClass string:aStr withFont:14 withLimitWidth:80];
    UIView* realBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 152, 152)];

    [realBgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f]];
    [realBgView.layer setMasksToBounds:YES];
    [realBgView.layer setCornerRadius:10.0f];
    realBgView.center = bgView.center;
    [bgView addSubview:realBgView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((realBgView.width - 37)/2, 39, 37, 37)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [realBgView addSubview:activityIndicator];
    activityIndicator.color = [UIColor whiteColor];
    [activityIndicator startAnimating];
    //提示文字
    if (aStr != nil && [aStr length]>0) {
        UILabel* tipsLabel = [[UILabel alloc] init];
        [tipsLabel setText:aStr];
        [tipsLabel setFont:[UIFont systemFontOfSize:14]];
        [tipsLabel setTextColor:[UIColor whiteColor]];
        [tipsLabel setTextAlignment:NSTextAlignmentCenter];
        [tipsLabel setFrame:CGRectMake((realBgView.width - textSize.width)/2, activityIndicator.bottom + 20, textSize.width, textSize.height)];
        tipsLabel.numberOfLines = 0;
        [realBgView addSubview:tipsLabel];
    }
}

// 添加block wait view不覆盖导航栏
-(void)initBlockWaitUnderNavigationaBarWithString:(NSString*)aStr {
    if ([PubilcClass isExitingGolbalView:YJ_GView_WaitBg]) {
        [PubilcClass removeGlobalView:YJ_GView_WaitBg];
    }
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, mNavImgView.bottom, kScreenWidth, kScreenHeight- mNavImgView.bottom)];
    [bgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
    [PubilcClass addGlobalView:bgView withType:YJ_GView_WaitBg];
    
    CGSize textSize = [PubilcClass string:aStr withFont:14 withLimitWidth:80];
    UIView* realBgView = [[UIView alloc] initWithFrame:CGRectMake(0.5*(kScreenWidth - 152), 0.5*(kScreenHeight - 152)-mNavImgView.bottom, 152, 152)];
    
    [realBgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f]];
    [realBgView.layer setMasksToBounds:YES];
    [realBgView.layer setCornerRadius:10.0f];
    [bgView addSubview:realBgView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((realBgView.width - 37)/2, 39, 37, 37)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [realBgView addSubview:activityIndicator];
    activityIndicator.color = [UIColor whiteColor];
    [activityIndicator startAnimating];
    
    //提示文字
    if (aStr != nil && [aStr length]>0) {
        UILabel* tipsLabel = [[UILabel alloc] init];
        [tipsLabel setText:aStr];
        [tipsLabel setFont:[UIFont systemFontOfSize:14]];
        [tipsLabel setTextColor:[UIColor whiteColor]];
        [tipsLabel setTextAlignment:NSTextAlignmentCenter];
        [tipsLabel setFrame:CGRectMake((realBgView.width - textSize.width)/2, activityIndicator.bottom + 20, textSize.width, textSize.height)];
        tipsLabel.numberOfLines = 0;
        [realBgView addSubview:tipsLabel];
    }
}

-(void)clearBlockWaitView {
    [PubilcClass removeGlobalView:YJ_GView_WaitBg];
}
-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration offSetY:(CGFloat)offsety
{
    [self removeTipsView];
    //原来宽度为152，目前增加40，若修改宽度修改40即可，至于为什么原来写152已无法考究了。
    float mTipsViewWidth = 152 + 40;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview = [[UIView alloc]init];
    self.mTipsMessageBgView = showview;
    mTipsMessageBgView.backgroundColor = [UIColor blackColor];
    mTipsMessageBgView.frame = CGRectMake(1, 1, 1, 1);
    mTipsMessageBgView.alpha = 1.0f;
    mTipsMessageBgView.layer.cornerRadius = 5.0f;
    mTipsMessageBgView.layer.masksToBounds = YES;
    [window addSubview:mTipsMessageBgView];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [PubilcClass string:aMessage withFont:17 withLimitWidth:mTipsViewWidth-20];
    label.frame = CGRectMake((mTipsViewWidth-LabelSize.width)/2, 10, LabelSize.width, LabelSize.height);
    label.text = aMessage;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.numberOfLines = 0;
    [mTipsMessageBgView addSubview:label];
    mTipsMessageBgView.frame = CGRectMake(0,0,mTipsViewWidth,LabelSize.height+20);
    mTipsMessageBgView.center = CGPointMake(window.centerX, window.centerY-offsety);
    
    mTipsMessageBgView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        mTipsMessageBgView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.5 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            mTipsMessageBgView.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeTipsView];
        }];
    }];
}

-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration {
    [self showTipsMessage:aMessage withDuration:aDuration offSetY:0];
}

-(void)removeTipsView {
    if (mTipsMessageBgView != nil) {
        [mTipsMessageBgView removeFromSuperview];
        mTipsMessageBgView = nil;
    }
}

-(void)initBackButton {
    [self initBackButtonImage:nil];
}

-(void)initBackButtonImage:(UIImage *)image {
    UIImage* backimage = nil;
    if(image) {
        backimage = image;
    }
    else {
        backimage = [UIImage imageNamed:@"back_arrow"];
    }
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, self.mIncrease, self.mNavBarH, self.mNavBarH)];
    backButton.tag = 919;
    [backButton setImage:backimage forState:UIControlStateNormal];
    [backButton setImage:backimage  forState:UIControlStateHighlighted];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(9, 0, 9, 0);
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.mNavImgView addSubview:backButton];
}

-(void)setBackButton:(UIImage *)aImg withPress:(UIImage *)aPressImg {
    UIButton *btn = (UIButton *)[self.mNavImgView viewWithTag:919];
    [btn setImage:aImg  forState:UIControlStateNormal];
    [btn setImage:aPressImg  forState:UIControlStateHighlighted];
}

-(void)back:(UIButton *)aBtn {
    if ([PubilcClass isExitingGolbalView:YJ_GView_WaitBg]) {
        [PubilcClass removeGlobalView:YJ_GView_WaitBg];
    }
    if (self.navigationController != nil ) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if(self.successHandel) {
        self.successHandel();
    }
}

-(void)initTitleView:(NSString *)aTitleStr textColor:(UIColor *)textColor {
    UIView *tiltleView = [self.mNavImgView viewWithTag:TITLETAG];
    if (tiltleView) {
        [tiltleView removeFromSuperview];
    }
    UIFont *fontS = [UIFont systemFontOfSize:17.0f];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60,self.mIncrease,kScreenWidth - 120, self.mNavBarH)];
    label.textAlignment = NSTextAlignmentCenter;
    self.mTitleStr = aTitleStr;
    label.text = mTitleStr;
    if(textColor){
         label.textColor = textColor;
    }
    else {
        label.textColor = UIColorFromRGB(0x313131);
    }
    label.font = fontS;
    label.tag = TITLETAG;
    [self.mNavImgView addSubview:label];
}

-(void)initTitleView:(NSString *)aTitleStr {
    [self initTitleView:aTitleStr textColor:nil];
}

-(void)setTitleColor:(UIColor *)aColor {
    if (mNavImgView) {
        UILabel *label = (UILabel *)[self.mNavImgView viewWithTag:TITLETAG];
        if (label) {
            label.textColor = aColor;
        }
    }
}

-(void)alertShow:(NSString *)message {

    [self alertShow:message message:nil btnTitle:@"确定"];
}

-(void)alertShow:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle
{
    DQAlertView *alertV = [[DQAlertView alloc]initWithTitle:title message:message cancelButtonTitle:btnTitle otherButtonTitle:nil];
    [alertV show];
}

@end
