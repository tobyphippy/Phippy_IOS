//
//  LoginViewController.m
//  Phippy
//
//  Created by toby on 31/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "LoginViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "RegisterViewController.h"
@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *sendCode;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;

@property (strong,nonatomic) NSTimer *timer;
@end

@implementation LoginViewController{
    
    // 0 表示 菲律宾
    // 1 表示 中国
    NSInteger codeFlag;
    NSInteger countdownTime;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    //    return UIStatusBarStyleLightContent;
    return UIStatusBarStyleLightContent;
}
- (IBAction)sendVerificationCode:(id)sender {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    
    countdownTime = 90;
    [self.timer fire];
    NSString *zone = @"63";
    if(codeFlag == 1) zone = @"86";
    NSString *identifier = @"phippy";
    
    NSLog(@"userName:%@  zone:%@",self.userName.text,zone);
    
//    457 手机号码格式错误
//    456 手机号码或者区号为空
    
    __weak typeof(self) weakSelf = self;
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
                            phoneNumber:weakSelf.userName.text
                                   zone:zone
                       customIdentifier:identifier
                                 result:^(NSError *error) {
        NSLog(@"error:%@",error);
                                     
                                     
                                   
    }];

    
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerAccount:(id)sender {
    
    RegisterViewController *controller = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)forgetPassword:(id)sender {
}
- (IBAction)loginAccount:(id)sender {
    NSString *zone = @"63";
    if(codeFlag == 1) zone = @"86";
  
    __weak typeof(self) weakSelf = self;
  
    NSLog(@"验证码：%@",self.password.text);
    [SMSSDK commitVerificationCode:weakSelf.password.text phoneNumber:weakSelf.userName.text zone:zone result:^(NSError *error) {
        if (!error)
        {
            // 请求成功
            NSLog(@"验证码成功");
        }
        else
        {
            NSLog(@"验证码失败:%@",error);
            // error
        }
    }];
    
        

}
- (IBAction)wechat:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    [self.codeLab addTapGestureRecognizerWithTarget:self action:@selector(selectCountryCode:)];
    
    
//    self.timer= [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
   
}

- (void)countdown{
    
    if(self.sendCode.enabled == YES){
        [self.sendCode setEnabled:NO];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.sendCode.width, self.sendCode.height)];
        lab.tag =1001;
        lab.font = [UIFont systemFontOfSize:13];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor colorWithRed:255 green:237 blue:130 alpha:0];
        lab.textColor = [UIColor whiteColor];
        [self.sendCode addSubview:lab];
        [self.sendCode setTitle:@"" forState:UIControlStateNormal];
    }
   
    UILabel *lab = [self.sendCode viewWithTag:1001];
    lab.text = [NSString stringWithFormat:@"%ld秒后重新发送",countdownTime];
    
    if(countdownTime-- == 0){
        [self.timer invalidate];
        self.timer = nil;
         self.sendCode.hidden = NO;
        [self.sendCode setEnabled:YES];
        [lab removeFromSuperview];
        [self.sendCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
}

- (void)selectCountryCode:(UITapGestureRecognizer *)tap{
    UILabel *lab = (UILabel *)tap.view;
    
    if([lab.text isEqualToString:@"菲律宾（+63）"]){
        lab.text = @"中国（+86）";
        codeFlag = 1;
    }else{
        lab.text = @"菲律宾（+63）";
        codeFlag = 0;
    }
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
