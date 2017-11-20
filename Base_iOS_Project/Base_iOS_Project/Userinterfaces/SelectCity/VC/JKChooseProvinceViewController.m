//
//  JKChooseProvinceViewController.m
//  Base_iOS_Project
//
//  Created by mengxianzhi on 2017/11/20.
//  Copyright © 2017年 mengxianzhi. All rights reserved.
//
static NSString *P_CELLID = @"JKChooseProTableViewCellID";

#import "JKChooseProvinceViewController.h"
#import "JKChooseCityViewController.h"
#import "JKChooseProTableViewCell.h"

@interface JKChooseProvinceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *pTableView;

@end

@implementation JKChooseProvinceViewController
@synthesize pTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackButton];
    [self initTitleView:@"选择省"];
    [self initUI];
}

- (void)initUI{
    pTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.mNavImgView.bottom, kScreenWidth, kScreenHeight-self.mNavImgView.bottom)];
    [pTableView registerClass:[JKChooseProTableViewCell class] forCellReuseIdentifier:P_CELLID];
    [pTableView setDelegate:self];
    [pTableView setDataSource:self];
    pTableView.separatorInset = UIEdgeInsetsMake(0,15, 0,15);
    [pTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [pTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.view addSubview:pTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    JKChooseProTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:P_CELLID];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.pcLable setText:@"北京"];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JKChooseCityViewController *chooseCityVc = [[JKChooseCityViewController alloc]init];
    [self addChildViewController:chooseCityVc];
    [chooseCityVc.view setFrame:CGRectMake(kScreenWidth, self.mNavImgView.bottom, kScreenWidth, kScreenHeight - self.mNavImgView.bottom)];
    [self.view addSubview:chooseCityVc.view];
    [UIView animateWithDuration:0.3 animations:^{
        [chooseCityVc.view setFrame:CGRectMake(150, self.mNavImgView.bottom, kScreenWidth, kScreenHeight - self.mNavImgView.bottom)];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
