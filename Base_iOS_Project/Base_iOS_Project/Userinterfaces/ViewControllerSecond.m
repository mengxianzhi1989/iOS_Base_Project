//
//  ViewControllerSec.m
//  WeComeScrollerVIew
//
//  Created by mengxianzhi on 16/5/3.
//  Copyright © 2016年 mengxianzhi. All rights reserved.
//

#import "ViewControllerSecond.h"
#import "ViewControllerThird.h"
#import "YJBaseNavigationCtr.h"

@interface ViewControllerSecond ()

@end

@implementation ViewControllerSecond

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView:@"首页"];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    [but setBackgroundColor:[UIColor cyanColor]];
    [but setFrame:CGRectMake(0,200, 100, 100)];
    [but addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    if (![AppDelegate getAppDelegate].connection) {
        DQAlertView *alert = [[DQAlertView alloc]initWithTitle:@"网络异常" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
        [alert show];
    }
}

- (void)jump{
    ViewControllerThird *testVc = [[ViewControllerThird alloc]init];
    YJBaseNavigationCtr *navC = (YJBaseNavigationCtr*)self.navigationController;
    [navC pushViewController:testVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


@end
