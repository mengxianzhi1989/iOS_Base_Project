//
//  CLGlobal.h
//  Car-league
//
//  Created by mengxianzhi on 16/5/24.
//  Copyright © 2016年 lxy. All rights reserved.
//

#ifndef CLGlobal_h

/**AppStore*/
//#define _APP_STORE_ 1

/*Dev环境*/
#define _PGYER_CARDEBUG_ 1


#if _APP_STORE_
    #define KXGAppId          8943738397
    #define KXGAppKey         7832749
    #define KXGSecretKey      7483927483
#elif _PGYER_CARDEBUG_
    //用于切换网络使用
    #define URL_KEY @"SELECT_URL_KEY"
    #define kTestDebug
    #define KXGAppId          8943738397
    #define KXGAppKey         7832749
    #define KXGSecretKey      7483927483
#endif

#if (_APP_STORE_ + _PGYER_CARDEBUG_ != 1)
#error only _APP_STORE_ or _PGYER_CARDEBUG_ or _PGYER_CARTEST_ or _PGYER_CARFORMAL_ or _PGYER_CARINFORMAL_
#endif

#ifdef kTestDebug
#define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#else
#define NSLog(...){}
#endif


//格式化
#define MyFormat(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]
//判读代理是否响应
#define DELEGATE_IS_READY(x) (self.delegate && [self.delegate respondsToSelector:@selector(x)])
//安全String
#define SafeString(str) ((str == nil || STRING_IS_NIL(str)) ? @"" : str)
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

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kUserDefault [NSUserDefaults standardUserDefaults]

//获取当前手机系统版本
#define MOBILE_SYS_VER ([[[UIDevice currentDevice]systemVersion] floatValue])
#define SYS_VER_BEYOND_AND_EQUAL_7 (MOBILE_SYS_VER >= 7.0)?(YES):(NO)
#define SYS_VER_BEYOND_AND_EQUAL_11 (MOBILE_SYS_VER >= 11.0)?(YES):(NO)
//是否是Iphone X
#define kDevice_IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//字体相关
#define DefineFontOfSize(size) [UIFont lightFontWithSize:size]
#define F11 DefineFontOfSize(11)
#define F12 DefineFontOfSize(12)
#define F13 DefineFontOfSize(13)
#define F14 DefineFontOfSize(14)
#define F15 DefineFontOfSize(15)
#define F16 DefineFontOfSize(16)
#define F17 DefineFontOfSize(17)
#define F18 DefineFontOfSize(18)
#define F19 DefineFontOfSize(19)
#define F20 DefineFontOfSize(20)

//颜色相关
#define C1 UIColorFromRGB(0x444444)
#define C2 UIColorFromRGB(0x1032d2)
#define C3 UIColorFromRGB(0xe8705e)
#define C4 UIColorFromRGB(0x545353)


#endif

