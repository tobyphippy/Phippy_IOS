//
//  OrderHeaderView.m
//  Phippy
//
//  Created by toby on 08/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "MyOrderHeaderView.h"

@implementation MyOrderHeaderView{
    UILabel *orderNumberLab;
    UILabel *riqiLab;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.backgroundColor = COLOR(29, 239, 244, 1);
//        UIView *groundView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.width, 45)];
//        groundView.backgroundColor = [UIColor whiteColor];
//        
//        
//        orderNumber = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 200, 15)];
//        orderNumber.text = @"订单号:3635536272764";
//        orderNumber.backgroundColor = [UIColor clearColor];
//        orderNumber.font = [UIFont systemFontOfSize:15];
//        
//        riqiLab = [[UILabel alloc]initWithFrame:CGRectMake(8, orderNumber.bottom, 200, 35)];
//        riqiLab.text = @"2017-8-8";
//        riqiLab.backgroundColor = [UIColor clearColor];
//        
//        [groundView addSubview:orderNumber];
//        [groundView addSubview:riqiLab];
//        [self addSubview:groundView];
    }
    return self;
}

//- (void)setOrderDate:(NSString *)orderDate{
//    riqiLab.text = orderDate;
//}

- (void)setOrderNumber:(NSString *)orderNumber{
    orderNumberLab.text = orderNumber;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR(239, 239, 244, 1);
        UIView *groundView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, self.width, self.height-15)];
        groundView.backgroundColor = [UIColor whiteColor];
        
        
        orderNumberLab = [[UILabel alloc]initWithFrame:CGRectMake(8, 5, 280, 15)];
        orderNumberLab.text = @"订单号:3635536272764";
        orderNumberLab.backgroundColor = [UIColor clearColor];
        orderNumberLab.font = [UIFont systemFontOfSize:18];
        
        riqiLab = [[UILabel alloc]initWithFrame:CGRectMake(8, orderNumberLab.bottom, 200, 35)];
        riqiLab.text = @"2017-8-8";
        riqiLab.font = [UIFont systemFontOfSize:13];
        riqiLab.backgroundColor = [UIColor clearColor];
        
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        riqiLab.text =[format stringFromDate:[NSDate date]];
        
        [groundView addSubview:orderNumberLab];
        [groundView addSubview:riqiLab];
        [self addSubview:groundView];
        
        UIButton *status = [UIButton buttonWithType:UIButtonTypeCustom];
        status.frame = CGRectMake(self.width-80, 3, 65, 40);
        [status setTitle:@"已付款" forState:UIControlStateNormal];
        [status setBackgroundColor:COLOR(239, 239, 239, 1)];
        status.layer.cornerRadius = 5;
        [groundView addSubview:status];
        
//        虚线
        for(int i=0;i<self.width;i++){
            
            int width = 3;
            if(i%3 == 0){
                
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(width*i, groundView.height-1, width, 0.5)];
                line.backgroundColor = [UIColor blackColor];
                [groundView addSubview:line];
            }
          
        }
    }
    return self;
}
@end
