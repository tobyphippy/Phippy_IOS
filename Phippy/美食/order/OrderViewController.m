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
#import "OrderHeaderView.h"
#import "LoginViewController.h"
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,PhiOrderDelegate>

@property(nonatomic,strong) UIView *payView;

@property (nonatomic,strong) OrderHeaderView *headerView;
@property (nonatomic,strong) MyOrderFooterView *footerView;
@property (nonatomic,strong) NSMutableDictionary *orderDataDict;
@end

@implementation OrderViewController{
    int payView_height;
}

- (NSMutableDictionary *)orderDataDict{
    if(!_orderDataDict){
        _orderDataDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return _orderDataDict;
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
    
    if([PHIUserManager shareManager].orderNumber == nil){
        [MsgScheduler getGenerateOrderNumberWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"GenerateOrderNumber:%@",responseObject);
            
            self.userManager.orderNumber = responseObject[@"number"];
            self.headerView.orderNumber = self.userManager.orderNumber;
            
            [self.orderDataDict setObject:self.userManager.orderNumber forKey:@"order_id"];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    
    [self.orderDataDict setObject:self.dataArray forKey:@"list"];
    NSLog(@"data:%@",self.dataArray);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSLog(@"dataArray:%@",self.dataArray);
    
  
   
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
    
    [self.orderDataDict setObject:[NSString stringWithFormat:@"%.2f",money] forKey:@"order_price"];
    
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

- (OrderHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[OrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 65)];
        _headerView.orderNumber = self.userManager.orderNumber;
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
        [payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
        payButton.frame = CGRectMake(_payView.width-10-btnWidth, 5, btnWidth, _payView.height-10);
        
        [_payView addSubview:payButton];
    }
    return _payView;
}

- (void)pay:(UIButton *)sender{
    
    if(!self.userManager.isLogin){
        LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
        
        return;
    }
   
    
    
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定提交订单吗？"
                                                                   message:@"提交订单后 请在【我】- 【我的订单】中查看订单最新动态"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
                                                              
                                                              self.userManager.orderNumber = nil;
                                                              [self.orderDataDict setObject:self.userManager.userName forKey:@"submitted_by"];
                                                              
                                                              [self.orderDataDict setObject:self.storeID forKey:@"store_id"];
                                                              
                                                            
                                                              [PHIRequest SubmitFoodOrderWithParameters:self.orderDataDict success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                  NSLog(@"food order:%@",responseObject);
                                                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                  
                                                              }];
                                                          }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"再想想" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
                                                              
                                                          }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
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
