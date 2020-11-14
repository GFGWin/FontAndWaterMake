//
//  TextDirectionSelectView.m
//  FontAndWaterMake
//
//  Created by 谷富国 on 2019/10/21.
//  Copyright © 2019 GFGWin. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "TextDirectionSelectView.h"

@implementation TextDirectionSelectView
{
    NSArray *arr;
    UIButton *lastBtn;
}
- (instancetype)initWithFrame:(CGRect)frame withBlock:(sendAlignment) block
{
    self = [super initWithFrame:frame];
    if (self) {
        arr = [[NSArray alloc]initWithObjects:@"左对齐",@"居中对齐",@"右对齐", nil];
        self.block = block;
        [self addlab];
        [self addBtn];
        
    }
    return self;
}

-(void)addlab
{
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 70, 100, 50)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"对齐方式";
    lab.textColor = [UIColor whiteColor];
    
    [self addSubview:lab];
}
-(void)addBtn{
    for (int i = 0; i<arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*SCREEN_WIDTH/3+(SCREEN_WIDTH/3-80)/2, 120, 80, 80);
        
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"duiqi_%d",i+1]] forState:UIControlStateNormal];
        button.tag = 500+i;
        [button addTarget:self action:@selector(TextDirection:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
-(void)TextDirection:(UIButton *)sender
{
    
    if (lastBtn!=sender) {
        sender.selected = YES;
        lastBtn.layer.borderWidth = 0;
        sender.layer.borderWidth = 2;
        sender.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    lastBtn.selected = NO;
    lastBtn = sender;
    
    self.block(sender.tag-500);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
