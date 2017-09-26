//
//  PHIVerification.m
//  Phippy
//
//  Created by xian on 2017/9/26.
//  Copyright © 2017年 kg.self.edu. All rights reserved.
//

#import "PHIVerification.h"

#define GETSTORE_KEY  @"getStores"

@implementation PHIVerification

- (NSMutableDictionary *)requestTimeDictionary{
    if(!_requestTimeDictionary){
        _requestTimeDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return _requestTimeDictionary;
}


- (BOOL)isAllowRequestOnGetStores{
    //   请求间隔 六小时
    NSInteger requestInterval = 60*60*6;
    
    NSNumber *lastNumber = [self.requestTimeDictionary objectForKey:GETSTORE_KEY];
    
    NSInteger interval =([[NSDate date] timeIntervalSince1970] - [lastNumber doubleValue]);
    
    if(interval < requestInterval){
        NSLog(@"%@ 请求间隔  %ld  小于 %ld",GETSTORE_KEY,interval,requestInterval);
        return NO;
    }else{
        return YES;
    }

}

- (void)updateRequestTimeForGetStores{
    [self.requestTimeDictionary setObject:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:GETSTORE_KEY];
}
@end
