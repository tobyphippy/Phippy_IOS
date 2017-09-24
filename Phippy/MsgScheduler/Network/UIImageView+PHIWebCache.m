//
//  UIImageView+PHIWebCache.m
//  Phippy
//
//  Created by toby on 23/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "UIImageView+PHIWebCache.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (PHIWebCache)

- (void)phi_setImageWithURL:(NSURL *)url{
    
    
    /**
     *    这样做 跟 usermanager产生了依赖关系，
     *    可以考虑在这个类里面做 wifi检测，达到通用的类
     */
    BOOL downloadImage = [PHIUserManager shareManager].downloadImageOnlyWifi;
    PHINetworkStatus status = [PHIUserManager shareManager].networkStatus;
    
    if(downloadImage && (status != PHINetworkStatusViaWiFi)){
        [self sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"no_img"]];
        return;
    }
   [self sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"no_img"]];
}
@end
