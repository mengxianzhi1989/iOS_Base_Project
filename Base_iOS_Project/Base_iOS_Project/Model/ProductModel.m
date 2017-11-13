//
//  ProductModel.m
//  iOS_Project
//
//  Created by mengxianzhi on 16/9/2.
//  Copyright © 2016年 mengxianzhi. All rights reserved.
//

#import "ProductModel.h"

@implementation RowModel


@end

@implementation ProductModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rows" : [RowModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myInfo":@"info"};
}


@end
