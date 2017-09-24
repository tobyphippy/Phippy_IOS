//
//  PHIProcessor.h
//  Phippy
//
//  Created by toby on 21/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, PHIProcessorStyle) {
    
    PHIProcessorStyleDefault,
    PHIProcessorStyleFood,	// Simple cell with text label and optional image view (behavior of UITableViewCell in iPhoneOS 2.x)
    PHIProcessorStyleFoodDetail		// Left aligned label on left and right aligned label on right with blue text (Used in Settings)
   
};

@interface PHIProcessor : NSObject

@property(nonatomic) PHIProcessorStyle style;

- (void)start;
- (void)stop;
- (void)suspend;
@end
