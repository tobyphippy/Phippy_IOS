//
//  EmergencyViewController.m
//  Phippy
//
//  Created by toby on 13/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "EmergencyViewController.h"
#import "EmergencyTableViewCell.h"
@interface EmergencyViewController ()

@end

@implementation EmergencyViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmergencyTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"EmergencyTableViewCell" owner:nil options:nil]lastObject];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.title.text = dict[@"title"];
    cell.phoneNumber.text = dict[@"number"];
    cell.address.text = dict[@"address"];
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phippyNavigationController addBackButton];
  
    self.dataArray = @[@{@"title":@"驻菲大使馆",@"number":@"1234567",@"address":@"abcd"},
                    @{@"title":@"驻菲大使馆",@"number":@"1234567",@"address":@"abcd"},
                    @{@"title":@"驻菲大使馆",@"number":@"1234567",@"address":@"abcd"}];
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
