//
//  PHIProcessor.m
//  Phippy
//
//  Created by toby on 21/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "PHIProcessor.h"
#import "PHIDBHelper.h"
@implementation PHIProcessor

- (PHIProcessorStyle)style{
    if(!_style) return PHIProcessorStyleDefault;
    return _style;
}

- (void)selectDB{

}

- (void)start{
    [PHIDBHelper insert];
}

- (void)suspend{

}

- (void)stop{

}

@end
