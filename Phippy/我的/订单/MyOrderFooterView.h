//
//  OrderFooterView.h
//  Phippy
//
//  Created by toby on 06/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderFooterView : UIView

@property (nonatomic,strong) NSString *deliveryFee;

- (void)sumCount:(NSString *)sum Price:(NSString *)price;
@end
