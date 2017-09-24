//
//  baseHeaderView.m
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "PhippyHeaderView.h"
#import "DisplayBoardView.h"
@interface PhippyHeaderView()


@end
@implementation PhippyHeaderView

#pragma mark - 公开方法
+ (instancetype)headerViewFood{
    
    PhippyHeaderView *header = [[self initHeaderView] addBackGroundImageView];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3.7+30);
    
    UILabel *bottomLab = [[UILabel alloc] initWithFrame:CGRectMake(0, header.frame.size.height-30, header.bounds.size.width, 30)];
    bottomLab.textAlignment = NSTextAlignmentCenter;
    bottomLab.text = @"猜你喜欢";
    bottomLab.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    [header addSubview:bottomLab];
    return header;
}

+ (instancetype)headerViewTour{
    
    PhippyHeaderView *header = [[self initHeaderView] addBackGroundImageView];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3.7+30);
   
    UILabel *bottomLab = [[UILabel alloc] initWithFrame:CGRectMake(0, header.frame.size.height-30, header.bounds.size.width, 30)];
    bottomLab.textAlignment = NSTextAlignmentCenter;
    bottomLab.text = @"推荐攻略";
    bottomLab.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    [header addSubview:bottomLab];
    
    return header;
}

+ (instancetype)headerViewFoodDetail{
    return [[self initHeaderView] addBackGroundImageView];
}

+ (instancetype)headerViewTourDetail{
    return [[self initHeaderView] addBackGroundImageView];
}

+ (instancetype)headerViewMe{
    PhippyHeaderView *header = [self initHeaderView];
    DisplayBoardView *boardView = [[DisplayBoardView alloc]initWithFrame:CGRectMake(0, 0, header.width, 30)];
    boardView.content = @"hgjdslahgjhdasjghjdkslhagjdlhajgdhlaghjdshgjdlhsahdjlshafjdhlas";
    [header addSubview:boardView];
   return header;
}

#pragma mark - init
//(1)初始化headerView
+ (instancetype)initHeaderView{
    PhippyHeaderView *header = [[PhippyHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3.7)];
    
    return header;
}

//(2)
//添加背景image 添加左下方标题
- (instancetype)addBackGroundImageView{
  
    self.backGroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.titleOfLeftDonw];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


#pragma mark - set get
- (void)setHeight:(NSInteger)height{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
}


- (void)setBackGroundImageView:(UIImageView *)backGroundImageView{
    
    _backGroundImageView = backGroundImageView;
    
    if(_backGroundImageView ){
        
        if(_backGroundImageView.superview) [_backGroundImageView removeFromSuperview];
        
        [self addSubview:_backGroundImageView];
        
        _titleOfLeftDonw = [[UILabel alloc]initWithFrame:CGRectMake(5, _backGroundImageView.bounds.size.height-30, self.bounds.size.width, 30)];
        _titleOfLeftDonw.textColor = [UIColor whiteColor];
        [_backGroundImageView addSubview:_titleOfLeftDonw];
    }
    
}


@end
