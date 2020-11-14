//
//  TextEditLab.m
//  FontAndWaterMake
//
//  Created by 谷富国 on 2019/10/19.
//  Copyright © 2019 GFGWin. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "TextEditLab.h"
#import "UIColor+Hex.h"
@interface TextEditLab()


@end
@implementation TextEditLab
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.text = @"请输入文本";
        self.textColor = [UIColor blackColor];
        self.layer.borderWidth =2;
        self.layer.borderColor =[UIColor blueColor].CGColor;
        
        //自动换行设置
        self.lineBreakMode = NSLineBreakByWordWrapping;
        self.numberOfLines = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapself)];
        [self addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panself:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        self.userInteractionEnabled = YES;
        self.EnterViewIsShow = NO;
        
    }
    return self;
}
#pragma mark --单手指点击
-(void)tapself
{
    self.layer.borderColor =[UIColor redColor].CGColor;
    if (!self.deleteBtn) {
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn.frame = CGRectMake(-15, -15, 30, 30);
        [self addSubview:self.deleteBtn];
        [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(removeLab) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(theUsingLabel:)]) {
        [self.delegate theUsingLabel:self];
    }
    if (!self.EnterViewIsShow) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(showEnterView)]) {
            [self.delegate showEnterView];
            self.EnterViewIsShow = YES;
        }
        
    }
    
}
#pragma mark --单手指拖拽
- (void)panself:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:self];
        CGPoint Center = self.center;
        Center.x +=translation.x;
        Center.y +=translation.y;
        self.center = Center;
        //关键，不设为零会不断递增
        [panGestureRecognizer setTranslation:CGPointZero inView:self];
    }
}

-(void)removeLab
{
    [self.deleteBtn removeFromSuperview];
    self.deleteBtn = nil;
    [self removeFromSuperview];
    
}

#pragma mark - TextEnterViewDelegate
-(void)editEnd
{
    self.layer.borderColor =[UIColor blueColor].CGColor;
    [self.deleteBtn removeFromSuperview];
    self.deleteBtn = nil;
    
    
    if (self.EnterViewIsShow) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(removeEnterView)]) {
            [self.delegate removeEnterView];
            self.EnterViewIsShow = NO;
        }
        
    }
    
}

-(void)TextDirection:(NSInteger)Alignment
{
    self.textAlignment = Alignment;
}

-(void)TextColor:(NSString *)ColorHex
{
    self.textColor = [UIColor colorWithHexString:ColorHex];
}
//UIButton 超出父视图，超出部分点击无响应，此方法解决
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *result = [super hitTest:point withEvent:event];
    CGPoint butttonClickPoint = [self.deleteBtn convertPoint:point fromView:self];
    if ([self.deleteBtn pointInside:butttonClickPoint withEvent:event]) {
        return self.deleteBtn;
    }
    return result;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
