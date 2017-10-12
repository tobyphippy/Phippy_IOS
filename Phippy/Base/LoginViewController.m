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
@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *sendCode;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
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
    
    
  
        if([self phoneNumberCheck:self.userName.text] && codeFlag == 1){
            NSLog(@"中国手机号 输入正确");
            
        }else if (self.userName.text.length == 11 && codeFlag == 0){
            
            
            NSString *tmp = [self.userName.text substringToIndex:2];
            NSLog(@"tmp:%@",tmp);
            
            if(![tmp isEqualToString:@"09"]){
                NSLog(@"菲律宾手机号 输入错误");
                return;
            }
        }else {
            NSLog(@"手机号输入错误");
            return;
        }
    
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
                                     
                                     if(!error){
                                         self.loginButton.enabled = YES;
                                     }
                                     
                                   
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
    
    
    if(self.userName.text.length == 11 && self.password.text.length == 4){
        NSString *zone = @"63";
        if(codeFlag == 1) zone = @"86";
        
        __weak typeof(self) weakSelf = self;
        
        NSLog(@"验证码：%@",self.password.text);
        [SMSSDK commitVerificationCode:weakSelf.password.text phoneNumber:weakSelf.userName.text zone:zone result:^(NSError *error) {
            if (!error)
            {
                // 请求成功
                NSLog(@"验证码成功");
                [self back:nil];
                [PHIUserManager shareManager].isLogin = YES;
                [PHIUserManager shareManager].userName = self.userName.text;
                
                NSDateFormatter *format = [[NSDateFormatter alloc]init];
                [format setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
                
                
                [PHIRequest loginWtihParameters:@{@"phone":self.userName.text,@"login_time":[format stringFromDate:[NSDate date]]} success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                }];
            }
            else
            {
                self.loginButton.enabled = NO;
                NSLog(@"验证码失败:%@",error);
                // error
            }
        }];

    }else{
        NSLog(@"手机号或者验证码错误");
    }
    
    
}
- (IBAction)wechat:(id)sender {
}

- (BOOL)phoneNumberCheck:(NSString *)mobileNum{
    {
        if (mobileNum.length != 11)
        {
            return NO;
        }
        /**
         * 手机号码:
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
         * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
         * 联通号段: 130,131,132,155,156,185,186,145,176,1709
         * 电信号段: 133,153,180,181,189,177,1700
         */
        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
        /**
         * 中国移动：China Mobile
         * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
         */
        NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
        /**
         * 中国联通：China Unicom
         * 130,131,132,155,156,185,186,145,176,1709
         */
        NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        /**
         * 中国电信：China Telecom
         * 133,153,180,181,189,177,1700
         */
        NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        /**
         25     * 大陆地区固话及小灵通
         26     * 区号：010,020,021,022,023,024,025,027,028,029
         27     * 号码：七位或八位
         28     */
        //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        if (([regextestmobile evaluateWithObject:mobileNum] == YES)
            || ([regextestcm evaluateWithObject:mobileNum] == YES)
            || ([regextestct evaluateWithObject:mobileNum] == YES)
            || ([regextestcu evaluateWithObject:mobileNum] == YES))
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    [self.codeLab addTapGestureRecognizerWithTarget:self action:@selector(selectCountryCode:)];
    
    
    self.userName.keyboardType = UIKeyboardTypeNumberPad;
    self.password.keyboardType = UIKeyboardTypeNumberPad;
    
    self.userName.delegate = self;
    self.password.delegate = self;
    
    [self.view addTapGestureRecognizerWithTarget:self action:@selector(backViewTap:)];
   
}

- (void)backViewTap:(UITapGestureRecognizer *)tap {
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
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
