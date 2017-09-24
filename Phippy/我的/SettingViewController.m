//
//  SettingViewController.m
//  Phippy
//
//  Created by toby on 19/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingViewCell"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    if(indexPath.row == 0){
        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10, 20, 10)];
        [switchButton setOn:NO];
        [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:switchButton];
    }
    return cell;
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"是");
        self.userManager.downloadImageOnlyWifi = YES;
    }else {
        NSLog(@"否");
        self.userManager.downloadImageOnlyWifi = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phippyNavigationController addBackButton];
    self.dataArray = @[@"仅WIFI环境下加载图片"];
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
