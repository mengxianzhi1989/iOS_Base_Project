//
//  YJBaseVCtr.m
//  mljr
//
//  Created by mengxianzhi on 16/2/28.
//  Copyright (c) 2015年 mljr.com. All rights reserved.
//

#define TITLETAG 919191

#import "YJBaseVCtr.h"
#import "AppDelegate.h"
#import "DQAlertView.h"


@interface YJBaseVCtr ()

//等待提示view
@property (nonatomic, retain) UIView *mWaitBgView;
//提示信息背景view
@property (nonatomic, strong) UIView *mTipsMessageBgView;
//title str
@property (nonatomic, strong) NSString *mTitleStr;
//右侧事件按钮
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic,strong) UIView *mIncreaseView;
@property (nonatomic,strong) UIImageView *noNetWorkImageView;
@property (nonatomic,strong) UILabel *redPointLable;        //消息展示
@property (nonatomic,strong) UIImageView *noDataImageView;  //无数据提示
@property (nonatomic,strong) UILabel  *noDataLabel;         //无数据提示语
@property (nonatomic,assign) BOOL isReloadRootVc;           //是否需要刷新首页

@property (nonatomic,strong) UIScrollView *logScrollerView;
@property (nonatomic,strong) UILabel *logRequesLabel;
@property (nonatomic,strong) UILabel *logResponseLabel;
@property (nonatomic,strong) UIView *noNetWorkBgView;
@end

@implementation YJBaseVCtr
@synthesize mWaitBgView;
@synthesize mNavImgView;
@synthesize mIncrease;
@synthesize mNavBarH;
@synthesize mTabBarH;
@synthesize isDismissing;
@synthesize mTipsMessageBgView;
@synthesize mTitleStr;
@synthesize isListenerLoading;
@synthesize mIncreaseView;
@synthesize noNetWorkImageView;
@synthesize redPointLable;

-(void)dealloc {
    DLog(@"VC ------ %@ 被释放",NSStringFromClass([self class]));
    [self clearWaitView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, kScreenWidth, kScreenHeight);
    mIncreaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.mIncrease)];
//    [mIncreaseView setBackgroundColor:[UIColor blackColor]];
    self.isReloadRootVc = NO;
    [self.view addSubview:mIncreaseView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setIsLoading:(BOOL)isLoading{
    if (isListenerLoading) {
        self.navigationController.interactivePopGestureRecognizer.enabled = isLoading;
    }
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
//    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@", [[self class] description]]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:[NSString stringWithFormat:@"%@", [[self class] description]]];
}

-(UIImageView *)mNavImgView {
    if (!mNavImgView) {
        //隐藏nav
        [self.navigationController setNavigationBarHidden:YES];
        //标题图片
        mNavImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth,self.mNavBarH + self.mIncrease)];
        mNavImgView.userInteractionEnabled = YES;
        mNavImgView.image = [PublicClass createImageWithColor:UIColorFromRGB(0x428cfc)];

//        mNavImgView.image = [[UIImage imageNamed:@"a1_titlebackground"] stretchableImageWithLeftCapWidth:6 topCapHeight:6];
        [mNavImgView addSubview:mIncreaseView];
        [self.view addSubview:mNavImgView];
    }
    return mNavImgView;
}

-(void)initWaitView {
    [self clearWaitView];
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    mWaitBgView = bgview;
    [mWaitBgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f]];
    [mWaitBgView.layer setMasksToBounds:YES];
    [mWaitBgView.layer setCornerRadius:3.0f];
    mWaitBgView.center = self.view.center;
    [self.view addSubview:mWaitBgView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = CGPointMake(mWaitBgView.frame.size.width/2, mWaitBgView.frame.size.height/2);
    [mWaitBgView addSubview:activityIndicator];
    activityIndicator.color = [UIColor whiteColor];
    [activityIndicator startAnimating];
}

