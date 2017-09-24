//
//  OrderFooterView.m
//  Phippy
//
//  Created by toby on 06/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "MyOrderFooterView.h"

@implementation MyOrderFooterView{
    UILabel *orderDelivery;
    UILabel *orderSum;
}

- (void)setDeliveryFee:(NSString *)deliveryFee{
    orderDelivery.text = [NSString stringWithFormat:@"配送费：%@ P",deliveryFee];
}

- (void)sumCount:(NSString *)sum Price:(NSString *)price{
    orderSum.text = [NSString stringWithFormat:@"共%@件商品 共计： %@P",sum,price];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        orderDelivery = [[UILabel alloc]initWithFrame:CGRectMake(8, 10, 200, self.height)];
        orderDelivery.text = @"配送费：0.00 P";
        orderDelivery.font = [UIFont systemFontOfSize:15];
        
        
        
        orderSum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-250, 10, 240, self.height)];
//        orderSum.text = @"共11件商品 共计： 1100P";
        orderSum.textAlignment  = NSTextAlignmentRight;
        
        [self addSubview:orderDelivery];
        
        [self addSubview:orderSum];
    }
    return self;
}
@end
