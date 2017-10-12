//
//  LifeViewController.m
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "LifeViewController.h"
#import "LifeHeaderView.h"
@interface LifeViewController ()

@end

@implementation LifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.phippyNavigationController standardNavigationBarView];
    
    
    LifeHeaderView *header = [[LifeHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width,  (SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT))];
    self.tableView.tableHeaderView = header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    return cell;
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
