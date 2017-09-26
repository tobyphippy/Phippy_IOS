//
//  PHIVerification.h
//  Phippy
//
//  Created by xian on 2017/9/26.
//  Copyright © 2017年 kg.self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHIVerification : NSObject

@property(nonatomic,strong) NSMutableDictionary *requestTimeDictionary;


- (BOOL)isAllowRequestOnGetStores;
- (void)updateRequestTimeForGetStores;
@end
