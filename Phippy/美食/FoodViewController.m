//
//  FoodViewController.m
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "FoodViewController.h"
//#import "FoodTableViewCell.h"
#import "FoodWechatCell.h"
#import "PhippyHeaderView.h"
#import "FoodDetailViewController.h"

#import "PHIRequest.h"
#import "TBCommon.h"

@interface FoodViewController ()

@property(nonatomic,strong) FoodDetailViewController *detailController;
@end

@implementation FoodViewController

- (FoodDetailViewController *)detailController{
//    if(!_detailController){
//        _detailController = [[FoodDetailViewController alloc]init];
//        _detailController.hidesBottomBarWhenPushed = YES;
//    }
    return _detailController;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodWechatCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"FoodWechatCell" owner:nil options:nil]lastObject];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    cell.title.text =dict[MSKEY_FOODSTORE_Name];
    cell.deliveryTime.text = [NSString stringWithFormat:@"营业时间: %@",dict[MSKEY_FOODSTORE_Delivertime]];
    cell.qisongCondition.text = [NSString stringWithFormat:@"%@ 起送",dict[MSKEY_FOODSTORE_Qisongcondition]];
    cell.adress.text = [NSString stringWithFormat:@"%@",dict[MSKEY_FOODSTORE_Address]];
    cell.contact.text = dict[MSKEY_FOODSTORE_Phone_number];
    [cell.imgView phi_setImageWithURL:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    self.detailController = [[FoodDetailViewController alloc] init];
    self.detailController.hidesBottomBarWhenPushed = YES;
    self.detailController.title = dict[MSKEY_FOODSTORE_Name];
    self.detailController.store_id = dict[MSKEY_FOODSTORE_Store_id];
    self.detailController.phoneNumber = dict[MSKEY_FOODSTORE_Phone_number];
    self.detailController.wechat = dict[MSKEY_FOODSTORE_Wechat];
    self.detailController.qisong_condition = dict[MSKEY_FOODSTORE_Qisongcondition];
    [self.phippyNavigationController pushViewController:self.detailController animated:YES];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    
    [MsgScheduler getStoresWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.dataArray = [responseObject objectForKey:@"data"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
    //    NSLog(@"initializeUser: %@",[MsgScheduler initializeUser]);
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    //        // Do something...
    //        sleep(5);
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [MBProgressHUD hideHUDForView:self.view animated:YES];
    //        });
    //    });
    
    
    //     [self.tabBarController.tabBar showBadgeOnItmIndex:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.phippyNavigationController standardNavigationBarView];
    PhippyHeaderView *headerView = [PhippyHeaderView  headerViewFood];
    self.tableView.tableHeaderView = headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    headerView.backGroundImageView.image = [UIImage imageNamed:@"food_rec_header_img.jpg"];
    headerView.titleOfLeftDonw.text = @"美食";
    
    
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
