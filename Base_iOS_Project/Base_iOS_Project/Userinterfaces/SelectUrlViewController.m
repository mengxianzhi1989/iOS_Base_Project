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
@property (nonatomic,strong) NSMutableArray *urNameList;

@end

@implementation SelectUrlViewController
@synthesize mTableView;
@synthesize urlList;
@synthesize urNameList;

- (void)viewDidLoad {
    [super viewDidLoad];
    urlList = [[NSMutableArray alloc]init];
    urNameList = [[NSMutableArray alloc]init];
    
    [urlList addObject:@"http://news-at.zhihu.com"];
    [urNameList addObject:@"zhihu"];
    [urlList addObject:@"http://www.huowangtong.com"];
    [urNameList addObject:@"huowangtong"];
    
    mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.mNavImgView.bottom, kScreenWidth, kScreenHeight - self.mNavImgView.bottom) style:UITableViewStylePlain];
    [mTableView setDelegate:self];
    [mTableView setDataSource:self];
    [mTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.view addSubview:mTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UILabel *urlNameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 120 - 15, 50)];
    [urlNameLable setText:urNameList[indexPath.row]];
    [urlNameLable setFont:F14];
    urlNameLable.textColor = C3;
    
    UILabel *urlLable = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, kScreenWidth-120, 50)];
    [urlLable setText:urlList[indexPath.row]];
    [urlLable setFont:F17];
    urlLable.textColor = C2;
    
    [cell.contentView addSubview:urlLable];
    [cell.contentView addSubview:urlNameLable];
    
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
    [kUserDefault setObject:url forKey:URL_KEY];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

