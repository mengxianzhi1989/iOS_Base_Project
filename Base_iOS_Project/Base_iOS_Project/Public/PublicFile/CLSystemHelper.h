//
//  ZSJudgeResolution.h
//  ZolSoft
//
//  Created by mengxianzhi on 16-10-29.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CLDeviceResolution) {
    RES_None,
    RES_640X960_2X,         //iphone 4、4S
    RES_640X1136_2X,        //iphone 5、5S
    RES_750X1334_2X,        //iphone 6、6S、7
    RES_1536X2048_2X,       //ipad Retina and normal
    //3x
    RES_1242X2208_3X,       //iphone 6P、6SP、7P
    RES_1125X2436_3X,       //iphone x
};

#define CURRENT_RES [CLSystemHelper currentResolution]
#define IS_RES_1242X2208_3X  CURRENT_RES == RES_1242X2208_3X //iphone 6Plus、6SPlus、7Plus
#define IS_RES_750X1334_2X   CURRENT_RES == RES_750X1334_2X  //iphone 6、6S、7
#define IS_RES_640X1136_2X   CURRENT_RES == RES_640X1136_2X  //iphone 5、5S
#define IS_RES_640X960_2X    CURRENT_RES == RES_640X960_2X   //iphone 4、4S
#define IS_RES_1536X2048_2X  CURRENT_RES == RES_1536X2048_2X //ipad

#define IS_RES_3X CURRENT_RES >= RES_1242X2208_3X

#define CGFLOAT_IS_EQUAL(a,b) (fabs((a) - (b)) < 0.00001)


@interface CLSystemHelper : NSObject

+ (NSUInteger)deviceSystemMajorVersion;    //iOS 系统版本 9
+ (NSString *)appVersion;                  //获取App版本号
+ (NSString *)deviceSystem;                //具体版本 9.3.5
+ (NSString *)deviceType;                  //设备类型 iPhone8,1
+ (NSString *)macAddress;                  //获取当前设备下的mac地址
+ (NSString *)netWorkState;                //当前网络状态 目前WWAN 状态下不区分2G、3G等

//对比当前系统版本号
+ (BOOL) deviceSystemEqualToString:(NSString *)string;
+ (BOOL) deviceSystemGreateThanString:(NSString *)string;
+ (BOOL) deviceSystemGreateThanOrEqualToString:(NSString *)string;
+ (BOOL) deviceSystemLessThanString:(NSString *)string;
+ (BOOL) deviceSystemLessThanOrEqualToString:(NSString *)string;

+ (CGFloat)lineHigh05;

//固定高度 算宽度
+ (CGSize)sizeWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font;
+ (CGSize)sizeWithText:(NSString *)text height:(CGFloat)height fontSize:(CGFloat)fontSize;

//固定宽度 算高度
+ (CGSize)sizeWithText:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize;
+ (CGSize)sizeWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font;


+ (CGSize)sizeWithAttributedText:(NSAttributedString *)text width:(CGFloat)width;
+ (CGSize)sizeWithAttributedText:(NSAttributedString *)text height:(CGFloat)height;

@end

