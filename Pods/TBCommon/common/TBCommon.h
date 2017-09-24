//
//  Common.h
//  TextVersion
//
//  Created by toby on 04/09/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBCommon : NSObject

+ (NSString *)getSystemLanguage;
+ (NSString *)getVersionNumber;
//获得ip地址
+ (NSDictionary *)getIPAddresses;
//获得uuid
+ (NSString *)getUUID;

//获得设备型号
+ (NSString *)getDeviceModel;

/**
 比较两个版本号的大小
 
 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
 */
+ (NSInteger)compareVersion:(NSString *)v1 to:(NSString *)v2;

@end
