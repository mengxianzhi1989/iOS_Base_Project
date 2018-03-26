//
//  PubilcClass.h
//  newYooli
//
//  Created by mengxianzhi on 16/7/17.
//  Copyright (c) 2015年 youjie.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicClass : NSObject

+ (instancetype)shareInstace;
/**
 *  金钱格式化
 *
 *  @param v            数字
 *  @param decimalPoint 小数点位数
 */
+(NSString *)formatToCurrency:(double) v  decimalPoint:(int) decimalPoint;
+(NSString *)formatToCurrency:(double) v;
+(NSString *)formatNSNumberToCurrency:(NSNumber *)v;
//手机号＊＊＊
+(NSString *)phoneNumberTranferToStart:(NSString *)phone;
//根据Color创建Image
+(UIImage *)createImageWithColor:(UIColor *)color;
//根据BOLD字体，获取字符串宽度
+(CGSize)string:(NSString*)aStr withBoldFontSize:(CGFloat)aSize;
//根据字体，获取字符串宽度
+(CGSize)string:(NSString*)aStr withFontSize:(CGFloat)aSize;
//根据Fond，获取字符串宽度
+(CGSize)string:(NSString*)aStr withFont:(UIFont *)font;;
//输入字符串，字体大小，限制宽度 得出高度
+(CGSize)string:(NSString*)aStr withFont:(CGFloat)aSize withMaxWidth:(CGFloat)aMaxWidth;
+(CGSize)stringSize:(NSString *)str font:(UIFont *)font color:(UIColor *)color width:(CGFloat)width;

//获取当前时间的时间戳（1970）
+(NSString*)currentTimestampSince1970;
//缓存数据到cache目录
+(void)saveCacheData:(id)aData withFilename:(NSString*)aFilename;
//读取cache目录下文件
+(id)readCacheDatawithFilename:(NSString*)aFilename;


//时间戳转换为时间（yy.mm.dd hh:mm）
+(NSString*)timestamptoNSDate_Y_M_D_H:(long long int)aTimeStamp;
//时间戳转换为时间（yy-mm-dd hh:mm）
+(NSString*)timestamptoNSDateY_M_D_H_M_S:(long long int)aTimeStamp;
//时间戳转换为时间（hh:mm）
+(NSString*)timestamptoNSDate_D_H:(long long)aTimeStamp;
//时间戳转换为时间（mm月dd日）
+(NSString*)timestamptoNSDate_M_D:(long long int)aTimeStamp;
//时间戳转换为时间（mm.dd）
+(NSString*)timestamptoDecimalNSDate_M_D:(long long int)aTimeStamp;
//时间戳转换为时间（yy.mm.dd）
+(NSString*)timetoNSDate_Y_M_D:(long long int)aTimeStamp;
//时间戳转换为时间（yyyy年mm月dd日）
+(NSString*)timestamptoNSDate_Y_M_D:(long long int)aTimeStamp;
//时间戳转换为时间（yyyy-mm-dd）
+(NSString*)timestamptoLineNSDate_Y_M_D:(long long int)aTimeStamp;
+(NSString *)timestamp:(long long)aTimeStamp;
//时间戳转换为时间（mm-dd）
+(NSString *)timestamptoLineNSDate_M_D:(long long)aTimeStamp;
//日期转换为星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
//时间戳转换为星期
+ (NSString*)weekdayStringFromTimeStamp:(long long)aTimeStamp;
//比较两个时间戳相差多少秒
+ (long long)compareTimeStamp:(NSString *)beginTimestamp other:(NSString *)endTimestamp;
//获取当前时间 yyyy-MM-dd HH:mm:ss
+ (NSString *)getCurrentDetailDate;

//UI
+(UILabel *)createLabel;
+(UILabel *)createLabel:(UIFont *)font color:(UIColor *)color;
+(UITextField *)createTextField:(UIFont *)font color:(UIColor *)color;
//+(UIButton *)creatSubmitBtn:(NSString *)title targe:(id)targe method:(SEL)method;
//+(UIButton *)createBottomBtn:(NSString *)title cornerRadius:(CGFloat)radius frame:(CGRect )frame targe:(id)targe method:(SEL)method;
//+(UIButton *)creatRightBtn:(NSString *)title targe:(id)targe method:(SEL)method;
+(UIView *)createLineView:(CGRect)frame bgColor:(UIColor *)bgColor;
+(void)drawOneLine:(CGRect)frame toView:(UIView *)toView color:(UIColor *)color;
//将整数转成x万
+(NSString *)rechargeMoney:(long long)money;//x万
//icon + label
+(UIView *)createLabel:(NSString *)text withIcon:(NSString *)iconName andFontSize:(float)fontSize distance:(float)distance backColor:(UIColor *)backColor textColor:(UIColor *)textColor;
+(UILabel *)createSizeFitLabelWithText:(NSString *)text FontSize:(float)fontSize textColor:(UIColor *)textColor;
//获取当前设备型号
+ (NSString *)getCurrentDeviceModel;
//阿拉伯数字转大写汉字
+ (NSString *)changeToChinese:(NSString *)numstr;
//获取当前正在显示VC
+ (UIViewController *)topViewController;
//获取当前用户连接Wifi名称
- (void)getWifiName;
//获取当前用户wifi ip
+ (NSString*)getCurrentLocalIP;
//获取当前用户Wifi ssid
+ (NSString *)getCurreWiFiSsid;
//如果当前用户开启WIFI则获取是是当前wifi 的ip;如果用的是蜂窝则获取的是当前设备ip
- (NSString *)getIPAddress;
- (BOOL)isJailBreak;
+ (void)showViewHUDwithSuperView:(UIView *)aView andText:(NSString *)aStr;
+ (void)clearViewViewHUDFromSuperView:(UIView *)aView;
//md5 - >转大写  返回
+ (NSString *)md5_uppercaseString:(NSString *)input;
//去除空格
+ (NSString *)trim:(NSString *)string;

+ (BOOL)responseSuccess:(NSDictionary *)responseDic;
+ (NSString *)responseretMsg:(NSDictionary *)responseDic;
+ (NSDictionary *)responseRetData:(NSDictionary *)responseDic;

// 创建个圆角蓝色的button
+ (UIButton *)createBlueRoundedCornersButton:(NSString *)name rect:(CGRect)rect;
//兆
+ (NSString *)fileSizeWithInterge:(NSInteger)size;
/**
 图片转base64字符串
 */
+ (NSString *)base64StringWithImage:(UIImage *)image;

/**
 base64字符串转图片
 */
+ (UIImage *)imageWithBase64String:(NSString *)base64String;

/**
 url字符串转图片

 @param urlString URL
 @return imAGE
 */
+ (UIImage *)imageWithURLString:(NSString *)urlString;
/**
 版本比较 服务器版本是否大于当前版本 YES:大于
 */
+ (BOOL)compareVersionWithSeverVersion:(NSString *)severVersion locationVersion:(NSString *)locationVersion;



+ (void)showToastMessage:(NSString *)msg;

+ (void)showToastMessage:(NSString *)msg duration:(NSTimeInterval)duration;

/**
 toast控件
 
 @param view      默认显示在window上
 @param msg       toast 信息
 @param duration  toast展示时间
 @param originY  0 默认居中 -1 顶部 1 底部 其他值（只改变Y坐标）
 */

+ (void)showToast:(id)view message:(NSString *)msg duration:(NSTimeInterval)duration position:(CGFloat)originY;

/**
 跳转到系统设置

 @param urlString url
 */
+ (void)jumpSystemViewWithURL_String:(NSString *)urlString;
@end