-(void)initWaitViewWithString:(NSString*)aStr {
    [self clearWaitView];
    CGSize textSize = [PublicClass string:aStr withFont:13 withMaxWidth:80];
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120,120)];
    mWaitBgView = bgview;
    
    [mWaitBgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f]];
    [mWaitBgView.layer setMasksToBounds:YES];
    [mWaitBgView.layer setCornerRadius:3.0f];
    mWaitBgView.center = self.view.center;
    [self.view addSubview:mWaitBgView];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((bgview.width - 30)/2, 25, 30, 30)];
    [mWaitBgView addSubview:activityIndicator];
    activityIndicator.color = [UIColor whiteColor];
    [activityIndicator startAnimating];
    
    UILabel* tipsLabel = [[UILabel alloc] init];
    [tipsLabel setText:aStr];
    [tipsLabel setFont:[UIFont systemFontOfSize:13]];
    [tipsLabel setTextColor:[UIColor whiteColor]];
    [tipsLabel setTextAlignment:NSTextAlignmentCenter];
    [tipsLabel setFrame:CGRectMake(0, activityIndicator.bottom + 10,bgview.width, textSize.height)];
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
    [self clearWaitView];
    UIView* bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen ].bounds];
    [bgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
    mWaitBgView = bgView;
    [self.view addSubview:bgView];
    CGSize textSize = [PublicClass string:aStr withFont:14 withMaxWidth:80];
    UIView* realBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,120,120)];
    
    [realBgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f]];
    [realBgView.layer setMasksToBounds:YES];
    [realBgView.layer setCornerRadius:10.0f];
    realBgView.center = bgView.center;
    [bgView addSubview:realBgView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((realBgView.width - 30)/2, 25, 30, 30)];
    [mWaitBgView addSubview:activityIndicator];
    activityIndicator.color = [UIColor whiteColor];
    [activityIndicator startAnimating];
    [realBgView addSubview:activityIndicator];
    
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

-(void)initBlockWaitUnderNavigationaBarWithString:(NSString*)aStr {
    [self clearWaitView];
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, mNavImgView.bottom, kScreenWidth, kScreenHeight- mNavImgView.bottom)];
    mWaitBgView = bgView;
    [bgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
    [self.view addSubview:bgView];
    
    CGSize textSize = [PublicClass string:aStr withFont:14 withMaxWidth:80];
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


-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration offSetY:(CGFloat)offsety
{
    [PublicClass showToast:nil message:aMessage duration:aDuration position:offsety];
}

-(void)showTipsMessage:(NSString *)aMessage withDuration:(NSTimeInterval)aDuration {
    [self showTipsMessage:aMessage withDuration:aDuration offSetY:0];
}

-(void)initBackButton {
    [self initBackButtonImage:nil];
}

-(void)initBackButtonImage:(UIImage *)image {
    UIImage* backimage = nil;
    if(image) {
        backimage = image;
    }else {
        backimage = [UIImage imageNamed:@"返回"];
    }
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, self.mIncrease, self.mNavBarH, self.mNavBarH)];
    backButton.tag = 919;
    [backButton setImage:backimage forState:UIControlStateNormal];
    [backButton setImage:backimage  forState:UIControlStateHighlighted];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(9, 0, 9, 0);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mNavImgView addSubview:backButton];
}

-(void)setBackButton:(UIImage *)aImg withPress:(UIImage *)aPressImg {
    UIButton *btn = (UIButton *)[self.mNavImgView viewWithTag:919];
    [btn setImage:aImg  forState:UIControlStateNormal];
    [btn setImage:aPressImg  forState:UIControlStateHighlighted];
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
    }else {
        label.textColor = [UIColor whiteColor];
    }
    label.font = fontS;
    label.tag = TITLETAG;

#ifdef kTestDebug
    [label setUserInteractionEnabled:YES];
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap)];
    doubleTapGesture.numberOfTapsRequired =2;
    doubleTapGesture.numberOfTouchesRequired =1;
    [label addGestureRecognizer:doubleTapGesture];
#endif

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

#pragma mark - 监听左滑返回事件
- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super willMoveToParentViewController:parent];
}

- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    if(!parent){
        if (self.isReloadRootVc) {
            [self loadRootVc];
        }
    }
}

