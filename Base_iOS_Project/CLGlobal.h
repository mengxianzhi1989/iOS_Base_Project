//
//  CLGlobal.h
//  Car-league
//
//  Created by lxy on 16/5/24.
//  Copyright © 2016年 lxy. All rights reserved.
//

#ifndef CLGlobal_h
    #define CLGlobal_h

    /**AppStore渠道*/
    //#define _APP_STORE_ 1

    /**蒲公英测试环境 开发使用*/
//    #define _PGYER_CARDEBUG_ 1

    //*蒲公英公测环境（内测及销售测试使用）
    //#define _PGYER_CARTEST_ 1

    /**蒲公英正式灰度环境（提测前灰度环境测试）*/
//    #define _PGYER_CARINFORMAL_ 1

    /**蒲公英正式环境（客户使用）*/
    #define _PGYER_CARFORMAL_ 1

    #if _APP_STORE_

        //信鸽AppStore
        #define KXGAppId          8943738397
        #define KXGAppKey         7832749
        #define KXGSecretKey      7483927483

    #elif _PGYER_CARDEBUG_

        //信鸽AppStore
        #define KXGAppId          8943738397
        #define KXGAppKey         7832749
        #define KXGSecretKey      7483927483

    #elif _PGYER_CARINFORMAL_

        //信鸽AppStore
        #define KXGAppId          8943738397
        #define KXGAppKey         7832749
        #define KXGSecretKey      7483927483

    #endif

    #if (_APP_STORE_ + _PGYER_CARDEBUG_ + _PGYER_CARTEST_ + _PGYER_CARFORMAL_ + _PGYER_CARINFORMAL_ != 1)
    #error only _APP_STORE_ or _PGYER_CARDEBUG_ or _PGYER_CARTEST_ or _PGYER_CARFORMAL_ or _PGYER_CARINFORMAL_
    #endif//_APP_STORE_

    #define MyFormat(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]

    // 判读代理是否响应
    #define DELEGATE_IS_READY(x) (self.delegate && [self.delegate respondsToSelector:@selector(x)])

    // 判断字符串是否为空
    #define STRING_IS_NIL(key) (([@"<null>" isEqualToString:(key)] || [@"" isEqualToString:(key)] || key == nil || [key isKindOfClass:[NSNull class]]) ? YES: NO)

    // RGB颜色转换（16进制->10进制）
    #define UIColorFromRGB(rgbValue)\
    \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
    green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
    blue:((float)(rgbValue & 0xFF))/255.0 \
    alpha:1.0]

    #define rgbColor(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
    #define TITLETAG 919191
    #define kUserDefault [NSUserDefaults standardUserDefaults]
    #define kScreenWidth  [UIScreen mainScreen].bounds.size.width
    #define kScreenHeight [UIScreen mainScreen].bounds.size.height
    #define kAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

    #ifdef DEBUG
    #define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
    #else
    #defineNSLog(...){}
    #endif

#endif /* CLGlobal_h */
