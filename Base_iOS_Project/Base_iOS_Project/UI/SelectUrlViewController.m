//
//  SelectUrlViewController.m
//  Base_iOS_Project
//
//  Created by mengxianzhi on 2017/11/14.
//  Copyright © 2017年 mengxianzhi. All rights reserved.
//

#import "SelectUrlViewController.h"

@interface SelectUrlViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *urlList;
@end

@implementation SelectUrlViewController
@synthesize mTableView;
@synthesize urlList;

- (void)viewDidLoad {
    [super viewDidLoad];
    urlList = [[NSMutableArray alloc]init];
    [urlList addObject:@"192.168.0.1"];
    [urlList addObject:@"http://www.huowangtong.com"];
    mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.mNavImgView.bottom, kScreenWidth, kScreenHeight - self.mNavImgView.bottom) style:UITableViewStylePlain];
    [mTableView setDelegate:self];
    [mTableView setDataSource:self];
    [mTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.view addSubview:mTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UILabel *urlLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 40)];
    [urlLable setText:urlList[indexPath.row]];
    [cell.contentView addSubview:urlLable];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return urlList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *url = [urlList objectAtIndex:indexPath.row];
    [kUserDefault setObject:url forKey:UrlKey];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
