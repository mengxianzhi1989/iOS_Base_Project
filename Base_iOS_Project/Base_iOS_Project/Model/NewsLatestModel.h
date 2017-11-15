//
//  NewsLatestModel.h
//  Base_iOS_Project
//
//  Created by mengxianzhi on 2017/11/15.
//  Copyright © 2017年 mengxianzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorieModel : NSObject

@property (nonatomic,strong) NSString *ga_prefix;
@property (nonatomic,strong) NSString *_id;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type;

@end

@interface NewsLatestModel : NSObject

@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSArray<StorieModel *> *stories;

@end
