//
//  DisplayBoardView.h
//  Test005
//
//  Created by toby on 06/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayBoardView : UIView

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;

@property (nonatomic,strong) UIColor *bgColor;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *contentColor;


@end