#pragma mark - 返回
-(void)backAction:(UIButton *)aBtn {
    [self clearWaitView];
    if (self.navigationController != nil) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
            if(self.successHandel) {
                self.successHandel();
            }
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)createNavRightButtonWithImageName:(NSString *)imageName
                                   action:(SEL)action
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGRect rect = CGRectMake(kScreenWidth - 44 - 6, self.mIncrease, 44, 44);
    self.rightButton = [UIButton backBtnWithFrame:rect
                                            title:nil
                                       titleColor:UIColorFromRGB(0x00a0e9)];
    [self.rightButton setImage:image forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.mNavImgView addSubview:self.rightButton];
    
    redPointLable = [[UILabel alloc]initWithFrame:CGRectMake(self.rightButton.width - 10, 10, 6, 6)];
    [redPointLable setBackgroundColor:[UIColor redColor]];
    [redPointLable.layer setMasksToBounds:YES];
    [redPointLable setHidden:YES];
    [redPointLable.layer setCornerRadius:3];
    [self.rightButton addSubview:redPointLable];
    
}
    
- (void)createNavSecondRightButtonWithImageName:(NSString *)imageName
                                         action:(SEL)action{
    UIImage *image = [UIImage imageNamed:imageName];
    CGRect rect = CGRectMake(kScreenWidth - 44 * 2- 6 * 2, self.mIncrease, 44, 44);
    self.rightButton = [UIButton backBtnWithFrame:rect
                                            title:nil
                                       titleColor:UIColorFromRGB(0x00a0e9)];
    [self.rightButton setImage:image forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.mNavImgView addSubview:self.rightButton];
}
- (void)rightRedPointHidden:(BOOL)Hidden{
    [redPointLable setHidden:!Hidden];
}

- (void)createNavLeftButtonWithImageName:(NSString *)imageName
                                  action:(SEL)action{
    UIImage *image = [UIImage imageNamed:imageName];
    CGRect rect = CGRectMake(6, self.mIncrease, 44, 44);
    self.rightButton = [UIButton backBtnWithFrame:rect
                                            title:nil
                                       titleColor:UIColorFromRGB(0x00a0e9)];
    [self.rightButton setImage:image forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.mNavImgView addSubview:self.rightButton];
}

- (void)createNavRightButtonWithTitle:(NSString *)title
                               action:(SEL)action
{
    CGRect frame = CGRectMake(kScreenWidth - 80, self.mIncrease,80, 44);
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 15);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    btn.titleLabel.font = F14;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.mNavImgView addSubview:btn];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 目前启动页是黑色 若改为白色则 只需在plist文件添加
 key: Status bar style
 value: UIStatusBarStyleLightContent
 参考：http://blog.csdn.net/deft_mkjing/article/details/51705021
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)needLoadRootVc{
    self.isReloadRootVc = YES;
}

- (UIScrollView *)logScrollerView{
    if (_logScrollerView == nil) {
        _logScrollerView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        [_logScrollerView setBackgroundColor:UIColorFromRGB(0xF6F6F6)];
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeLogScrollerView)];
        doubleTapGesture.numberOfTapsRequired =2;
        doubleTapGesture.numberOfTouchesRequired =1;
        [_logScrollerView addGestureRecognizer:doubleTapGesture];
    }
    return _logScrollerView;
}

- (UILabel *)logRequesLabel{
    if (_logRequesLabel == nil) {
        _logRequesLabel = [PublicClass createLabel:[UIFont systemFontOfSize:14] color:C1];
        [_logRequesLabel setNumberOfLines:0];
        [_logRequesLabel sizeToFit];
    }
    return _logRequesLabel;
}

- (UILabel *)logResponseLabel{
    if (_logResponseLabel == nil) {
        _logResponseLabel = [PublicClass createLabel:[UIFont systemFontOfSize:14] color:C1];
        [_logResponseLabel setNumberOfLines:0];
        [_logResponseLabel sizeToFit];
    }
    return _logResponseLabel;
}

@end

