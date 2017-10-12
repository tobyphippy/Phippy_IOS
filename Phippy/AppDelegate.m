//
//  AppDelegate.m
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkReachabilityManager.h"
#import "PHIRequest.h"
#import "TBCommon.h"
#import <SMS_SDK/SMSSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化数据  dafldaf
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                [PHIUserManager shareManager].networkStatus = PHINetworkStatusUnknown;
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                [PHIUserManager shareManager].networkStatus = PHINetworkStatusNotReachable;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                [PHIUserManager shareManager].networkStatus = PHINetworkStatusViaWWAN;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                [PHIUserManager shareManager].networkStatus = PHINetworkStatusViaWiFi;
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
    
    
    
    //用户基本信息
    [PHIRequest initializeUserWithIP:@"0.0.0.0" userId:@"userid"
                                time:@"2017" uuid:[TBCommon getUUID]
                              device:[NSString stringWithFormat:@"ios|%@",[TBCommon getDeviceModel]] version:[TBCommon getVersionNumber]
                            language:[TBCommon getSystemLanguage]
                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                 
                             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                 
                             }];
    
    
    
    
    [SMSSDK registerApp:@"2133eb20ac60c" withSecret:@"22f7c559b1c5db34790861581328471e"];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
