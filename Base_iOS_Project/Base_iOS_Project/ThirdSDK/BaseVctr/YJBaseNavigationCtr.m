//
//  YJBaseNavigationCtr.m
//  youjie
//
//  Created by TDJR on 15/3/6.
//  Copyright (c) 2015年 youjie8.com. All rights reserved.
//

#import "YJBaseNavigationCtr.h"
#import "AppDelegate.h"
#define TIME_TRANSITION_DURATION 0.3f

@interface YJBaseNavigationCtr ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property(nonatomic,weak) UIViewController* currentShowVC;
@property(nonatomic, weak) UIViewController* popToVCtr;

@end

@implementation YJBaseNavigationCtr
@synthesize popToVCtr;


-(id)initWithRootViewController:(UIViewController *)rootViewController{
    YJBaseNavigationCtr* nvc = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.delegate = self;
    nvc.delegate = self;
    return nvc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}

- (void)pushAnimationDidStop {
    [self.view.window setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
}

- (void)pushViewController: (UIViewController*)controller
    animatedWithTransition: (UIViewAnimationTransition)transition {
    [self pushViewController:controller animated:NO];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:TIME_TRANSITION_DURATION];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition {
    UIViewController* poppedController = [self popViewControllerAnimated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:TIME_TRANSITION_DURATION];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:NO];
    [UIView commitAnimations];
    
    return poppedController;
}

- (void)pushViewControllerFromVCtr: (UIViewController*)aFromController toVCtr:(UIViewController*)aToViewController{
    
    self.popToVCtr = aFromController;
    UIGraphicsBeginImageContextWithOptions(aFromController.view.bounds.size, YES, 2.0);
    [aFromController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.view.window setBackgroundColor:[UIColor colorWithPatternImage:uiImage]];
    
    aToViewController.view.frame = CGRectMake(0.0f, kScreenHeight, kScreenWidth, kScreenHeight);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:TIME_TRANSITION_DURATION];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    aToViewController.view.frame = CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight);
    [UIView commitAnimations];
    [self pushViewController:aToViewController animated:NO];
}

-(void)popAnimationDidStop{
    [self.view.window setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
    [self popViewControllerAnimated:NO];
}

- (void)popViewController{
    if (popToVCtr != nil ) {
        UIGraphicsBeginImageContextWithOptions(popToVCtr.view.bounds.size, YES, 2.0);
        [popToVCtr.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.view.window setBackgroundColor:[UIColor colorWithPatternImage:uiImage]];
    }
    
    UIViewController* curVCtr = self.topViewController;
    curVCtr.view.frame = CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:TIME_TRANSITION_DURATION];
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(popAnimationDidStop)];
    curVCtr.view.frame = CGRectMake(0.0f, kScreenHeight, kScreenWidth, kScreenHeight);
    [UIView commitAnimations];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (SYS_VER_BEYOND_AND_EQUAL_11) {
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        kAppDelegate.mTabBarVCtr.tabBar.frame = frame;
    }
}

@end
