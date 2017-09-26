//
//  MsgScheduler.m
//  Phippy
//
//  Created by toby on 21/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "MsgScheduler.h"
#import "PHIDataAgent.h"
#import "PHIProcessor.h"

#import "PHIRequest.h"
#import "TBCommon.h"
@interface MsgScheduler()

@property(nonatomic,strong) PHIDataAgent *dataAgent;
@property(nonatomic,strong) PHIProcessor *processor;


@property(nonatomic,strong) NSMutableDictionary *requestTimeDictionary;
@end

@implementation MsgScheduler

- (NSMutableDictionary *)requestTimeDictionary{
    if(!_requestTimeDictionary){
        _requestTimeDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return _requestTimeDictionary;
}

+ (NSDictionary *)initializeUser{
    __block NSDictionary *dict = @{};
    [PHIRequest initializeUserWithIP:[TBCommon getIPAddresses]
                              userId:@"userid"
                                time:@"2017" uuid:[TBCommon getUUID]
                              device:[NSString stringWithFormat:@"ios|%@",[TBCommon getDeviceModel]] version:[TBCommon getVersionNumber]
                            language:[TBCommon getSystemLanguage]
                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                 dict = responseObject;
                             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                 
                             }];
    
    
    return dict;
}

//---------------------------------------
//food
//---------------------------------------

+ (void)getStoresWithSuccess:(success)success failure:(failure)failure{
   
    
    NSString *key = @"getStores";
//   请求间隔 六小时
    NSInteger requestInterval = 60*60*6;
    
    NSNumber *lastNumber = [[self shareManager].requestTimeDictionary objectForKey:key];
    
    NSInteger interval =([[NSDate date] timeIntervalSince1970] - [lastNumber doubleValue]);
    if(interval < requestInterval){
        NSLog(@"%@ 请求间隔  %ld  小于 %ld",key,interval,requestInterval);
        return;
    }
    
    
    //---------------------
    
    
    //    store_type = 2 表示餐馆
    [PHIRequest storeWithParameters:@{@"store_type":@"2"} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        [[self shareManager].requestTimeDictionary setObject:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:key];
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [[self shareManager].requestTimeDictionary setObject:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:key];
        failure(task,error);
    }];
}

+ (NSDictionary *)getFoodStore{
    
    MsgScheduler *scheduler = [self shareManager];
    scheduler.processor.style = PHIProcessorStyleFood;
    [scheduler.processor start];
    NSDictionary *dict = @{};
    return dict;
}

+ (NSDictionary *)getGoodsWithStoreID:(NSString *)storeId{
    NSDictionary *dict = @{};
    return dict;
}


#pragma mark- set get

//---------------------------------------
//tour
//---------------------------------------

+ (NSDictionary *)getTourArticles{
    NSDictionary *dict = @{};
    return dict;
}


//---------------------------------------
//set get
//---------------------------------------
- (PHIDataAgent *)dataAgent{
    if(!_dataAgent){
        _dataAgent = [[PHIDataAgent alloc]init];
    }
    return _dataAgent;
}

- (PHIProcessor *)processor{
    if(!_processor){
        _processor = [[PHIProcessor alloc]init];
    }
    return _processor;
}

#pragma mark- lift cycle

static MsgScheduler * _instance = nil;
+ (MsgScheduler *)shareManager{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
        
    }) ;
    return _instance ;
}


+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [MsgScheduler shareManager] ;
}

- (id) copyWithZone:(struct _NSZone *)zone
{
    return [MsgScheduler shareManager] ;
}
@end
