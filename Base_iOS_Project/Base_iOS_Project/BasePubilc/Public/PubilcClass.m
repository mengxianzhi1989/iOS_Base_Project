//
//  PubilcClass.m
//  newYooli
//
//  Created by zengbaoquan on 15/7/17.
//  Copyright (c) 2015年 youjie.com. All rights reserved.
//

#import <sys/utsname.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import "PubilcClass.h"
#include <sys/sysctl.h>
#import "UIView+Toast.h"

#define TOAST_DURATION 2
#define USFormat YES
#define THOUSAND_SEPARATOR (USFormat ? @"," : @".")
#define DECIMAL_SEPARATOR (USFormat ? @"." : @",")

#define TEST_CLIENT_PW "ZKd6LJhCL5Jz6qbjmpaG"
#define PI 3.14159265

@implementation PubilcClass


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

//UIcolor to UIImage
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

//输入字符串，字体大小，限制宽度 得出高度
+(CGSize)string:(NSString*)aStr withFont:(CGFloat)aSize withLimitWidth:(CGFloat)aLimitWidth {
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:aSize], NSParagraphStyleAttributeName:paragraphStyle};
    CGSize stringSize = [aStr boundingRectWithSize:CGSizeMake(aLimitWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
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

//添加全局视图
+(void)addGlobalView:(UIView *)view withType:(YJ_GlobalView_ID)aType {
    //注：索引值越高，视图的层级越靠近顶部.
    view.tag = aType;
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [window endEditing:YES];
    for(int i = 0; i < window.subviews.count; i++) {
        int viewID = (int)((UIView*)[window.subviews objectAtIndex:i]).tag;
        if(viewID >= YJ_GView_Expand && viewID < YJ_GView_Edge){
            
            if(aType < viewID) {
                [window insertSubview:view atIndex:i];
                return;
            }else if(aType == viewID) {
                //夜间模式只添加一次
                if (aType == YJ_GView_Night) {
                    return;
                }
                if (aType == YJ_GView_UnlockV) {
                    for (UIViewController *control in window.rootViewController.childViewControllers) {
//                        if ([control isKindOfClass:[YJGesturesPasswordVCtr class]]||[control isKindOfClass:[TouchIDVCtr class]]) {
//                            [control removeFromParentViewController];
//                        }
                    }
                    [PubilcClass removeGlobalView:YJ_GView_UnlockV];
                }
            }
        }
    }
    [window addSubview:view];
}

//移除全局视图
+(void)removeGlobalView:(YJ_GlobalView_ID)aType {
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    UIView* view = [window viewWithTag:aType];
    if (view != nil) {
        if (aType == YJ_GView_UnlockV && view.subviews) {
            [view removeAllSubviews];
        }
        
        [view removeFromSuperview];
    }
}

//查看是否存在全局视图 by id
+(BOOL)isExitingGolbalView:(YJ_GlobalView_ID)aType {
    BOOL isExit = NO;
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    UIView* view = [window viewWithTag:aType];
    if (view != nil) {
        isExit = YES;
    }
    
    return isExit;
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
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}
+ (NSString*)weekdayStringFromTimeStamp:(long long)aTimeStamp {
    NSDate *inputDate = [NSDate dateWithTimeIntervalSince1970:aTimeStamp/1000];
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
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

+(UIButton *)creatSubmitBtn:(NSString *)title targe:(id)targe method:(SEL)method {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 4.0;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btn setBackgroundImage: [PubilcClass createImageWithColor:rgbColor(70, 165, 246)] forState:UIControlStateNormal];
    [btn setTitleColor:rgbColor(255, 255, 255) forState:UIControlStateNormal];
    [btn addTarget:targe action:method forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+(UIButton *)createBottomBtn:(NSString *)title cornerRadius:(CGFloat)radius frame:(CGRect )frame targe:(id)targe method:(SEL)method
{
   UIButton *btn= [self creatSubmitBtn:title targe:targe method:method];
    btn.layer.cornerRadius = radius;
    btn.frame = frame;
    return btn;
}
+(UIButton *)creatRightBtn:(NSString *)title targe:(id)targe method:(SEL)method {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btn setTitleColor:UIColorFromRGB(0x444444) forState:UIControlStateNormal];
    [btn addTarget:targe action:method forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+(UIView *)createLineView:(CGRect)frame bgColor:(UIColor *)bgColor {
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = bgColor;
    [self drawOneLine:CGRectMake(0, 0, view.width, 0.5) toView:view color:rgbColor(239, 239, 239)];
    [self drawOneLine:CGRectMake(0, view.height-0.5, view.width, 0.5) toView:view color:rgbColor(239, 239, 239)];
    return view;
}

+(void)drawOneLine:(CGRect)frame toView:(UIView *)toView color:(UIColor *)color {
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = color;
    [toView addSubview:lineView];
}

+(double)calculateIncomeAccordingInterestRate:(float)rate andMonth:(int)month andInvestAmount:(double)investAmount {
    double income = investAmount*rate*month /(100 *12);
    return income;
}

+(NSString *)rechargeMoney:(long long)money {
    if(money <= 0) return nil;
    if(money >= 10000) {
        if(money%10000 == 0) {
            return [NSString stringWithFormat:@"%lld万",money/10000];
        }
        else {
            return [NSString stringWithFormat:@"%.2lld万",money/10000];
        }
    }
    else if (money >= 1000) {
        if(money%1000 == 0) {
            return [NSString stringWithFormat:@"%lld千",money/1000];
        }
        else {
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
    CGSize size = [PubilcClass string:text withFontSize:fontSize];
    float height = imageV.height > size.height?imageV.height : size.height;
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, imageV.width+distance+size.width, height)];
    [imageV setTop:0.5*(backV.height-imageV.height)];
    backV.backgroundColor = backColor;
    [backV addSubview:imageV];
    UILabel *label = [PubilcClass createLabel:[UIFont systemFontOfSize:fontSize] color:textColor];
    label.frame = CGRectMake(imageV.right+distance, 0, size.width, height);
    label.text = text;
    [backV addSubview:label];
    return backV;
}

+(UILabel *)createSizeFitLabelWithText:(NSString *)text FontSize:(float)fontSize  textColor:(UIColor *)textColor
{
    CGSize size = [PubilcClass string:text withFontSize:fontSize];
    UILabel *label = [PubilcClass createLabel:[UIFont systemFontOfSize:fontSize] color:textColor];
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
        }else
        {
            NSString *headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar objectAtIndex:[footch intValue]]];
        }
    }
    return [prefix stringByAppendingString:suffix];
}

@end

