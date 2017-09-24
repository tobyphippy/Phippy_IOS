//
//  PHIRequest.m
//  Phippy
//
//  Created by toby on 21/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "PHIRequest.h"

#define TB_BASE_URL    @"http://10.71.66.2:5001/user"

@implementation PHIRequest

+ (void)initializeUserWithIP:(NSString *)ip userId:(NSString *)userId
                        time:(NSString *)time uuid:(NSString *)uuid
                      device:(NSString *)device version:(NSString *)version
                    language:(NSString *)language
                     success:(success)success failure:(failure)failure{
    NSString *url = [NSString stringWithFormat:@"%@/initializeUser",TB_BASE_URL];
    NSDictionary *parameters = @{@"ip":ip,
                               @"userid":userId,
                               @"time":@"2017",
                                 @"uuid":uuid,
                                 @"device":device,
                                 @"version":version,
                                 @"language":language};
    
    [self handlePOSTWithURL:url Parameters:parameters originalParas:parameters success:success failure:failure];
}

+ (void)storeWithParameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure{

    NSString *url = [NSString stringWithFormat:@"%@/getstore",TB_BASE_URL];
    
      [self handlePOSTWithURL:url Parameters:parameters originalParas:parameters success:success failure:failure];
}

+ (void)goodsWithParameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure{
    NSString *url = [NSString stringWithFormat:@"%@/getgoods",TB_BASE_URL];
    
    [self handlePOSTWithURL:url Parameters:parameters originalParas:parameters success:success failure:failure];
}


+ (void)tourWithParameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure{
    NSString *url = [NSString stringWithFormat:@"%@/getarticle",TB_BASE_URL];
    
    [self handlePOSTWithURL:url Parameters:parameters originalParas:parameters success:success failure:failure];
}

+ (void)lifeWithParameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/getstore",TB_BASE_URL];
    
    [self handlePOSTWithURL:url Parameters:parameters originalParas:parameters success:success failure:failure];
}

+ (void)handlePOSTWithURL:(NSString *)url Parameters:(NSDictionary *)jsonDict originalParas:(NSDictionary *)orgParas success:(success)success failure:(failure)failure {
    
    if(!jsonDict || !url) return;
    
    if(orgParas){
        [self POSTWithURL:url parameters:jsonDict originalParas:orgParas success:success failure:failure];
    }else{
        [self POSTWithURL:url parameters:jsonDict success:success failure:failure];
    }
    
}

@end
