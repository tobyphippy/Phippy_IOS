//
//  TourViewController.m
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "TourViewController.h"
#import "TourTableViewCell.h"
#import "PhippyHeaderView.h"
#import "TourDetailViewController.h"

#import "PHIRequest.h"
@interface TourViewController ()

@end

@implementation TourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.phippyNavigationController standardNavigationBarView];
    
    PhippyHeaderView *headerView = [PhippyHeaderView  headerViewTour];
    headerView.titleOfLeftDonw.text = @"旅游";
    headerView.backGroundImageView.image = [UIImage imageNamed:@"tour_rec_header_img.jpg"];
    self.tableView.tableHeaderView = headerView;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [PHIRequest tourWithParameters:@{@"a":@"b"} success:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataArray = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TourDetailViewController *detail = [[TourDetailViewController alloc]init];
    detail.title = @"旅游";
    detail.hidesBottomBarWhenPushed = YES;
    [self.phippyNavigationController pushViewController:detail animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TourTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"TourTableViewCell" owner:nil options:nil]lastObject];
   
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    cell.tilte.text = dict[MSKEY_TOUR_Title];
    cell.content.text = dict[MSKEY_TOUR_Content];
    
#warning 以后要修改成 store name
    cell.author.text = dict[MSKEY_TOUR_Store_id];
    cell.time.text = dict[MSKEY_TOUR_Time];
//    cell.hot.text = dict[];
    
    return cell;
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
