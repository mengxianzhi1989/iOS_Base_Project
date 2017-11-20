//
//  JKChooseProvinceViewController.m
//  Base_iOS_Project
//
//  Created by mengxianzhi on 2017/11/20.
//  Copyright © 2017年 mengxianzhi. All rights reserved.
//

#import "JKChooseCityViewController.h"
#import "JKChooseProTableViewCell.h"

static NSString *C_CELLID = @"JKChooseCityTableViewCellID";

@interface JKChooseCityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *cTableView;

@end

@implementation JKChooseCityViewController
@synthesize cTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [cTableView registerClass:[JKChooseProTableViewCell class] forCellReuseIdentifier:C_CELLID];
}

- (void)initUI{
    cTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.mNavImgView.bottom)];
    [cTableView setDelegate:self];
    [cTableView setDataSource:self];
    cTableView.separatorInset = UIEdgeInsetsMake(0,15, 0,15);
    [cTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.view addSubview:cTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JKChooseProTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:C_CELLID];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.pcLable setText:@"天津"];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

