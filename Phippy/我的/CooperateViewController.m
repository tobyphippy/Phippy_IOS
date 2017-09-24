//
//  CooperateViewController.m
//  Phippy
//
//  Created by toby on 13/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "CooperateViewController.h"

@interface CooperateViewController ()<UITextViewDelegate>

@property (nonatomic,strong) UITextView *textView;

@end

@implementation CooperateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.phippyNavigationController addBackButton];
    [self.view addSubview:self.textView];
}

- (UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
//        _textView.text = self.content;
        
        
        NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:@"缓缓飘落的枫叶像思念我点燃烛火温暖岁末的秋天激光掠过天边被风掠过想你的思念"];
        // 设置字体大小 range是设置范围，下同
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
        // 设置字体颜色
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(2, 5)];
        // 设置下划线
        [str addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(3, 7)];
        // 设置字体样式
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Geeza Pro" size:25] range:NSMakeRange(5, 5)];
        //NSLog(@"字体集合%@",[UIFont familyNames]);
        // 删除线 常用于划掉原价
        [str addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(8, 5)];
        // 删除线的颜色(先设置删除线再设置颜色)
        [str addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(8, 5)];
        // 设置空心字
        [str addAttribute:NSStrokeWidthAttributeName value:@1 range:NSMakeRange(18, 5)];
        // 插入图片
        NSTextAttachment * att = [[NSTextAttachment alloc]init];
        att.image = [UIImage imageNamed:@"2"];
        NSAttributedString * attStr = [NSAttributedString attributedStringWithAttachment:att];
        [str insertAttributedString:attStr atIndex:25];
        // 添加链接
        [str addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.baidu.com"] range:NSMakeRange(30, 6)];
        
        // 创建字体段落 行间距 格式
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 50;
        paragraphStyle.firstLineHeadIndent = 30;// 设置为字体大小大两倍
        //    _textView.attributedText = [[NSAttributedString alloc] initWithString:str.string attributes:@{
        //                                                                        NSFontAttributeName:[UIFont systemFontOfSize:15],
        //                                                                        NSParagraphStyleAttributeName:paragraphStyle
        //                                                                                                }];
        [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.string.length)];
        // 这句不能写前面，不然没效果
        _textView.attributedText = [str copy];
        _textView.editable = NO;
        _textView.delegate = self;
        
    }
    return _textView;
}

/**q
 *  点击图片触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"图片%@", textAttachment);
    return NO;
}

/**
 *  点击链接，触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    [[UIApplication sharedApplication] openURL:URL];
    return YES;
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
