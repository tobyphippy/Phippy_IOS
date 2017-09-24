//
//  T_Base.m
//  Phippy
//
//  Created by toby on 22/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "T_Base.h"
#import <objc/runtime.h>

@implementation T_Base

- (NSString *)getTableName{
    NSString *name = NSStringFromClass([self class]);
    return name.lowercaseString;
}

- (NSArray *)getAllProperties{
    u_int count;
    
    //使用class_copyPropertyList及property_getName获取类的属性列表及每个属性的名称
    
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
//        NSLog(@"属性%@\n",[NSString stringWithUTF8String: propertyName]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

- (NSArray *)getAllValuesAtproperties{
    NSMutableArray *values = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray *properties = [self getAllProperties];
    for(NSString *property in properties){
        
#warning 判断为空 应该写到 model里面
        [values addObject:([self valueForKey:property] == nil?@"":[self valueForKey:property])];
//        NSLog(@"key:%@  value:%@",property,[self valueForKey:property]);
    }
    
    return values;
}

@end
