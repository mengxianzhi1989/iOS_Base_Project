//
//  PubilcClass.m
//  newYooli
//
//  Created by mengxianzhi on 16/7/17.
//  Copyright (c) 2015年 youjie.com. All rights reserved.
//

#import <sys/utsname.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import "PublicClass.h"
#include <sys/sysctl.h>
#import<SystemConfiguration/CaptiveNetwork.h>
#import<SystemConfiguration/SystemConfiguration.h>
#import<CoreFoundation/CoreFoundation.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define kLoadingViewTag 1991

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#define TOAST_DURATION 2
#define USFormat YES
#define THOUSAND_SEPARATOR (USFormat ? @"," : @".")
#define DECIMAL_SEPARATOR (USFormat ? @"." : @",")

#define PI 3.14159265

static PublicClass *publicClass = nil;
@implementation PublicClass

+ (instancetype)shareInstace{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        publicClass = [[PublicClass alloc]init];
    });
    return publicClass;
}
+(NSString *)phoneNumberTranferToStart:(NSString *)phone {
    NSMutableString *star = [NSMutableString string];
    int count = (int)phone.length;
    for(int i = 0;i < count;i++) {
        char u = [phone characterAtIndex:i];
        if(i > 2 && i < 7) {
            [star appendString:@"*"];
        }
        else {
            [star appendFormat:@"%c",u];
        }
    }
    
    return star;
}

+(NSString *)formatToCurrency:(double)v {
    return [self formatToCurrency:v decimalPoint:2];
}

+(NSString *)formatNSNumberToCurrency:(NSNumber *)v {
    double currency = v.doubleValue;
    return [self formatToCurrency:currency];
}

+(NSString *)formatToCurrency:(double)v decimalPoint:(int)decimalPoint {
    int dp = decimalPoint;
    NSString *delim = THOUSAND_SEPARATOR;
    NSString *decpt = DECIMAL_SEPARATOR;
    NSMutableString *vs = [NSMutableString stringWithCapacity:20];
    if (v < 0.0) {
        v *= -1;
    }
    
    long long int iv = (long long int) (v * pow(10.0, dp) + 0.5);
    do {
        if (iv <= 0ll && dp < 0) break;
        long long int div = iv % 10ll;
        [vs appendFormat:@"%lld", div];
        iv /= 10ll;
        if (--dp == 0) [vs appendFormat:@"%@",decpt];
        if (dp < 0 && iv > 0ll && dp % 3 == 0) [vs appendFormat:@"%@",delim];
    } while (YES);
    
    NSMutableString *reversedStr;
    NSUInteger len = [vs length];
    reversedStr = [NSMutableString stringWithCapacity:len];
    while (len > 0)
        [reversedStr appendString:
         [NSString stringWithFormat:@"%C", [vs characterAtIndex:--len]]];
    
    return reversedStr;
}

+(UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//根据BOLD字体，获取字符串宽度
+(CGSize)string:(NSString*)aStr withBoldFontSize:(CGFloat)aSize {
    CGSize stringSize = [aStr sizeWithAttributes:@{ NSFontAttributeName:[UIFont boldSystemFontOfSize:aSize]}];
    return stringSize;
}

//根据字体，获取字符串宽度
+(CGSize)string:(NSString*)aStr withFontSize:(CGFloat)aSize {
    CGSize stringSize = [aStr sizeWithAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:aSize]}];
    return stringSize;
}

+(CGSize)string:(NSString*)aStr withFont:(UIFont *)font{
    CGSize stringSize = [aStr sizeWithAttributes:@{ NSFontAttributeName:font}];
    return stringSize;
}

//输入字符串，字体大小，限制宽度 得出高度
+(CGSize)string:(NSString*)aStr withFont:(CGFloat)aSize withMaxWidth:(CGFloat)aMaxWidth {
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:aSize], NSParagraphStyleAttributeName:paragraphStyle};
    CGSize stringSize = [aStr boundingRectWithSize:CGSizeMake(aMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return stringSize;
}

//输入字符串，字体大小，限制宽度 得出高度
+(CGSize)stringSize:(NSString *)str font:(UIFont *)font color:(UIColor *)color width:(CGFloat)width
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                   NSFontAttributeName: font,NSStrokeColorAttributeName: color, NSParagraphStyleAttributeName: paragraph
                                                                                                                                   } context:nil];
    return rect.size;
}

