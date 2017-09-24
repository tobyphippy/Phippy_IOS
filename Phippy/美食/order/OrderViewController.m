//
//  OrderViewController.m
//  Phippy
//
//  Created by toby on 08/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "OrderViewController.h"

#import "OrderTableViewCell.h"
#import "MyOrderFooterView.h"
#import "MyOrderHeaderView.h"
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,PhiOrderDelegate>

@property(nonatomic,strong) UIView *payView;

@property (nonatomic,strong) MyOrderHeaderView *headerView;
@property (nonatomic,strong) MyOrderFooterView *footerView;
@end

@implementation OrderViewController{
    int payView_height;
}

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.style = UITableViewStyleGrouped;
        payView_height = 50;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.style = UITableViewStyleGrouped;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phippyNavigationController addBackButton];
    self.title = @"订单详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height-payView_height);
    self.tableView.backgroundColor = [UIColor whiteColor];
    //    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.payView];
    //需要请求 订单号 接口
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 内部方法
- (void)updateFooterViewDataWithIndexPath:(NSInteger )section{
    
    NSArray *array = self.dataArray[section];
    CGFloat money = 0.f;
    for(NSDictionary *dict in array){
        NSString *price = dict[@"price"];
        NSString *count = dict[@"count"];
        money += ([price floatValue] * [count integerValue]);
    }
    
    [self.footerView sumCount:[NSString stringWithFormat:@"%ld",array.count] Price:[NSString stringWithFormat:@"%.2f",money]];
    
}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArray[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    [self updateFooterViewDataWithIndexPath:section];
    return self.footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderTableViewCell" owner:nil options:nil] lastObject];
    cell.delegate = self;
    NSArray *array = self.dataArray[indexPath.section];
    NSDictionary *dict = array[indexPath.row];
    
    NSMutableDictionary *mdict = array[indexPath.row];
    
    
    cell.name.text = dict[@"name"];
    cell.price.text = dict[@"price"];
    cell.count.text = dict[@"count"];
    
    
    
    //    cell.imageView sd_
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 从数据源中删除
    NSMutableArray *marr = self.dataArray[indexPath.section];
    
    [marr removeObjectAtIndex:indexPath.row];
    // 从列表中删除
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self updateFooterViewDataWithIndexPath:indexPath.section];
    NSLog(@"data %@",marr);
}

#pragma mark - phiOrderDelegate

- (void)cellSelected:(OrderTableViewCell *)cell On:(PhiOrderSelectedType)type{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSArray *array = self.dataArray[indexPath.section];
    NSMutableDictionary *mdict = array[indexPath.row];
    NSInteger number = [mdict[@"count"] integerValue];
    
    
    
    if(type == PhiOrderSelectedTypeLeft){
        NSLog(@"left");
        
        if(number>1){
            [mdict setObject:[NSString stringWithFormat:@"%ld",number-1] forKey:@"count"];
            
            cell.count.text = [NSString stringWithFormat:@"%ld",number-1];
        }else{
            return;
        }
    }else{
        NSLog(@"right");
        [mdict setObject:[NSString stringWithFormat:@"%ld",number+1] forKey:@"count"];
        cell.count.text = [NSString stringWithFormat:@"%ld",number+1];
        
    }
    
    [self updateFooterViewDataWithIndexPath:indexPath.section];
    NSLog(@"cellSelected data:%@",self.dataArray);
}

#pragma mark - set get

- (MyOrderFooterView *)footerView{
    if(!_footerView){
    _footerView = [[MyOrderFooterView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 40)];
    }
    return _footerView;
}

- (MyOrderHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[MyOrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 65)];
    }
    return _headerView;
}

- (UIView *)payView{
    if(!_payView){
        _payView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-payView_height, self.view.width, payView_height)];
        _payView.backgroundColor = COLOR(239, 239, 244, 1);
        
        int btnWidth = 100;
        UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [payButton setTitle:@"货到付款" forState:UIControlStateNormal];
        payButton.titleLabel.font = [UIFont systemFontOfSize:16];
        payButton.layer.cornerRadius = 6;
        [payButton setBackgroundColor:[UIColor whiteColor]];
        [payButton setTitleColor:COLOR(70, 70, 70, 1) forState:UIControlStateNormal];
        payButton.frame = CGRectMake(_payView.width-20-btnWidth, 5, btnWidth, _payView.height-10);
        
        [_payView addSubview:payButton];
    }
    return _payView;
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
