//
//  LifeHeaderView.m
//  Phippy
//
//  Created by xian on 2017/10/6.
//  Copyright © 2017年 kg.self.edu. All rights reserved.
//

#import "LifeHeaderView.h"

@interface LifeHeaderView()

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *bottomView;
@end
@implementation LifeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)creatStoreWithFrame:(CGRect)frame img:(UIImage *)img title:(NSString *)storeName{
    UIView *store = [[UIView alloc]initWithFrame:frame];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:store.bounds];
    imgView.image = img;
    [store addSubview:imgView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, store.width, 30)];
    title.center = CGPointMake(store.width/2, store.height/2);
    title.textAlignment = NSTextAlignmentCenter;
    title.text = storeName;
    [store addSubview:title];
    return store;
}

- (UIView *)creatVisaWithFrame:(CGRect)frame{
    UIView *visa = [[UIView alloc]initWithFrame:frame];
    return visa;
}

- (UIView *)creatAgencyWithFrame:(CGRect)frame title:(NSString *)storeName{
    UIView *store = [[UIView alloc]initWithFrame:frame];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, store.width, 30)];
    title.center = CGPointMake(store.width/2, store.height/2);
    title.textAlignment = NSTextAlignmentCenter;
    title.text = storeName;
    [store addSubview:title];
    return store;
}
- (UIView *)topView{
    if(!_topView){
        
        CGFloat scale = 0.65;
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.6)];
    
       
        UIView *top1 = [self creatStoreWithFrame:CGRectMake(0, 0, _topView.width*scale, _topView.height*0.5) img:nil title:@"燕之坊"];
        top1.backgroundColor = [UIColor blueColor];
        [_topView addSubview:top1];
        
        UIView *top2 = [self creatStoreWithFrame:CGRectMake(0, _topView.height*0.5, _topView.width*scale, _topView.height*0.5)img:nil title:@"小娘子药铺"];
        top2.backgroundColor = [UIColor yellowColor];
        [_topView addSubview:top2];
        
        UIView *visa1 = [self creatVisaWithFrame:CGRectMake(_topView.width*scale, 0, _topView.width*(1-scale),  _topView.height*0.5 )];
        visa1.backgroundColor = [UIColor redColor];
        [_topView addSubview:visa1];
        UIView *visa2 = [self creatVisaWithFrame:CGRectMake(_topView.width*scale, _topView.height*0.5, _topView.width*(1-scale),  _topView.height*0.5 )];
        visa2.backgroundColor = [UIColor grayColor];
        [_topView addSubview:visa2];
    }
    return _topView;
    
}

- (UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height*0.6, self.frame.size.width, self.frame.size.height*0.4)];
        UIView *agency1 = [self creatAgencyWithFrame:CGRectMake(0, 0, _bottomView.width, _bottomView.height*0.5) title:@"旅行社"];
        agency1.backgroundColor = [UIColor purpleColor];
        [_bottomView addSubview:agency1];
        UIView *agency2 = [self creatAgencyWithFrame:CGRectMake(0, _bottomView.height*0.5, _bottomView.width, _bottomView.height*0.5) title:@"旅行社"];
        agency2.backgroundColor = [UIColor yellowColor];
        [_bottomView addSubview:agency2];
        
    }
    return _bottomView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
@end
