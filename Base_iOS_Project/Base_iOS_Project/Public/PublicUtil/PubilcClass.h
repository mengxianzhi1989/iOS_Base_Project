//
//  PubilcClass.h
//  newYooli
//
//  Created by zengbaoquan on 15/7/17.
//  Copyright (c) 2015年 youjie.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PubilcClass : NSObject
/**
 *  金钱格式化
 *
 *  @param v            数字
 *  @param decimalPoint 小数点位数
 */
+(NSString *) formatToCurrency:(double) v  decimalPoint:(int) decimalPoint;
+(NSString *) formatToCurrency:(double) v;
+(NSString *) formatNSNumberToCurrency:(NSNumber *)v;
//手机号＊＊＊
+(NSString *)phoneNumberTranferToStart:(NSString *)phone;
//UIcolor to UIImage
+(UIImage *)createImageWithColor:(UIColor *)color;
//根据BOLD字体，获取字符串宽度
+(CGSize)string:(NSString*)aStr withBoldFontSize:(CGFloat)aSize;
//根据字体，获取字符串宽度
+(CGSize)string:(NSString*)aStr withFontSize:(CGFloat)aSize;
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
//UI
+(UILabel *)createLabel;
+(UILabel *)createLabel:(UIFont *)font color:(UIColor *)color;
+(UITextField *)createTextField:(UIFont *)font color:(UIColor *)color;
+(UIButton *)creatSubmitBtn:(NSString *)title targe:(id)targe method:(SEL)method;
+(UIButton *)createBottomBtn:(NSString *)title cornerRadius:(CGFloat)radius frame:(CGRect )frame targe:(id)targe method:(SEL)method;
+(UIButton *)creatRightBtn:(NSString *)title targe:(id)targe method:(SEL)method;
+(UIView *) createLineView:(CGRect)frame bgColor:(UIColor *)bgColor;
+(void)drawOneLine:(CGRect)frame toView:(UIView *)toView color:(UIColor *)color;
//根据投资金额 月份 年化利率 计算收益
+(double)calculateIncomeAccordingInterestRate:(float)rate andMonth:(int)month andInvestAmount:(double)investAmount;
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

@end


