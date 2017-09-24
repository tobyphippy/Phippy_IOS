//
//  FoodWechatCell.h
//  Phippy
//
//  Created by toby on 18/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface FoodWechatCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *deliveryTime;

@property (strong, nonatomic) IBOutlet UILabel *qisongCondition;
@property (strong, nonatomic) IBOutlet UILabel *adress;
@property (strong, nonatomic) IBOutlet UILabel *contact;

@end
