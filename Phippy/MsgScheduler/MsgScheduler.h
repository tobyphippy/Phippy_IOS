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

@interface MsgScheduler : NSObject

+ (NSDictionary *)initializeUser;
+ (NSDictionary *)getFoodStore;
+ (NSDictionary *)getGoodsWithStoreID:(NSString *)storeId;
+ (NSDictionary *)getTourArticles;

@end
