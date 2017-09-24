//
//  MeViewController.m
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "MeViewController.h"
#import "PhippyHeaderView.h"
#import "BaseTableViewCell.h"
#import "CollectViewController.h"
#import "EmergencyViewController.h"
#import "SettingViewController.h"
#import "FeedbackViewController.h"
#import "CooperateViewController.h"
#import "AboutUsViewController.h"

#import "LoginViewController.h"

#import "MyOrderViewController.h"
#import "DeliveryAddressViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //    [self.tabBarController.tabBar hideBadgeOnItemIndex:0];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.phippyNavigationController translucentAndCenterTitleNavigationBarView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    //    [self.phippyNavigationController originalNavigationBarView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@[@"我的订单",@"我的地址"],
                       @[@"应急求助",@"常用设置",@"意见反馈",@"关于我们"],
                       @[@"商务合作"],
                       @[@"退出登录"]];
    
//    self.dataArray = @[@[@"aaa"],
//                       @[@"bbb",@"ccc",@"ddd",@"eee",@"fff"],
//                       @[@"ggg"]];
    
    /***************************************/
    //当前controller 在nav中 需要这样设置
    //    -(UIStatusBarStyle)preferredStatusBarStyle {
    //
    //        return UIStatusBarStyleLightContent; //白色
    //
    //        return UIStatusBarStyleDefault; //黑色
    //
    //    } 在导航控制器中，以上代码不起作用。
    
    
    //    self.navigationController.navigationBar.barStyle = UIBarStyleDefault; //状态栏改为黑色
    /***************************************/
    
    PhippyHeaderView *headerView = [PhippyHeaderView  headerViewMe];
    headerView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headerView;
    
    //因为设置了 automaticallyAdjustsScrollViewInsets = no
    self.tableViewHeight = SCREEN_HEIGHT-TABBAR_HEIGHT;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login:)];
    [headerView addGestureRecognizer:tap];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *count = self.dataArray[section];
    
    return count.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"meCell"];
    
    NSArray *section = self.dataArray[indexPath.section];
    cell.textLabel.text = section[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhippyViewController *controller = nil;
    
    //订单
    if([indexPath isEqual:[NSIndexPath indexPathForRow:0 inSection:0]]){
        MyOrderViewController *orderController = [[MyOrderViewController alloc]init];
        
        [self.phippyNavigationController pushViewController:orderController animated:YES];
        return;
    }else if ([indexPath isEqual:[NSIndexPath indexPathForRow:1 inSection:0]]){
//    收货地址
        DeliveryAddressViewController *deliveryAdd = [[DeliveryAddressViewController alloc]init];
        [self.phippyNavigationController pushViewController:deliveryAdd animated:YES];
        return;
        
    }
    switch (indexPath.row) {

        case 0:{
            controller = [[EmergencyViewController alloc]init];
            controller.title = @"应急求助";
            break;
        }
        case 1:{
            controller = [[SettingViewController alloc]init];
            controller.title = @"常用设置";
            break;
        }
        case 2:{
            controller = [[FeedbackViewController alloc]init];
            controller.title = @"意见反馈";
            break;
        }
        case 3:{
            controller = [[CooperateViewController alloc]init];
            
            controller.title = @"商家入驻";
            break;
        }
        case 4:{
            controller = [[AboutUsViewController alloc]init];
            controller.title = @"关于我们";
            break;
            
        }
          
    }
    
    if(controller){
        controller.hidesBottomBarWhenPushed = YES;
        [self.phippyNavigationController pushViewController:controller animated:YES];
    }
    
}



- (void)login:(UITapGestureRecognizer *)tap {
    
    LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
     UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
   
    [self presentViewController:nav animated:YES completion:nil];
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
