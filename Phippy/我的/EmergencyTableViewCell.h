//
//  EmergencyCellTableViewCell.h
//  Phippy
//
//  Created by toby on 13/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface EmergencyTableViewCell : BaseTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumber;

@property (strong, nonatomic) IBOutlet UILabel *address;
@end
