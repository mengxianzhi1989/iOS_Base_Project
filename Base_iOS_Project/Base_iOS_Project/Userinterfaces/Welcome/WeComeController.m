//
//  WeComeController.m
//  WeComeScrollerVIew
//
//  Created by mengxianzhi on 16/5/4.
//  Copyright © 2016年 mengxianzhi. All rights reserved.
//

#import "WeComeController.h"
#import "AppDelegate.h"

@interface WeComeController ()

@property (strong,nonatomic) UIImageView *topImageView;
@property (strong,nonatomic) UIImageView *botImageView;

@end

@implementation WeComeController
@synthesize topImageView;
@synthesize botImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *topImageIcon = @"";
    NSString *botImageIcon = @"";
    if (kScreenWidth == 320) {
        if (kScreenHeight == 480) {
            topImageIcon = @"welcome_logo_4s";
        }else{
            topImageIcon = @"welcome_logo_5s";
        }
        botImageIcon = @"welcome_logo_640";
    }else if(kScreenWidth == 375){
        topImageIcon = @"welcome_logo_6";
        botImageIcon = @"welcome_logo_750";
    }else{
        topImageIcon = @"welcome_logo_6s";
        botImageIcon = @"welcome_logo_1242";
    }
    
    UIImage *topImage = [UIImage imageNamed:topImageIcon];
    topImageView = [[UIImageView alloc]initWithImage:topImage];
    [topImageView setFrame:CGRectMake(0, 0,kScreenWidth, topImage.size.height)];
    
    UIImage *botImage = [UIImage imageNamed:botImageIcon];
    botImageView = [[UIImageView alloc]initWithImage:botImage];
    [botImageView setFrame:CGRectMake(0, topImageView.bottom, kScreenWidth, botImage.size.height)];
    
    [self.view addSubview:topImageView];
    [self.view addSubview:botImageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[AppDelegate getAppDelegate] initTableBar];
    });
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =  [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:UIColorFromRGB(0xF6F6F6)];
    }
    return self;
}
@end
