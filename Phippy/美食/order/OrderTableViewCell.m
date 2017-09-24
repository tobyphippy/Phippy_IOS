//
//  OrderTableViewCell.m
//  Phippy
//
//  Created by toby on 06/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "OrderTableViewCell.h"

@interface OrderTableViewCell()

@property (strong, nonatomic) IBOutlet UIView *rightPressView;
@property (strong, nonatomic) IBOutlet UIView *leftPressView;

@end
@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.leftPressView addTapGestureRecognizerWithTarget:self action:@selector(leftTap)];
     [self.rightPressView addTapGestureRecognizerWithTarget:self action:@selector(rightTap)];
   
}

- (void)leftTap{
    if([self.delegate respondsToSelector:@selector(cellSelected:On:)]){
        [self.delegate cellSelected:self On:PhiOrderSelectedTypeLeft];
    }
}

- (void)rightTap{
    if([self.delegate respondsToSelector:@selector(cellSelected:On:)]){
        [self.delegate cellSelected:self On:PhiOrderSelectedTypeRight];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
