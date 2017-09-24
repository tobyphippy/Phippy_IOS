//
//  DeliveryAddress.m
//  Phippy
//
//  Created by toby on 09/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "DeliveryAddressViewController.h"
#import "DeliveryAddressTabViewCell.h"
#import "EditAddressViewController.h"

@interface DeliveryAddressViewController()


@property(nonatomic) NSInteger selectedIndex;
@property(nonatomic,strong) NSMutableArray *dataArray;

@end
@implementation DeliveryAddressViewController{
    NSMutableArray *_dataArray;
}

@dynamic dataArray;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.style = UITableViewStyleGrouped;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
   
    self.title = @"收货地址";
    [self.phippyNavigationController addBackButton];
  
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = COLOR(238, 238, 238, 1);
    
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] initWithContentsOfFile:[PHIUserManager getPathForDeliveryAddressData]];
        if(!_dataArray){
            _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
            
            [_dataArray addObject:@{@"name":@"james",@"phone":@"09162151896",@"address":@"dela costa evune antel spa hotel dela costa evune antel spa hotel makati, manila"}];
            
            [_dataArray addObject:@{@"name":@"evan",@"phone":@"09162151896",@"address":@"antel spa hotel makati, manila"}];
            
            [_dataArray addObject:@{@"name":@"toby",@"phone":@"09162151896",@"address":@"antel spa hotel makati, manila"}];
            
            [_dataArray addObject:@{@"name":@"lucy",@"phone":@"09162151896",@"address":@"antel spa hotel makati, manila"}];
        }
    }
    return _dataArray;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.dataArray writeToFile: [PHIUserManager getPathForDeliveryAddressData] atomically:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = COLOR(238, 238, 238, 1);
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeliveryAddressTabViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DeliveryAddressTabViewCell" owner:nil options:nil]lastObject];
    
    if(indexPath.section == 0){
        [cell setColorForDefaultAddress];
    }
    
    NSDictionary *dict = self.dataArray[indexPath.section];
    cell.name.text = dict[@"name"];
    cell.phoneNumber.text = dict[@"phone"];
    cell.address.text = dict[@"address"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
//    EditAddressViewController *controller = [[EditAddressViewController alloc]initWithNibName:@"EditAddressViewController" bundle:nil];
//    controller.data = dict;
//    [self.navigationController pushViewController:controller animated:YES];
    
    [self.dataArray exchangeObjectAtIndex:0 withObjectAtIndex:indexPath.section];
    NSLog(@"%@",self.dataArray);
    [tableView reloadData];
}

@end
