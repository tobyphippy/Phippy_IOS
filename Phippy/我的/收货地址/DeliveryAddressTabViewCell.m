//
//  DeliveryAddressTabViewCell.m
//  Phippy
//
//  Created by toby on 09/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "DeliveryAddressTabViewCell.h"

@interface DeliveryAddressTabViewCell()
@property (strong, nonatomic) IBOutlet UIView *groundView;

@property (strong, nonatomic) IBOutlet UIImageView *check;

@property (strong, nonatomic) IBOutlet UIButton *cancel;
@property (strong, nonatomic) IBOutlet UIButton *edit;
@property (strong, nonatomic) IBOutlet UIView *hLine;
@property (strong, nonatomic) IBOutlet UIView *vLine;
@end
@implementation DeliveryAddressTabViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.groundView.layer.cornerRadius = 8;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self SetColorForOtherAddress];
}

- (void)setColorForDefaultAddress{
    int r = 78;
    int g = 78;
    int b = 78;
    int a = 1;
    self.name.textColor         = COLOR(r, g, b, a);
    self.phoneNumber.textColor   = COLOR(r, g, b, a);
    self.address.textColor      = COLOR(r, g, b, a);
    self.landmark.textColor     = COLOR(r, g, b, a);
    
    [self.cancel setTitleColor:COLOR(r, g, b, a) forState:UIControlStateNormal];
    [self.edit setTitleColor:COLOR(r, g, b, a) forState:UIControlStateNormal];
    
    self.hLine.backgroundColor = COLOR((r+90), (g+90), (b+90), a);
    self.vLine.backgroundColor = COLOR((r+90), (g+90), (b+90), a);
    self.check.image = [UIImage imageNamed:@"check"];
}

- (void)SetColorForOtherAddress{
    
    int r = 198;
    int g = 198;
    int b = 198;
    int a = 1;
    self.name.textColor = COLOR(r, g, b, a);
    self.phoneNumber.textColor = COLOR(r, g, b, a);
    self.address.textColor = COLOR(r, g, b, a);
    self.landmark.textColor     = COLOR(r, g, b, a);
    
    
    [self.cancel setTitleColor:COLOR(r, g, b, a) forState:UIControlStateNormal];
    [self.edit setTitleColor:COLOR(r, g, b, a) forState:UIControlStateNormal];
    self.hLine.backgroundColor = COLOR((r+30), (r+30), (r+30), a);
    self.vLine.backgroundColor = COLOR((r+30), (r+30), (r+30), a);
    
    self.check.image = [[UIImage alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
