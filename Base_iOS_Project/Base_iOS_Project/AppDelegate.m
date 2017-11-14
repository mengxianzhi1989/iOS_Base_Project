//
//  AppDelegate.m
//  WeComeScrollerVIew
//
//  Created by mengxianzhi on 16/4/20.
//  Copyright © 2016年 mengxianzhi. All rights reserved.
//

#import "AppDelegate.h"
#import "YJBaseNavigationCtr.h"
#import "ViewControllerSecond.h"
#import "ViewControllerFirst.h"
#import "WeComeController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (strong,nonatomic) ViewControllerFirst *mDisconverVCtr;
@property (strong,nonatomic) ViewControllerSecond *mMoneyVCtr;
@property(nonatomic, strong) UIImageView *IconImg;

@end

@implementation AppDelegate
@synthesize mTabBarVCtr;
@synthesize IconImg;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self adjustFirstLogin];
    [self.window makeKeyAndVisible];
//    + (NSUInteger) deviceSystemMajorVersion;   //iOS 系统版本
//    + (NSString *)deviceSystem;
//    + (NSString *)deviceType;                  //设备类型
//    + (NSString *)deviceName;                  //设备名称
    
    NSInteger a = [CLSystemHelper deviceSystemMajorVersion];
    NSString *b = [CLSystemHelper deviceSystem];
    NSInteger c = [CLSystemHelper deviceSystemMajorVersion];
    if (kDevice_Is_iPhoneX) {
        
    }
    NSLog(@"111");
    DLog(@"222");
    return YES;
}

#pragma mark 是否是第一次登录
-(void)adjustFirstLogin {
    //    NSString *key = (NSString *)kCFBundleVersionKey;
    //    NSString *lastVersionCode = [USER_DEFAULTS objectForKey:key];
    //    NSString *currentVersionCode = [NSBundle mainBundle].infoDictionary[key];
    // 非第一次
    //    if ([lastVersionCode isEqualToString:currentVersionCode]) {
    [self initTableBar];
    //    }else {
    //        [USER_DEFAULTS setObject:currentVersionCode forKey:key];
    //        [USER_DEFAULTS synchronize];
    //        WeComeController *weComeVc = [[WeComeController alloc]initWithNibName:@"WeComeController" bundle:nil];
    //        [self.window setRootViewController:weComeVc];
    //    }
}


- (void)initTableBar{
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    self.mTabBarVCtr = tabBarController;
    
    //money
    ViewControllerSecond* moneyVCtr = [[ViewControllerSecond alloc] init];
    self.mMoneyVCtr = moneyVCtr;
    self.mMoneyVCtr.hidesBottomBarWhenPushed = NO;
    YJBaseNavigationCtr* moneyNCtr = [[YJBaseNavigationCtr alloc] initWithRootViewController:moneyVCtr];
    
    //discover
    ViewControllerFirst* disconverVCtr = [[ViewControllerFirst alloc] init];
    self.mDisconverVCtr = disconverVCtr;
    self.mDisconverVCtr.hidesBottomBarWhenPushed = NO;
    YJBaseNavigationCtr* discoverNCtr = [[YJBaseNavigationCtr alloc] initWithRootViewController:disconverVCtr];
    
    mTabBarVCtr.delegate = self;
    self.window.rootViewController = mTabBarVCtr;
    mTabBarVCtr.viewControllers = [NSArray arrayWithObjects:moneyNCtr, discoverNCtr, nil];
    
    UITabBar *tabBar = mTabBarVCtr.tabBar;
    UIImage *image = [PubilcClass createImageWithColor:UIColorFromRGB(0xfbfcfc)];
    tabBar.backgroundImage = image;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x777777), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x359df5), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [item0 setImage:[[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item0 setSelectedImage:[[UIImage imageNamed:@"home_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item0 setTitle:@"首页"];
    [item0 setTitlePositionAdjustment:UIOffsetMake(item0.titlePositionAdjustment.horizontal,item0.titlePositionAdjustment.vertical - 3.0)];
    
    UIImage *imgDis = [UIImage imageNamed:@"discovery"];
    [item1 setImage:[imgDis imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setSelectedImage:[[UIImage imageNamed:@"discovery_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setTitle:@"发现"];
    [item1 setTitlePositionAdjustment:UIOffsetMake(item1.titlePositionAdjustment.horizontal,item1.titlePositionAdjustment.vertical - 3.0)];
    
    CGRect aframe = CGRectMake((int)(kScreenWidth/3 + (kScreenWidth/6 + imgDis.size.width/2)), 5, 9.0, 9.0);
    IconImg = [[UIImageView alloc] initWithFrame:aframe];
    IconImg.backgroundColor = UIColorFromRGB(0xf43530);
    IconImg.layer.cornerRadius = IconImg.width/2.0f;
    IconImg.layer.masksToBounds = YES;
    [tabBar addSubview:IconImg];
    IconImg.hidden = YES;
    mTabBarVCtr.selectedIndex = 0;
}

- (void)changeTableBarIndex:(int)index{
    [mTabBarVCtr setSelectedIndex:index];
    mTabBarVCtr.selectedIndex = index;
}

@end

