//
//  NewsLatestModel.m
//  Base_iOS_Project
//
//  Created by mengxianzhi on 2017/11/15.
//  Copyright © 2017年 mengxianzhi. All rights reserved.
//

#import "NewsLatestModel.h"

@implementation StorieModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"_id":@"id"};
}

@end

@implementation NewsLatestModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"stories" : [StorieModel class]};
}

@end
