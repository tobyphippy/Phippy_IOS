//
//  DeliveryAddressTabViewCell.h
//  Phippy
//
//  Created by toby on 09/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeliveryAddressTabViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumber;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *landmark;

- (void)setColorForDefaultAddress;
- (void)SetColorForOtherAddress;


@end