+(NSString*)currentTimestampSince1970 {
    NSDate *datenow = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    NSTimeInterval a=[localeDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%0.f", a];
}

//缓存数据到cache目录
+(void)saveCacheData:(id)aData withFilename:(NSString*)aFilename{
    NSString *documentdir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *tileDirectory = [documentdir stringByAppendingPathComponent:aFilename];
    [NSKeyedArchiver archiveRootObject:aData toFile:tileDirectory];
}

//读取cache目录下文件
+(id)readCacheDatawithFilename:(NSString*)aFilename {
    NSString *documentdir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *tileDirectory = [documentdir stringByAppendingPathComponent:aFilename];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:tileDirectory];
}


//时间戳转换为时间（yy.mm.dd hh:mm）
+(NSString*)timestamptoNSDate_Y_M_D_H:(long long int)aTimeStamp {
    aTimeStamp = aTimeStamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimeStamp];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy.MM.dd HH:mm"];
    NSString* dataStr = [dateFormat stringFromDate:confromTimesp];
    return dataStr;
}
//时间戳转换为时间（yy-mm-dd hh:mm）
+(NSString*)timestamptoNSDateY_M_D_H_M_S:(long long int)aTimeStamp{
    aTimeStamp = aTimeStamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimeStamp];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* dataStr = [dateFormat stringFromDate:confromTimesp];
    return dataStr;
}

+(NSString*)timestamptoNSDate_D_H:(long long)aTimeStamp {
    aTimeStamp = aTimeStamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimeStamp];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    NSString* dataStr = [dateFormat stringFromDate:confromTimesp];
    return dataStr;
}

//时间戳转换为时间（mm月dd日）
+(NSString*)timestamptoNSDate_M_D:(long long int)aTimeStamp {
    aTimeStamp = aTimeStamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimeStamp];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM月dd日"];
    NSString* dataStr = [dateFormat stringFromDate:confromTimesp];
    return dataStr;
}

//时间戳转换为时间（yy.mm.dd）
+(NSString*)timetoNSDate_Y_M_D:(long long int)aTimeStamp {
    aTimeStamp = aTimeStamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimeStamp];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy.MM.dd"];
    NSString* dataStr = [dateFormat stringFromDate:confromTimesp];
    return dataStr;
}

//mm.dd
+(NSString *)timestamptoDecimalNSDate_M_D:(long long)aTimeStamp {
    aTimeStamp = aTimeStamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimeStamp];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM.dd"];
    NSString* dataStr = [dateFormat stringFromDate:confromTimesp];
    return dataStr;
}

//时间戳转换为时间（yyyy年mm月dd日）
+(NSString*)timestamptoNSDate_Y_M_D:(long long int)aTimeStamp {
    aTimeStamp = aTimeStamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimeStamp];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日"];
    NSString* dataStr = [dateFormat stringFromDate:confromTimesp];
    return dataStr;
}

+(NSString *)timestamptoLineNSDate_Y_M_D:(long long)aTimeStamp {
    aTimeStamp = aTimeStamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimeStamp];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString* dataStr = [dateFormat stringFromDate:confromTimesp];
    return dataStr;
}
+(NSString *)timestamp:(long long)aTimeStamp {
    aTimeStamp = aTimeStamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimeStamp];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dataStr = [dateFormat stringFromDate:confromTimesp];
    return dataStr;
}
+(NSString *)timestamptoLineNSDate_M_D:(long long)aTimeStamp {
    aTimeStamp = aTimeStamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimeStamp];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd"];
    NSString* dataStr = [dateFormat stringFromDate:confromTimesp];
    return dataStr;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (NSString*)weekdayStringFromTimeStamp:(long long)aTimeStamp {
    NSDate *inputDate = [NSDate dateWithTimeIntervalSince1970:aTimeStamp/1000];
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (long long)compareTimeStamp:(NSString *)beginTimestamp other:(NSString *)endTimestamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:MM:ss"];//@"yyyy-MM-dd-HHMMss"
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[beginTimestamp longLongValue]];
    //    NSString *dateString = [formatter stringFromDate:date];
    //    NSLog(@"开始时间: %@", dateString);
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[endTimestamp longLongValue]];
    //    NSString *dateString2 = [formatter stringFromDate:date2];
    //    NSLog(@"结束时间: %@", dateString2);
    
    NSTimeInterval seconds = [date2 timeIntervalSinceDate:date];
    //    NSLog(@"两个时间相隔：%f 秒", seconds);
    
    return seconds;
}

+ (NSString *)getCurrentDetailDate {
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    return locationString;
}

