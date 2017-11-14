//
//  ZSJudgeResolution.m
//  ZolSoft
//
//  Created by lxy on 14-10-29.
//
//

#import "CLSystemHelper.h"
#import <sys/utsname.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import "Reachability.h"

#define Resolution_640X960_2X CGSizeMake(640.0f, 960.0f)
#define Resolution_640X1136_2X CGSizeMake(640.0f, 1136.0f)
#define Resolution_750X1334_2X CGSizeMake(750.0f, 1334.0f)
#define Resolution_1242X2208_3X CGSizeMake(1242.0f, 2208.0f)
#define Resolution_1536X2048_2X CGSizeMake(1536.0f,2048.0f)
#define Resolution_768X1024_1X CGSizeMake(768.0f,1024.0f)
#define Resolution_750X1334_2X_Scale_1_5 CGSizeMake(Resolution_750X1334_2X.width * 1.5, Resolution_750X1334_2X.height * 1.5)  //750X1334X1.5  iPhone6P下放大模式屏幕的分辨率为iPhone6下的1.5倍



@implementation CLSystemHelper

+ (CLDeviceResolution)currentResolution{
    
    static enum CLDeviceResolution _currentResolution = RES_None;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize screenSize = [[UIScreen mainScreen] currentMode].size;
        if (CGSizeEqualToSize(Resolution_1242X2208_3X, screenSize)) {
            _currentResolution = RES_1242X2208_3X;
        }else if(CGSizeEqualToSize(Resolution_750X1334_2X, screenSize) || CGSizeEqualToSize(Resolution_750X1334_2X_Scale_1_5, screenSize)){
            _currentResolution = RES_750X1334_2X;
        }else if (CGSizeEqualToSize(Resolution_640X1136_2X, screenSize)){
            _currentResolution = RES_640X1136_2X;
        }else if (CGSizeEqualToSize(Resolution_640X960_2X, screenSize)){
            _currentResolution = RES_640X960_2X;
        }else if (CGSizeEqualToSize(Resolution_1536X2048_2X, screenSize)|| CGSizeEqualToSize(Resolution_768X1024_1X, screenSize)) {
            _currentResolution = RES_1536X2048_2X;
        }else{
            NSAssert(0, @"No Resolution");
            _currentResolution = RES_640X1136_2X;
        }
    });
    return _currentResolution;
    
}

+ (NSUInteger)deviceSystemMajorVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion]
                                       componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

+ (BOOL) deviceSystemEqualToString:(NSString *)string
{
    return ([self compareString:string] == NSOrderedSame);
}

+ (BOOL) deviceSystemGreateThanString:(NSString *)string
{
    return ([self compareString:string] == NSOrderedDescending);
}

+ (BOOL) deviceSystemGreateThanOrEqualToString:(NSString *)string
{
    return([self compareString:string] != NSOrderedAscending);
}

+ (BOOL) deviceSystemLessThanString:(NSString *)string
{
    return ([self compareString:string] == NSOrderedAscending);
}

+ (BOOL) deviceSystemLessThanOrEqualToString:(NSString *)string
{
    return ([self compareString:string] != NSOrderedDescending);
}

+ (NSString *)deviceSystem
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSInteger)compareString:(NSString *)string
{
    return [[self deviceSystem] compare:string options:NSNumericSearch];
}

+ (NSString*)deviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    //采用后台映射
    return platform;
}

+ (NSString *)netWorkState {
    Reachability  *reach = [Reachability reachabilityForInternetConnection];
    NSInteger newState = [reach currentReachabilityStatus];
    switch (newState) {
        case 0:
            return @"无网络";
            break;
        case 1:
            return @"WiFi";
            break;
        case 2:
            return @"WWAN";
            break;
        default:
            return @"";
            break;
    }
}

+ (NSString *)macAddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
    
}


+ (CGFloat)lineHigh05 {
    static CGFloat _lineHigh = 0.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([self deviceSystemMajorVersion] == 6 || CGFLOAT_IS_EQUAL([UIScreen mainScreen].scale, 1.0f)) {
            _lineHigh = 1.0f;
        } else {
            if ([self currentResolution] >= RES_1242X2208_3X) {
                _lineHigh = 0.33f;
            } else {
                _lineHigh = 0.5f;
            }
        }
    });
    return _lineHigh;
}

+ (CGSize)sizeWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font {
    return [self sizeWithText:text size:CGSizeMake(width, CGFLOAT_MAX) font:font];
}

+ (CGSize)sizeWithText:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize {
    return [self sizeWithText:text size:CGSizeMake(width, CGFLOAT_MAX) font:[UIFont systemFontOfSize:fontSize]];
}

+ (CGSize)sizeWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font {
    return [self sizeWithText:text size:CGSizeMake(CGFLOAT_MAX, height) font:font];
}

+ (CGSize)sizeWithText:(NSString *)text height:(CGFloat)height fontSize:(CGFloat)fontSize {
    return [self sizeWithText:text size:CGSizeMake(CGFLOAT_MAX, height) font:[UIFont systemFontOfSize:fontSize]];
}

+ (CGSize)sizeWithText:(NSString *)text size:(CGSize)size font:(UIFont *)font {
    CGSize returnSize = CGSizeZero;
    returnSize = [text boundingRectWithSize:CGSizeMake(size.width,size.height)
                                    options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                 attributes:@{NSFontAttributeName:font}
                                    context:nil].size;
    return returnSize;
}

+ (CGSize)sizeWithText:(NSString *)text size:(CGSize)size fontSize:(CGFloat)fontSize {
    CGSize returnSize = CGSizeZero;
    returnSize = [text boundingRectWithSize:CGSizeMake(size.width,size.height)
                                    options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                    context:nil].size;
    return returnSize;
}

+ (CGSize)sizeWithAttributedText:(NSAttributedString *)text width:(CGFloat)width {
    return [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                              context:nil].size;
}

+ (CGSize)sizeWithAttributedText:(NSAttributedString *)text height:(CGFloat)height {
    return [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                              context:nil].size;
}

@end
