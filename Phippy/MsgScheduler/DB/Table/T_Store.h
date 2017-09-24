//
//  T_Store.h
//  Phippy
//
//  Created by toby on 22/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "T_Base.h"

@interface T_Store : T_Base

@property (nonatomic) NSInteger store_id;
@property (nonatomic) NSInteger store_type;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *img_url;
@property (nonatomic,strong) NSString *phone_number;
@property (nonatomic,strong) NSString *wechat;
@property (nonatomic,strong) NSString *deliver_time;
@property (nonatomic,strong) NSString *qisong_condition;
@property (nonatomic,strong) NSString *adress;
@property (nonatomic,strong) NSString *rank;

@end
