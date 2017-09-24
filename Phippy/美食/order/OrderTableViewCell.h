//
//  OrderTableViewCell.h
//  Phippy
//
//  Created by toby on 06/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  PhiOrderDelegate;

typedef NS_ENUM(NSInteger,PhiOrderSelectedType){

    PhiOrderSelectedTypeLeft = 0,
    PhiOrderSelectedTypeRight
};



@interface OrderTableViewCell : UITableViewCell

@property (nonatomic,weak) id<PhiOrderDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *count;


@end

@protocol PhiOrderDelegate <NSObject>

@optional
- (void)cellSelected:(OrderTableViewCell *)cell On:(PhiOrderSelectedType)type;

@end


