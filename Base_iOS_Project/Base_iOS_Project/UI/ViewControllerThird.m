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


@interface ViewControllerThird ()

@end

@implementation ViewControllerThird

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackButton];
    [self initTitleView:@"ViewControllerThird"];
    
    
    [QFNetWorkManger request:Getbycondition withView:self.view withAnimated:YES withParameters:@{@"limit":@"5",@"page":@"1"} httpMethod:kHTTP_POST responseCallBack:^(NSDictionary *responseDictionary, NSError *error) {
        if (error) {
            DLog(@"---error : %@",error);
        }else{
            ProductModel *model = [ProductModel yy_modelWithJSON:responseDictionary];;
            DLog(@"responseDictionary %@",model);
            [self.view makeToast:@"-----"];
        }
    }];
}

- (void)back:(UIButton *)aBtn{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate changeTableBarIndex:1];
    [super back:aBtn];
}

@end
