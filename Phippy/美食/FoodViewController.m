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

@end

@implementation FoodViewController

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
    cell.deliveryTime.text = dict[MSKEY_FOODSTORE_Delivertime];
    cell.qisongCondition.text = dict[MSKEY_FOODSTORE_Qisongcondition];
    cell.adress.text = dict[MSKEY_FOODSTORE_Adress];
    cell.contact.text = dict[MSKEY_FOODSTORE_Phone_number];
    [cell.imgView phi_setImageWithURL:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    

        FoodDetailViewController *detail = [[FoodDetailViewController alloc]init];
        detail.title = dict[MSKEY_FOODSTORE_Name];
        detail.store_id = dict[MSKEY_FOODSTORE_Store_id];
        detail.phoneNumber = dict[MSKEY_FOODSTORE_Phone_number];
        detail.wechat = dict[MSKEY_FOODSTORE_Wechat];
        
        detail.hidesBottomBarWhenPushed = YES;
        [self.phippyNavigationController pushViewController:detail animated:YES];
    
    
}


- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    
//    store_type = 2 表示餐馆
    [PHIRequest storeWithParameters:@{@"store_type":@"2"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"");
        self.dataArray = [responseObject objectForKey:@"data"];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

    [PHIRequest initializeUserWithIP:@"0.0.0.0" userId:@"userid"
                                time:@"2017" uuid:[TBCommon getUUID]
                              device:[NSString stringWithFormat:@"ios|%@",[TBCommon getDeviceModel]] version:[TBCommon getVersionNumber]
                            language:[TBCommon getSystemLanguage]
                             success:^(NSURLSessionDataTask *task, id responseObject) {
        
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
//    NSLog(@"getFoodStore%@",[MsgScheduler getFoodStore]);
    
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
