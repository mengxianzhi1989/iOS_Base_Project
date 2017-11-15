//
//  ProductModel.h
//  iOS_Project
//
//  Created by mengxianzhi on 16/9/2.
//  Copyright © 2016年 mengxianzhi. All rights reserved.
//


//{
//    rows =     (
//                {
//                    agentPhone = "";
//                    cgCarLength = 0;
//                    cgCarType = "";
//                    cgComment = "13\U7c73";
//                    cgCompany = "";
//                    cgDate = "";
//                    cgEndDate = "";
//                    cgFcity = "\U77f3\U5bb6\U5e84\U5e02";
//                    cgFcounty = "";
//                    cgFprovince = "\U6cb3\U5317";
//                    cgHeight = 0;
//                    cgId = 8AAAB619712F4310B8CD0D765B7AB048;
//                    cgIsdeal = "1  ";
//                    cgIspay = "";
//                    cgIspublish = "";
//                    cgLen = 0;
//                    cgLinkman = "\U5b5f\U5148\U751f";
//                    cgMatters = "";
//                    cgName = "\U91cd\U8d27";
//                    cgPhone = 18634118299;
//                    cgPubTime = "2017-05-17 16:47:18.0";
//                    cgPubuserId = "";
//                    cgPubuserName = "";
//                    cgTcity = "\U5357\U4eac\U5e02";
//                    cgTcounty = "";
//                    cgTprovince = "\U6c5f\U82cf";
//                    cgTransCost = 0;
//                    cgTransMod = "";
//                    cgType = "";
//                    cgUnit = "";
//                    cgUploadTime = "";
//                    cgUserId = 036261864052483891EE613EDD46E262;
//                    cgUserName = "";
//                    cgUserTel = "";
//                    cgVolume = 91;
//                    cgWeight = 32;
//                    cgWidth = 0;
//                    cityAgId = "";
//                    consiAddr = "";
//                    consiPhone = "";
//                    consignee = "";
//                    countyAgId = "";
//                    delFlag = "1  ";
//                    infoMobile = "";
//                    infoSrc = 2;
//                    isSendInfo = 0;
//                    numberCase = 0;
//                    paymentDays = 0;
//                    picUrl = "<img height='45' width='45' src='/resource/info/images/center/up_img01.jpg'><img src='/resource/info/images/center/vip_icon.png'/>";
//                    provAgId = "";
//                    receiptAddr = "";
//                    receiptFlag = 0;
//                    receiptMan = "";
//                    receiptTel = "";
//                    tradeMode = 0;
//                    transitTime = 0;
//                    uLevel = 1;
//                },
//                {
//                    agentPhone = "";
//                    cgCarLength = 0;
//                    cgCarType = "";
//                    cgComment = "";
//                    cgCompany = "";
//                    cgDate = "";
//                    cgEndDate = "";
//                    cgFcity = "\U6cc9\U5dde\U5e02";
//                    cgFcounty = "\U5b89\U6eaa\U53bf";
//                    cgFprovince = "\U798f\U5efa";
//                    cgHeight = 0;
//                    cgId = 057438B1772D49BB8C426A776A71A21A;
//                    cgIsdeal = "1  ";
//                    cgIspay = "";
//                    cgIspublish = "";
//                    cgLen = 0;
//                    cgLinkman = "\U9ec4\U603b";
//                    cgMatters = "";
//                    cgName = "\U91cd\U8d27";
//                    cgPhone = 13055588885;
//                    cgPubTime = "2017-04-27 09:16:59.0";
//                    cgPubuserId = "";
//                    cgPubuserName = "";
//                    cgTcity = "\U6c55\U5934\U5e02";
//                    cgTcounty = "\U6f6e\U5357\U533a";
//                    cgTprovince = "\U5e7f\U4e1c";
//                    cgTransCost = 0;
//                    cgTransMod = "";
//                    cgType = "";
//                    cgUnit = "";
//                    cgUploadTime = "";
//                    cgUserId = 74C56E797FA44A54861B33D0DDB016B7;
//                    cgUserName = "";
//                    cgUserTel = "";
//                    cgVolume = 0;
//                    cgWeight = 32;
//                    cgWidth = 0;
//                    cityAgId = "";
//                    consiAddr = "";
//                    consiPhone = "";
//                    consignee = "";
//                    countyAgId = "";
//                    delFlag = "1  ";
//                    infoMobile = 13774770455;
//                    infoSrc = 1;
//                    isSendInfo = 0;
//                    numberCase = 0;
//                    paymentDays = 0;
//                    picUrl = "<img height='45' width='45' src='/resource/info/images/center/up_img01.jpg'><img src='/resource/info/images/center/tuijian_icon.png'/>,<img src='/resource/info/images/center/vip1_icon.png'/>";
//                    provAgId = "";
//                    receiptAddr = "";
//                    receiptFlag = 0;
//                    receiptMan = "";
//                    receiptTel = "";
//                    tradeMode = 0;
//                    transitTime = 0;
//                    uLevel = 1;
//                },
//                {
//                    agentPhone = "";
//                    cgCarLength = 0;
//                    cgCarType = "";
//                    cgComment = "";
//                    cgCompany = "";
//                    cgDate = "";
//                    cgEndDate = "";
//                    cgFcity = "\U6cc9\U5dde\U5e02";
//                    cgFcounty = "\U5b89\U6eaa\U53bf";
//                    cgFprovince = "\U798f\U5efa";
//                    cgHeight = 0;
//                    cgId = 86C1CF29E8D3445E9364AC1EAC846C0A;
//                    cgIsdeal = "1  ";
//                    cgIspay = "";
//                    cgIspublish = "";
//                    cgLen = 0;
//                    cgLinkman = "\U9ec4\U603b";
//                    cgMatters = "";
//                    cgName = "\U91cd\U8d27";
//                    cgPhone = 13055588885;
//                    cgPubTime = "2017-04-27 09:16:24.0";
//                    cgPubuserId = "";
//                    cgPubuserName = "";
//                    cgTcity = "\U6c55\U5934\U5e02";
//                    cgTcounty = "\U6f6e\U5357\U533a";
//                    cgTprovince = "\U5e7f\U4e1c";
//                    cgTransCost = 0;
//                    cgTransMod = "";
//                    cgType = "";
//                    cgUnit = "";
//                    cgUploadTime = "";
//                    cgUserId = 74C56E797FA44A54861B33D0DDB016B7;
//                    cgUserName = "";
//                    cgUserTel = "";
//                    cgVolume = 0;
//                    cgWeight = 32;
//                    cgWidth = 0;
//                    cityAgId = "";
//                    consiAddr = "";
//                    consiPhone = "";
//                    consignee = "";
//                    countyAgId = "";
//                    delFlag = "1  ";
//                    infoMobile = 13774770455;
//                    infoSrc = 1;
//                    isSendInfo = 0;
//                    numberCase = 0;
//                    paymentDays = 0;
//                    picUrl = "<img height='45' width='45' src='/resource/info/images/center/up_img01.jpg'><img src='/resource/info/images/center/tuijian_icon.png'/>,<img src='/resource/info/images/center/vip1_icon.png'/>";
//                    provAgId = "";
//                    receiptAddr = "";
//                    receiptFlag = 0;
//                    receiptMan = "";
//                    receiptTel = "";
//                    tradeMode = 0;
//                    transitTime = 0;
//                    uLevel = 1;
//                },
//                {
//                    agentPhone = "";
//                    cgCarLength = 0;
//                    cgCarType = "";
//                    cgComment = "";
//                    cgCompany = "";
//                    cgDate = "";
//                    cgEndDate = "";
//                    cgFcity = "\U6cc9\U5dde\U5e02";
//                    cgFcounty = "\U5b89\U6eaa\U53bf";
//                    cgFprovince = "\U798f\U5efa";
//                    cgHeight = 0;
//                    cgId = 8D1CC1B66E2C4AEC893AB79C28DB032B;
//                    cgIsdeal = "1  ";
//                    cgIspay = "";
//                    cgIspublish = "";
//                    cgLen = 0;
//                    cgLinkman = "\U9ec4\U603b";
//                    cgMatters = "";
//                    cgName = "\U91cd\U8d27";
//                    cgPhone = 13055588885;
//                    cgPubTime = "2017-04-27 09:15:48.0";
//                    cgPubuserId = "";
//                    cgPubuserName = "";
//                    cgTcity = "\U6c55\U5934\U5e02";
//                    cgTcounty = "\U6f6e\U5357\U533a";
//                    cgTprovince = "\U5e7f\U4e1c";
//                    cgTransCost = 0;
//                    cgTransMod = "";
//                    cgType = "";
//                    cgUnit = "";
//                    cgUploadTime = "";
//                    cgUserId = 74C56E797FA44A54861B33D0DDB016B7;
//                    cgUserName = "";
//                    cgUserTel = "";
//                    cgVolume = 0;
//                    cgWeight = 32;
//                    cgWidth = 0;
//                    cityAgId = "";
//                    consiAddr = "";
//                    consiPhone = "";
//                    consignee = "";
//                    countyAgId = "";
//                    delFlag = "1  ";
//                    infoMobile = 13774770455;
//                    infoSrc = 1;
//                    isSendInfo = 0;
//                    numberCase = 0;
//                    paymentDays = 0;
//                    picUrl = "<img height='45' width='45' src='/resource/info/images/center/up_img01.jpg'><img src='/resource/info/images/center/tuijian_icon.png'/>,<img src='/resource/info/images/center/vip1_icon.png'/>";
//                    provAgId = "";
//                    receiptAddr = "";
//                    receiptFlag = 0;
//                    receiptMan = "";
//                    receiptTel = "";
//                    tradeMode = 0;
//                    transitTime = 0;
//                    uLevel = 1;
//                },
//                {
//                    agentPhone = "";
//                    cgCarLength = 0;
//                    cgCarType = "";
//                    cgComment = "";
//                    cgCompany = "";
//                    cgDate = "";
//                    cgEndDate = "";
//                    cgFcity = "\U6cc9\U5dde\U5e02";
//                    cgFcounty = "\U5b89\U6eaa\U53bf";
//                    cgFprovince = "\U798f\U5efa";
//                    cgHeight = 0;
//                    cgId = AA09C28461E8449C813A3E456E08EA80;
//                    cgIsdeal = "1  ";
//                    cgIspay = "";
//                    cgIspublish = "";
//                    cgLen = 0;
//                    cgLinkman = "\U9ec4\U603b";
//                    cgMatters = "";
//                    cgName = "\U91cd\U8d27";
//                    cgPhone = 13055588885;
//                    cgPubTime = "2017-04-27 09:15:47.0";
//                    cgPubuserId = "";
//                    cgPubuserName = "";
//                    cgTcity = "\U6c55\U5934\U5e02";
//                    cgTcounty = "\U6f6e\U5357\U533a";
//                    cgTprovince = "\U5e7f\U4e1c";
//                    cgTransCost = 0;
//                    cgTransMod = "";
//                    cgType = "";
//                    cgUnit = "";
//                    cgUploadTime = "";
//                    cgUserId = 74C56E797FA44A54861B33D0DDB016B7;
//                    cgUserName = "";
//                    cgUserTel = "";
//                    cgVolume = 0;
//                    cgWeight = 32;
//                    cgWidth = 0;
//                    cityAgId = "";
//                    consiAddr = "";
//                    consiPhone = "";
//                    consignee = "";
//                    countyAgId = "";
//                    delFlag = "1  ";
//                    infoMobile = 13774770455;
//                    infoSrc = 1;
//                    isSendInfo = 0;
//                    numberCase = 0;
//                    paymentDays = 0;
//                    picUrl = "<img height='45' width='45' src='/resource/info/images/center/up_img01.jpg'><img src='/resource/info/images/center/tuijian_icon.png'/>,<img src='/resource/info/images/center/vip1_icon.png'/>";
//                    provAgId = "";
//                    receiptAddr = "";
//                    receiptFlag = 0;
//                    receiptMan = "";
//                    receiptTel = "";
//                    tradeMode = 0;
//                    transitTime = 0;
//                    uLevel = 1;
//                }
//                );
//    staticTime = "<null>";
//    success = 1;
//    total = 6514;
//    attributes =     {
//    };
//    disabled = "<null>";
//    info = ok;
//    keys = "<null>";
//    mileage = "<null>";
//    moveTime = "<null>";
//    redirect = "<null>";
//    returnId = "<null>";
//    row = "<null>";
//}



#import "BaseModel.h"

@interface RowModel : NSObject

@property (strong,nonatomic) NSString *cgFcity;
@property (strong,nonatomic) NSString *picUrl;
@property (strong,nonatomic) NSString *infoMobile;
@property (strong,nonatomic) NSString *cgUserId;

@end

@interface ProductModel : BaseModel

@property (strong,nonatomic) NSString *disabled;
@property (strong,nonatomic) NSString *myInfo;
@property (strong,nonatomic) NSArray<RowModel *> *rows;


@end
