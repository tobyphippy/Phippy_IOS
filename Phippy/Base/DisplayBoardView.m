//
//  DisplayBoardView.m
//  Test005
//
//  Created by toby on 06/02/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "DisplayBoardView.h"
//#import "UILabel+Expand.h"

#define BOARDVIEW_MOVING_SPEED   3
#define BOARDVIEW_MOVING_TIME    0.15

#define titleLabX                0
@interface DisplayBoardView()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIImageView *iconImageView;

@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIView *maskView;
@end

@implementation DisplayBoardView{

    CGFloat contentStrLength;

}

#pragma mark - life cycle

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        //[self insertSubview:self.contentLab belowSubview:self.titleLab];
        self.maskView.frame = self.bounds;
        self.title = @"最新公告：";
        self.backgroundColor = [UIColor whiteColor];
        self.titleLab.backgroundColor =  COLOR(37, 33, 29, 1);
        [self addSubview:self.iconImageView];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.contentLab];
    }
    return self;
}

#pragma mark - set get
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectZero];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        [self addSubview:_maskView];
    }
    return _maskView;
}

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.height-10, self.height-10)];
        _iconImageView.image = [UIImage imageNamed:@"icon-speaker"];
    }
    return _iconImageView;
}
- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
    self.titleLab.backgroundColor = bgColor;
    self.iconImageView.backgroundColor = bgColor;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    
    self.titleLab.textColor = _titleColor;
}

- (void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    
    self.contentLab.textColor = _contentColor;
}

- (void)setTitle:(NSString *)title {
//    _title = title;
//    
//    CGSize textSize = [self getLabSizeWith:title font:_titleLab.font];
//    self.titleLab.frame = CGRectMake(titleLabX, 0, textSize.width, self.bounds.size.height);
//    self.titleLab.text = title;
}

- (void)setContent:(NSString *)content{
    self.maskView.frame = self.bounds;
    _content = content;
   // CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
//    CGSize textSize = [self getLabSizeWith:content font:_contentLab.font];
    self.contentLab.text = content;
//    CGSize textSize = [self.contentLab calculateWidth:self.bounds.size.height];
    CGSize textSize = [self calculateWidth:self.bounds.size.height label:self.contentLab];
    self.contentLab.frame = CGRectMake(self.contentView.width, 0,textSize.width, self.bounds.size.height);
    contentStrLength = textSize.width;
    if(content != nil){
        [self.timer fire];
    }
}

- (NSTimer *)timer {
    if(!_timer){
        _timer =[NSTimer scheduledTimerWithTimeInterval:BOARDVIEW_MOVING_TIME target:self selector:@selector(moveBoardView) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (UILabel *)titleLab{
    if(!_titleLab){
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(titleLabX, 0, 0, self.bounds.size.height)];
        _titleLab.textAlignment = NSTextAlignmentRight;
        _titleLab.font = [UIFont systemFontOfSize:15];
        
    }
    return _titleLab;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(self.titleLab.right + 36, 0, self.width - self.titleLab.right, self.height)];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.clipsToBounds = YES;
        
    }
    return _contentView;
}

- (UILabel *)contentLab {
    if(!_contentLab){
        CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
        _contentLab = [[UILabel alloc]initWithFrame:CGRectMake(screen_width, 0, 0, self.bounds.size.height)];
        _contentLab.font = [UIFont systemFontOfSize:15];
    }
    return _contentLab;
}

#pragma mark - 内部方法
- (CGSize)calculateWidth:(CGFloat)height label:(UILabel *)lab{
    NSDictionary *attribute = @{NSFontAttributeName:lab.font};
    CGSize size = [lab.text boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size;
}


- (void)moveBoardView{
    CGRect rect = self.contentLab.frame;
    self.contentLab.frame = CGRectMake(rect.origin.x-BOARDVIEW_MOVING_SPEED, rect.origin.y, rect.size.width, rect.size.height);
    
    if([self boardViewShouldStop:rect.origin.x]){
        [self resetBoardView];
    }
}


- (void)resetBoardView{
    [self.timer invalidate];
    self.timer = nil;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    self.contentLab.frame = CGRectMake(screen_width-10, 0, contentStrLength, self.bounds.size.height);

    [self.timer fire];
}



- (BOOL)boardViewShouldStop:(CGFloat)x{
    if(x<=-contentStrLength){
        return YES;
    }
    return NO;
}

- (CGSize)getLabSizeWith:(NSString *)string font:(UIFont *)font {
    // 设置文字属性 要和label的一致
    
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize mSize = CGSizeMake(screen_width, MAXFLOAT);
    
    // 计算文字占据的高度
    CGSize size = [[NSString stringWithFormat:@"       %@",string] boundingRectWithSize:mSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    // 设置label尺寸
    // label.frame = CGRectMake(50, 44, size.width, size.height);
    return size;
}
@end