+(UILabel *)createLabel {
    return [self createLabel:nil color:nil];
}

+(UILabel *)createLabel:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.textColor = color;
    return label;
}

+(UITextField *)createTextField:(UIFont *)font color:(UIColor *)color {
    UITextField *text = [[UITextField alloc]init];
    text.backgroundColor = [UIColor clearColor];
    text.font = font;
    text.textColor = color;
    return text;
}

//+(UIButton *)creatSubmitBtn:(NSString *)title targe:(id)targe method:(SEL)method {
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.layer.cornerRadius = 4.0;
//    btn.layer.masksToBounds = YES;
//    btn.backgroundColor = [UIColor clearColor];
//    [btn setTitle:title forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
//    [btn setBackgroundImage: [PubilcClass createImageWithColor:rgbColor(70, 165, 246)] forState:UIControlStateNormal];
//    [btn setTitleColor:rgbColor(255, 255, 255) forState:UIControlStateNormal];
//    [btn addTarget:targe action:method forControlEvents:UIControlEventTouchUpInside];
//    return btn;
//}
//
//+(UIButton *)createBottomBtn:(NSString *)title cornerRadius:(CGFloat)radius frame:(CGRect )frame targe:(id)targe method:(SEL)method
//{
//    UIButton *btn= [self creatSubmitBtn:title targe:targe method:method];
//    btn.layer.cornerRadius = radius;
//    btn.frame = frame;
//    return btn;
//}
//
//+(UIButton *)creatRightBtn:(NSString *)title targe:(id)targe method:(SEL)method {
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:title forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
//    [btn setTitleColor:UIColorFromRGB(0x444444) forState:UIControlStateNormal];
//    [btn addTarget:targe action:method forControlEvents:UIControlEventTouchUpInside];
//    return btn;
//}

+(UIView *)createLineView:(CGRect)frame bgColor:(UIColor *)bgColor {
    if (bgColor == nil) {
        bgColor = UIColorFromRGB(0xE9E9E9);
    }
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = bgColor;
    [self drawOneLine:CGRectMake(0, 0, view.width, [CLSystemHelper lineHigh05]) toView:view color:bgColor];
    [self drawOneLine:CGRectMake(0, view.height-[CLSystemHelper lineHigh05], view.width,[CLSystemHelper lineHigh05]) toView:view color:bgColor];
    return view;
}

+(void)drawOneLine:(CGRect)frame toView:(UIView *)toView color:(UIColor *)color {
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = color;
    [toView addSubview:lineView];
}

+(NSString *)rechargeMoney:(long long)money {
    if(money <= 0) return nil;
    if(money >= 10000) {
        if(money%10000 == 0) {
            return [NSString stringWithFormat:@"%lld万",money/10000];
        }else {
            return [NSString stringWithFormat:@"%.2lld万",money/10000];
        }
    }else if (money >= 1000) {
        if(money%1000 == 0) {
            return [NSString stringWithFormat:@"%lld千",money/1000];
        }else {
            return [NSString stringWithFormat:@"%.2lld千",money/1000];
        }
    }
    return [NSString stringWithFormat:@"%lld",money];
}

+(UIView *)createLabel:(NSString *)text withIcon:(NSString *)iconName andFontSize:(float)fontSize distance:(float)distance backColor:(UIColor *)backColor textColor:(UIColor *)textColor
{
    UIImage *image = [UIImage imageNamed:iconName];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    imageV.image = image;
    [imageV sizeToFit];
    CGSize size = [PublicClass string:text withFontSize:fontSize];
    float height = imageV.height > size.height?imageV.height : size.height;
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, imageV.width+distance+size.width, height)];
    [imageV setTop:0.5*(backV.height-imageV.height)];
    backV.backgroundColor = backColor;
    [backV addSubview:imageV];
    UILabel *label = [PublicClass createLabel:[UIFont systemFontOfSize:fontSize] color:textColor];
    label.frame = CGRectMake(imageV.right+distance, 0, size.width, height);
    label.text = text;
    [backV addSubview:label];
    return backV;
}

+(UILabel *)createSizeFitLabelWithText:(NSString *)text FontSize:(float)fontSize  textColor:(UIColor *)textColor
{
    CGSize size = [PublicClass string:text withFontSize:fontSize];
    UILabel *label = [PublicClass createLabel:[UIFont systemFontOfSize:fontSize] color:textColor];
    label.frame = CGRectMake(0, 0, size.width, size.height);
    label.text = text;
    return label;
}

