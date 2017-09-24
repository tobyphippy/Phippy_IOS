//
//  BaseViewController.m
//  Phippy
//
//  Created by toby on 11/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "PhippyViewController.h"


@interface PhippyViewController ()

@end

@implementation PhippyViewController

- (PHIUserManager *)userManager{
    return [PHIUserManager shareManager];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(255, 255, 255, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


/*  ~~~~~~~     UIViewController(UIViewControllerItem)     ~~~~~~~~~~~~~~~   */

#pragma mark UIViewController(UIViewControllerItem)
@implementation UIViewController(UIViewControllerItem)


//- (BaseTabBarController *)baseTabbarController{
//    if([self.tabBarController isMemberOfClass:[BaseTabBarController class]]){
//        return (BaseTabBarController *)self.tabBarController;
//    }
//    return nil;
//}

- (BaseNavigationController *)phippyNavigationController{
    
    if([self.navigationController isMemberOfClass:[BaseNavigationController class]]){
        return (BaseNavigationController *)self.navigationController;
    }
    return nil;
    
}

@end

/*  ~~~~~~~     UITabBar(badge)     ~~~~~~~~~~~~~~~   */
/*添加tabbar上 的小红点*/

#define TabbarItemNums 4.0

@implementation UITabBar (badge)
//显示红点
- (void)showBadgeOnItmIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888+index;
    bview.layer.cornerRadius = 5;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect tabFram = self.frame;
    
    float percentX = (index+0.6)/TabbarItemNums;
    CGFloat x = ceilf(percentX*tabFram.size.width);
    CGFloat y = ceilf(0.1*tabFram.size.height);
    bview.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}
//隐藏红点
-(void)hideBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}
//移除控件
- (void)removeBadgeOnItemIndex:(int)index{
    for (UIView*subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end

