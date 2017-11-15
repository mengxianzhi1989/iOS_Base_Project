//
//  TestViewController.m
//  WeComeScrollerVIew
//
//  Created by xianzhi.meng on 16/5/4.
//  Copyright © 2016年 mengxianzhi. All rights reserved.
//

#import "ViewControllerThird.h"
#import "AppDelegate.h"
#import "ProductModel.h"
#import "AFHTTPSessionManager.h"
#import "NewsLatestModel.h"
#import "AFNetworking.h"

@interface ViewControllerThird ()

@end

@implementation ViewControllerThird


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackButton];
    [self initTitleView:@"ViewControllerThird"];
    
    //    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 300, 300, 100)];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(setTaskDidComplete11) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    //    [YQNetworking getWithrequestType:NewsLatest params:nil successBlock:^(id response) {
    //        DLog(@"%@",@"success");
    //        NewsLatestModel *lateModel = [NewsLatestModel yy_modelWithJSON:response];
    ////        NSString *image = [[[lateModel.stories objectAtIndex:0] images] objectAtIndex:0];
    //        [self showTipsMessage:MyFormat(@"%@",lateModel) withDuration:1];
    //        [self clearWaitView];
    //    } failBlock:^(NSError *error) {
    //        DLog(@"%@",@"error");
    //        [self showTipsMessage:@"error" withDuration:1];
    //        [self clearWaitView];
    //    }];
    
    
    [YQNetworking postWithrequestType:Getbycondition params:@{@"limit":@"5",@"page":@"1"} successBlock:^(id response) {
        ProductModel *model = [ProductModel yy_modelWithJSON:response];;
        DLog(@"%@ --- %@",@"success",[model.rows objectAtIndex:0].picUrl);
        [self clearWaitView];
    } failBlock:^(NSError *error) {
        DLog(@"%@",error);
        [self clearWaitView];
    }];
}

//- (void)back:(UIButton *)aBtn{
//    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appdelegate changeTableBarIndex:1];
//    [super back:aBtn];
//}

- (void)setTaskDidComplete11{
    NSLog(@"--------------");
}



@end