+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

+(NSString *)changeToChinese:(NSString *)numstr
{
    double numberals=[numstr doubleValue];
    NSArray *numberchar = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSArray *inunitchar = @[@"",@"拾",@"佰",@"仟"];
    NSArray *unitname = @[@"",@"万",@"亿",@"万亿"];
    //金额乘以100转换成字符串（去除圆角分数值）
    NSString *valstr=[NSString stringWithFormat:@"%.2f",numberals];
    NSString *prefix;
    NSString *suffix;
    if (valstr.length<=2) {
        prefix=@"零元";
        if (valstr.length==0) {
            suffix=@"零角零分";
        }
        else if (valstr.length==1)
        {
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[valstr intValue]]];
        }
        else
        {
            NSString *head=[valstr substringToIndex:1];
            NSString *foot=[valstr substringFromIndex:1];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[head intValue]],[numberchar objectAtIndex:[foot intValue]]];
        }
    }
    else {
        prefix=@"";
        suffix=@"";
        int flag=(int)valstr.length-2;
        NSString *head=[valstr substringToIndex:flag-1];
        NSString *foot=[valstr substringFromIndex:flag];
        if (head.length>13) {
            return@"数值太大（最大支持13位整数），无法处理";
        }
        //处理整数部分
        NSMutableArray *ch=[[NSMutableArray alloc]init];
        for (int i = 0; i < head.length; i++) {
            NSString * str=[NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'];
            [ch addObject:str];
        }
        int zeronum=0;
        
        for (int i=0; i<ch.count; i++) {
            int index=(ch.count -i-1)%4;//取段内位置
            int indexloc=(int)(ch.count -i-1)/4;//取段位置
            if ([[ch objectAtIndex:i]isEqualToString:@"0"]) {
                zeronum++;
            }
            else
            {
                if (zeronum!=0) {
                    if (index!=3) {
                        prefix=[prefix stringByAppendingString:@"零"];
                    }
                    zeronum=0;
                }
                prefix=[prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]];
                prefix=[prefix stringByAppendingString:[inunitchar objectAtIndex:index]];
            }
            if (index ==0 && zeronum<4) {
                prefix=[prefix stringByAppendingString:[unitname objectAtIndex:indexloc]];
            }
        }
        prefix =[prefix stringByAppendingString:@"元"];
        //处理小数位
        if ([foot isEqualToString:@"00"]) {
            suffix =[suffix stringByAppendingString:@"整"];
        }else if ([foot hasPrefix:@"0"])
        {
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[footch intValue] ]];
        }else{
            NSString *headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar objectAtIndex:[footch intValue]]];
        }
    }
    return [prefix stringByAppendingString:suffix];
}

+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

- (void)getWifiName{
    NSString *wifiName = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            wifiName = [dict valueForKey:@"SSID"];
        }
        DLog(@"wifiName:%@", wifiName);
    }
}

+ (NSString*)getCurrentLocalIP{
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)getCurreWiFiSsid{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return [(NSDictionary*)info objectForKey:@"SSID"];
}

- (NSString *)getIPAddress{
    BOOL preferIPv4 = YES;
    NSArray *searchArray = preferIPv4 ?
    @[IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx,  BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}


#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

//是否越狱
- (BOOL)isJailBreak
{
    for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}


- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP)) {
                continue;
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (void)showViewHUDwithSuperView:(UIView *)aView andText:(NSString *)aStr {
    
    if ([aView viewWithTag:kLoadingViewTag]) {
        return;
    }
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [bgView setBackgroundColor:[UIColor redColor]];
    [bgView setBackgroundColor:[UIColor clearColor]];
    bgView.tag = kLoadingViewTag;
    [aView addSubview:bgView];
    
    UIView* realBgView = [[UIView alloc] initWithFrame:CGRectMake(0.5*(kScreenWidth - 120), 0.5*(kScreenHeight - 120), 120, 120)];
    
    [realBgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f]];
    [realBgView.layer setMasksToBounds:YES];
    [realBgView.layer setCornerRadius:10.0f];
    [bgView addSubview:realBgView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((realBgView.width - 37)/2, 25, 37, 37)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [realBgView addSubview:activityIndicator];
    activityIndicator.color = [UIColor whiteColor];
    [activityIndicator startAnimating];
    
    //提示文字
    if (aStr != nil && [aStr length]>0) {
        CGSize textSize = [PublicClass string:aStr withFont:14 withMaxWidth:80];
        UILabel* tipsLabel = [[UILabel alloc] init];
        [tipsLabel setText:aStr];
        [tipsLabel setFont:[UIFont systemFontOfSize:14]];
        [tipsLabel setTextColor:[UIColor whiteColor]];
        [tipsLabel setTextAlignment:NSTextAlignmentCenter];
        [tipsLabel setFrame:CGRectMake((realBgView.width - textSize.width)/2, activityIndicator.bottom + 15, textSize.width, textSize.height)];
        tipsLabel.numberOfLines = 0;
        [realBgView addSubview:tipsLabel];
    }
}

+ (void)clearViewViewHUDFromSuperView:(UIView *)aView {
    UIView* bgView = [aView viewWithTag:kLoadingViewTag];
    [bgView removeFromSuperview];
}

+ (NSString *)md5_uppercaseString:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return  [output uppercaseString];
}

