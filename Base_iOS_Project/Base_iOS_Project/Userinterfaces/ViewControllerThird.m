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



//哈哈哈哈 哈哈哈哈
@interface ViewControllerThird ()

@end

@implementation ViewControllerThird


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackButton];
    [self initTitleView:@"ViewControllerThird"];

    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, [CLSystemHelper lineHigh05])];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    //    Getbycondition @{@"limit":@"5",@"page":@"1"}
//        Querybycondition
        NSDictionary *dicParams = @{@"limit":@"10",
          @"page":@"1",
          @"cgFprovince":@"湖北",
          @"cgFcity":@"咸宁市",
          @"cgFcounty":@"通山县",
          @"cgTprovince":@"湖北",
          @"cgTcity":@"咸宁市",
          @"cgTcounty":@"通山县"};
    
    
//    __block BOOL bGetbycondition = NO;
//    __block BOOL bQuerybycondition = NO;
//
//    dispatch_group_t group = dispatch_group_create();
//
//    dispatch_group_enter(group);
    [YQNetworking postWithRequestType:Getbycondition withView:self.view params:@{} tipMsg:@"123" finishBlock:^(id response) {
        [PublicClass clearViewViewHUDFromSuperView:self.view];
    }];
    
//    [YQNetworking postWithrequestType:UserLoginType params:@{} successBlock:^(id response) {
//        
//    } failBlock:^(NSError *error) {
//        
//    }];
//    dispatch_group_enter(group);
//    [YQNetworking postWithrequestType:Querybycondition params:dicParams successBlock:^(id response) {
//        DLog(@"Querybycondition");
//        bQuerybycondition = YES;
//        dispatch_group_leave(group);
//        [self clearWaitView];
//    } failBlock:^(NSError *error) {
//        [self clearWaitView];
//        dispatch_group_leave(group);
//    }];
    
    
//   dispatch_group_notify(group,dispatch_get_main_queue(), ^{
//        DLog(@"bQuerybycondition %d bGetbycondition %d  isMainQueue %d",bQuerybycondition,bGetbycondition,NSThread.currentThread.isMainThread);
//    });

}

- (void)back:(UIButton *)aBtn{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate changeTableBarIndex:1];
    [super backAction:aBtn];
}

@end

