//
//  YQNetworking.h
//  YQNetworking
//
//  Created by yingqiu huang on 2017/2/10.
//  Copyright © 2017年 yingqiu huang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    
    CurrentRequestType_None,        //不需要AccToken
    CurrentRequestType_Other,       //需要
    CurrentRequestType_Remove,      //被剔除
    CurrentRequestType_TokenExpired,//token过期
    CurrentRequestType_SeverException//服务器异常 重新登
    
}CurrentRequestType;


typedef void(^YQResponseNewTokenBlock)(CurrentRequestType currentRequestType,NSString *token,NSError *error);
/**
 *  成功回调
 *
 *  @param response 成功后返回的数据
 */
typedef void(^YQResponseSuccessBlock)(id response);

/**
 *  失败回调
 *
 *  @param error 失败后返回的错误信息
 */
typedef void(^YQResponseFailBlock)(NSError *error);

/**
 *  下载进度
 *
 *  @param bytesRead              已下载的大小
 *  @param totalBytes                总下载大小
 */
typedef void (^YQDownloadProgress)(int64_t bytesRead,
                                   int64_t totalBytes);

/**
 *  下载成功回调
 *
 *  @param url                       下载存放的路径
 */
typedef void(^YQDownloadSuccessBlock)(NSURL *url);


/**
 *  上传进度
 *
 *  @param bytesWritten              已上传的大小
 *  @param totalBytes                总上传大小
 */
typedef void(^YQUploadProgressBlock)(int64_t bytesWritten,
                                     int64_t totalBytes);
/**
 *  多文件上传成功回调
 *
 *  @param responses 成功后返回的数据
 */
typedef void(^YQMultUploadSuccessBlock)(NSArray *responses);

/**
 *  多文件上传失败回调
 *
 *  @param errors 失败后返回的错误信息
 */
typedef void(^YQMultUploadFailBlock)(NSArray *errors);

typedef YQDownloadProgress YQGetProgress;

typedef YQDownloadProgress YQPostProgress;

typedef YQResponseFailBlock YQDownloadFailBlock;

@interface YQNetworking : NSObject


/**
 *  配置请求头
 *
 *  @param httpHeader 请求头
 */
+ (void)configHttpHeader:(NSDictionary *)httpHeader;

/**
 *    设置超时时间
 *
 *  @param timeout 超时时间
 */
+ (void)setupTimeout:(NSTimeInterval)timeout;

/**
 *  GET请求
 *  @param requestType      RequestType
 *  @param params           拼接参数
 *  @param finishBlock     成功回调
 */
+ (void)getWithRequestType:(RequestType)requestType withView:(UIView *)aView
                     params:(id)params tipMsg:(NSString *)tipMsg
                finishBlock:(YQResponseSuccessBlock)finishBlock;


/**
 *  POST请求
 *  @param requestType      RequestType
 *  @param params           拼接参数
 *  @param finishBlock     成功回调
 */
+ (void)postWithRequestType:(RequestType)requestType withView:(UIView *)aView
                     params:(id)params tipMsg:(NSString *)tipMsg 
                finishBlock:(YQResponseSuccessBlock)finishBlock;
/**
 *  POST请求
 *  @param requestType      RequestType
 *  @param params           拼接参数
 *  @param finishBlock     成功回调
 *  @param failBlock     失败回调
 */
+ (void)postWithRequestType:(RequestType)requestType withView:(UIView *)aView
                     params:(id)params tipMsg:(NSString *)tipMsg
                finishBlock:(YQResponseSuccessBlock)finishBlock
                failBlock:(YQResponseFailBlock)failBlock;

/**
 *  文件上传
 *  @param url              上传文件接口地址
 *  @param data             上传文件数据
 *  @param name             上传文件服务器文件夹名
 *  @param progressBlock    上传文件路径
 *  @param successBlock     成功回调
 *  @param failBlock        失败回调
 */
+ (void)uploadFileWithUrl:(NSString *)url
                 fileData:(NSData *)data
                     name:(NSString *)name param:(NSDictionary *)param
            progressBlock:(YQUploadProgressBlock)progressBlock
             successBlock:(YQResponseSuccessBlock)successBlock
                failBlock:(YQResponseFailBlock)failBlock;


/**
 *  多文件上传
 *
 *  @param url           上传文件地址
 *  @param datas         数据集合
 *  @param names          服务器文件夹名
 *  @param progressBlock 上传进度
 *  @param successBlock   成功回调
 *  @param failBlock     失败回调
 */
+ (void)uploadMultFileWithUrl:(NSString *)url
                    fileDatas:(NSArray *)datas
                        names:(NSArray *)names
                        param:(NSDictionary *)param
                progressBlock:(YQUploadProgressBlock)progressBlock
                 successBlock:(YQResponseSuccessBlock)successBlock
                    failBlock:(YQResponseFailBlock)failBlock;

/**
 *  文件下载
 *
 *  @param url           下载文件接口地址
 *  @param progressBlock 下载进度
 *  @param successBlock  成功回调
 *  @param failBlock     下载回调
 
 */
+ (void)downloadWithUrl:(NSString *)url
          progressBlock:(YQDownloadProgress)progressBlock
           successBlock:(YQDownloadSuccessBlock)successBlock
              failBlock:(YQDownloadFailBlock)failBlock;

/**
 *  身份保存认证POST请求
 *  @param requestType      RequestType
 *  @param params           拼接参数
 *  @param finishBlock     成功回调
 */
//+ (void)postWithCOSaveIdentityInfoRequestType:(RequestType)requestType withView:(UIView *)aView
//                     params:(id)params tipMsg:(NSString *)tipMsg
//                finishBlock:(YQResponseSuccessBlock)finishBlock;
@end



@interface YQNetworking (cache)

/**
 *  获取缓存目录路径
 *
 *  @return 缓存目录路径
 */
+ (NSString *)getCacheDiretoryPath;

/**
 *  获取下载目录路径
 *
 *  @return 下载目录路径
 */
+ (NSString *)getDownDirectoryPath;

/**
 *  获取缓存大小
 *
 *  @return 缓存大小
 */
+ (NSUInteger)totalCacheSize;

/**
 *  清除所有缓存
 */
+ (void)clearTotalCache;

/**
 *  获取所有下载数据大小
 *
 *  @return 下载数据大小
 */
+ (NSUInteger)totalDownloadDataSize;

/**
 *  清除下载数据
 */
+ (void)clearDownloadData;

@end

