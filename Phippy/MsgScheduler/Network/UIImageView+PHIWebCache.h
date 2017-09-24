//
//  UIImageView+PHIWebCache.h
//  Phippy
//
//  Created by toby on 23/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

//----------------------------------------------------------
//                      使用说明
//----------------------------------------------------------
//  1.此类 需要依赖 SDWebImage 开源库
//
//
//
//
//
//----------------------------------------------------------

@interface UIImageView (PHIWebCache)


/**
 *    默认带背景图  no_img@2x.png
 
 *   1. 这样做 跟 usermanager产生了依赖关系，
 *      可以考虑在这个类里面做 wifi检测，达到通用的类
 
 
     2. 默认的图片现在也是写死的
      可以 通过runtime关联 添加一个属性，对外可以设置 no_img图片
 */

- (void)phi_setImageWithURL:(nullable NSURL *)url;

//- (void)phi_setImageWithURL:(nullable NSURL *)url
//          placeholderImage:(nullable UIImage *)placeholder;
@end
