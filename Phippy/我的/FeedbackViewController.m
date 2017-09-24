//
//  FeedbackViewController.m
//  Phippy
//
//  Created by toby on 13/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate>

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *numberText;
@property (nonatomic,strong) UIButton *confirmButton;
@property (nonatomic) NSInteger textCount;


@end

@implementation FeedbackViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textCount = 300;
    }
    return self;
}


- (UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(VIEW_PACE, self.numberText.bottom+5, SCREEN_WIDTH-VIEW_PACE*2, 200)];
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor colorWithNavBottomLine].CGColor;
        _textView.delegate = self;
        
    }
    return _textView;
}

- (UIButton *)confirmButton{
    if(!_confirmButton){
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake(VIEW_PACE, self.textView.bottom+30, self.textView.width, 45);
        [_confirmButton setBackgroundColor:[UIColor colorWithNavBottomLine]];
        [_confirmButton setTitle:@"提交您的宝贵意见" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(feedback:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}

- (UILabel *)numberText{
    if(!_numberText){
        _numberText = [[UILabel alloc]initWithFrame:CGRectMake(0, NAV_BOTTOM+20, SCREEN_WIDTH-VIEW_PACE, 20)];
        _numberText.text = [NSString stringWithFormat:@"0/%lu",self.textCount];
        _numberText.textAlignment = NSTextAlignmentRight;
        _numberText.font = [UIFont systemFontOfSize:14];
        _numberText.textColor = [UIColor colorWithNavBottomLine];
    }
    return _numberText;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSInteger length = textView.text.length;
    if(length > self.textCount){
        textView.text = [textView.text substringToIndex:self.textCount];
//        [TBToastView showToastViewWithText:TOASTSTRING_FEEDBACK];
    }
    self.numberText.text = [NSString stringWithFormat:@"%lu/%lu",length,self.textCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phippyNavigationController addBackButton];
    [self.view addSubview:self.numberText];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.confirmButton];
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
