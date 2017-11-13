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

    /*开发环境*/
    #define _PGYER_CARDEBUG_ 1

    #if _APP_STORE_

        //信鸽AppStore
        #define KXGAppId          8943738397
        #define KXGAppKey         7832749
        #define KXGSecretKey      7483927483

    #elif _PGYER_CARDEBUG_
    #define kTestDebug
    //用于切换网络使用
    #define UrlKey @"UrlKey"
        //信鸽AppStore
        #define KXGAppId          8943738397
        #define KXGAppKey         7832749
        #define KXGSecretKey      7483927483

    #endif

    #if (_APP_STORE_ + _PGYER_CARDEBUG_ != 1)
    #error only _APP_STORE_ or _PGYER_CARDEBUG_ or _PGYER_CARTEST_ or _PGYER_CARFORMAL_ or _PGYER_CARINFORMAL_
    #endif

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

    #ifdef kTestDebug
    #define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
    #else
    #defineNSLog(...){}
    #endif

    #define KStatusBarAndNavBarHeight 64.0f
    //获取当前手机系统版本
    #define MOBILE_SYS_VER ([[[UIDevice currentDevice]systemVersion] floatValue])
    #define SYS_VER_BEYOND_AND_EQUAL_7 (MOBILE_SYS_VER >= 7.0)?(YES):(NO)
    #define SYS_VER_BEYOND_AND_EQUAL_11 (MOBILE_SYS_VER >= 11.0)?(YES):(NO)


#endif /* CLGlobal_h */
