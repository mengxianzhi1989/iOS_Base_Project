//
//  JKChooseProTableViewCell.m
//  Base_iOS_Project
//
//  Created by mengxianzhi on 2017/11/20.
//  Copyright © 2017年 mengxianzhi. All rights reserved.
//


#import "JKChooseProTableViewCell.h"

@implementation JKChooseProTableViewCell
@synthesize pcLable;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        pcLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, CELLH)];
        [pcLable setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:pcLable];
    }
    return self;
}
@end
