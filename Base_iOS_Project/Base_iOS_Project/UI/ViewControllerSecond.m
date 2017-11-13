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
#import "SelectUrlViewController.h"

@interface ViewControllerSecond ()

@end

@implementation ViewControllerSecond

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView:@"首页"];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    [but setBackgroundColor:[UIColor cyanColor]];
    [but setFrame:CGRectMake(0,self.mNavImgView.bottom, 100, 100)];
    [but addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}

- (void)jump{
    ViewControllerThird *testVc = [[ViewControllerThird alloc]init];
    YJBaseNavigationCtr *navC = (YJBaseNavigationCtr*)self.navigationController;
    [navC pushViewController:testVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    #ifdef kTestDebug
        UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempButton setFrame:CGRectMake(kScreenWidth - 100, self.mNavImgView.bottom, 80, 40)];
        [tempButton setTitle:@"网络选择" forState:UIControlStateNormal];
        [tempButton setBackgroundColor:[UIColor redColor]];
        [tempButton addTarget:self action:@selector(selectNetWork) forControlEvents:UIControlEventTouchUpInside];
        [self.mBackGroudImageView addSubview:tempButton];
    #endif
}

- (void)selectNetWork{
    SelectUrlViewController *selectUrlVc = [[SelectUrlViewController alloc]init];
    [self.navigationController pushViewController:selectUrlVc animated:YES];
}

@end
