//
//  PHIUserManager.m
//  Phippy
//
//  Created by toby on 19/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "PHIUserManager.h"


@implementation PHIUserManager


#pragma mark lift cycle

+ (NSString *)getPathForDeliveryAddressData{
    return [NSString stringWithFormat:@"%@/DeliveryAddress",[self getDocumentPath]];
}

+ (NSString *)getDocumentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)getCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
   return [paths objectAtIndex:0];
}

+ (NSString *)getTmpPath{
return NSTemporaryDirectory();
}

static PHIUserManager * _instance = nil;
+ (instancetype)shareManager{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
        
     
    }) ;
    return _instance ;
}


+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [PHIUserManager shareManager] ;
}

- (id) copyWithZone:(struct _NSZone *)zone
{
    return [PHIUserManager shareManager] ;
}

- (void)setDownloadImageOnlyWifi:(BOOL)downloadImageOnlyWifi{

    [[NSUserDefaults standardUserDefaults] setBool:downloadImageOnlyWifi forKey:@"phi_downloadImageOnlyWifi"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)downloadImageOnlyWifi{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"phi_downloadImageOnlyWifi"];
}

- (void)saveObject:(id)obj forKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