+ (NSString *)trim:(NSString *)string{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (BOOL)responseSuccess:(NSDictionary *)responseDic{
    return [[responseDic objectForKey:@"retCode"] intValue] == 200;
}

+ (NSString *)responseretMsg:(NSDictionary *)responseDic{
    return SafeString([responseDic objectForKey:@"retMsg"]);
}

+ (NSDictionary *)responseRetData:(NSDictionary *)responseDic{
    return [responseDic objectForKey:@"retData"];
}

// 创建个圆角蓝色的button
+ (UIButton *)createBlueRoundedCornersButton:(NSString *)name rect:(CGRect)rect{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rect];
    [button setTitle:name forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:UIColorFromRGB(0x428cfc)];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = rect.size.height/2;
    return button;
}

+ (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

+ (NSString *)base64StringWithImage:(UIImage *)image{
     NSData * data = [UIImagePNGRepresentation(image) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
     return [NSString stringWithUTF8String:[data bytes]];
}

+ (UIImage *)imageWithBase64String:(NSString *)base64String{
    NSData *data = [[NSData alloc] initWithBase64Encoding:base64String];
    return [UIImage imageWithData:data];
}

+ (UIImage *)imageWithURLString:(NSString *)urlString{
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    
    return image;
}

+ (BOOL)compareVersionWithSeverVersion:(NSString *)severVersion locationVersion:(NSString *)locationVersion{
    // 获取各个版本号对应版本信息
    NSMutableArray *versionStep1 = [NSMutableArray arrayWithArray:[locationVersion componentsSeparatedByString:@"."]];
    NSMutableArray *versionStep2 = [NSMutableArray arrayWithArray:[severVersion componentsSeparatedByString:@"."]];
    
    // 补全版本信息为相同位数
    while (versionStep1.count < versionStep2.count) {
        [versionStep1 addObject:@"0"];
    }
    while (versionStep2.count < versionStep1.count) {
        [versionStep2 addObject:@"0"];
    }
    // 遍历每一个版本信息中的位数
    // 记录比较结果值
    BOOL compareResutl = NO;
    for(NSUInteger i = 0; i < versionStep1.count; i++){
        NSInteger versionNumber1 = [versionStep1[i] integerValue];
        NSInteger versionNumber2 = [versionStep2[i] integerValue];
        if (versionNumber1 < versionNumber2) {
            compareResutl = YES;
            break;
        }else if (versionNumber2 < versionNumber1){
            compareResutl = NO;
            break;
        }else{
            compareResutl = NO;
        }
    }
    return compareResutl;
}

+ (void)showToastMessage:(NSString *)msg {
    [[self class] showToastMessage:msg duration:1];
}

+ (void)showToastMessage:(NSString *)msg duration:(NSTimeInterval)duration {
    [[self class] showToast:nil message:msg duration:duration position:0];
}

+ (void)showToast:(id)view message:(NSString *)msg duration:(NSTimeInterval)duration position:(CGFloat)originY {
    if (!msg) {
        return;
    }
    
    if (view == nil) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageFont = F14;
    style.messageAlignment = NSTextAlignmentCenter;
    
    id position = CSToastPositionCenter;
    if (originY == 0) {
        position = CSToastPositionCenter;
    } else if (originY == -1) {
        position = CSToastPositionTop;
    } else if (originY == 1) {
        position = CSToastPositionBottom;
    } else {
        position = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2.0, originY)];
    }
    
    [view makeToast:msg duration:duration position:position style:style];
}
+ (void)jumpSystemViewWithURL_String:(NSString *)urlString{
    
    if (@available(iOS 10.0, *)) {
        
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    
}
@end

