//
//  PHIDBHelper.h
//  Phippy
//
//  Created by toby on 17/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//


//参考资料
//http://blog.csdn.net/u010390827/article/details/51335034


#import <Foundation/Foundation.h>

#import "T_Store.h"
#import "T_Goods.h"
#import "T_Article.h"

@interface PHIDBHelper : NSObject

//+ (PHIDBHelper *)shareInstance;

+ (void)insert;
+ (void)insertWithTableModel:(T_Base *)table;
+ (void)insertWithTableModels:(NSArray<T_Base *> *)tables;

+ (void)query;
+ (void)delData;

@end
