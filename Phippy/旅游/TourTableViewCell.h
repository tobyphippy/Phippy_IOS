//
//  TourTableViewCell.h
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TourTableViewCell : BaseTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *tilte;
@property (strong, nonatomic) IBOutlet UIImageView *iamgeView;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *author;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *hot;

@end
