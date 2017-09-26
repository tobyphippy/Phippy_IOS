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
#import "PHIVerification.h"
#import "PHIRequest.h"
#import "TBCommon.h"
@interface MsgScheduler()

@property(nonatomic,strong) PHIDataAgent *dataAgent;
@property(nonatomic,strong) PHIProcessor *processor;

@property(nonatomic,strong) PHIVerification *verification;

@end

@implementation MsgScheduler



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
   
    if(![[self shareManager].verification isAllowRequestOnGetStores]){
        return;
    }
    
    //    store_type = 2 表示餐馆
    [PHIRequest storeWithParameters:@{@"store_type":@"2"} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[self shareManager].verification updateRequestTimeForGetStores];
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [[self shareManager].verification updateRequestTimeForGetStores];
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

- (PHIVerification *)verification{
    if(!_verification){
        _verification = [[PHIVerification alloc] init];
    }
    return _verification;
}

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
