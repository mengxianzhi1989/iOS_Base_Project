//
//  AppDelegate.h
//  Base_iOS_Project
//
//  Created by mengxianzhi on 2017/11/14.
//  Copyright © 2017年 mengxianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong,nonatomic)UITabBarController *mTabBarVCtr;
@property (strong, nonatomic) UIWindow *window;

- (void)changeTableBarIndex:(int)index;

@end

