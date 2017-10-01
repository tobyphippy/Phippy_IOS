//
//  MsgScheduler.h
//  Phippy
//
//  Created by toby on 21/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+PHIWebCache.h"
#import "MsgSchedulerKeys.h"
#import "PHIRequest.h"

@interface MsgScheduler : NSObject

+ (NSDictionary *)initializeUser;
+ (NSDictionary *)getFoodStore;
+ (NSDictionary *)getGoodsWithStoreID:(NSString *)storeId;
+ (NSDictionary *)getTourArticles;

+ (void)getStoresWithSuccess:(success)success failure:(failure)failure;
+ (void)getGoodsWithStoreID:(NSString *)storeID success:(success)success failure:(failure)failure;
+ (void)getGenerateOrderNumberWithSuccess:(success)success failure:(failure)failure;
@end
