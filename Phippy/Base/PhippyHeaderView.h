//
//  baseHeaderView.h
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhippyHeaderView : UIView

@property (nonatomic,strong) UIImageView *backGroundImageView;
@property (nonatomic,strong) UILabel *titleOfLeftDonw;

//默认是 SCREEN_HEIGHT/3.7
@property (nonatomic) NSInteger height;

+ (instancetype)headerViewMe;
+ (instancetype)headerViewFood;
+ (instancetype)headerViewTour;

+ (instancetype)headerViewFoodDetail;
+ (instancetype)headerViewTourDetail;

@end
