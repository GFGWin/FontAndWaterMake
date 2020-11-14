//
//  TextEnterView.m
//  FontAndWaterMake
//
//  Created by 谷富国 on 2019/10/19.
//  Copyright © 2019 GFGWin. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "TextEnterView.h"
#import "TextDirectionSelectView.h"
#import "ColorSelectView.h"
@interface TextEnterView()
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)UIButton *lastBtn;
@property(nonatomic,strong)UIView *backGroundView;
@end


@implementation TextEnterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arr = [[NSArray alloc]initWithObjects:@"文本",@"格式",@"颜色",@"字体", nil];
        self.backgroundColor = [UIColor grayColor];
        [self addSubviews];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(TextFieldWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
    }
    return self;
}
-(UIView *)backGroundView
{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, self.bounds.size.height-70)];
        [self addSubview:self.backGroundView];
    }
    return _backGroundView;
}
-(void)setPlaceHolderText:(NSString *)placeHolderText
{
    _placeHolderText = placeHolderText;
    self.inputTF.text = self.placeHolderText;
}

-(void)addSubviews
{
    [self addKindBtn];
    [self addTextField];
}
-(void)addKindBtn
{
    for (int i =0; i<4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30+SCREEN_WIDTH/6*i, 0, SCREEN_WIDTH/6, 30);
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(changeKind:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:32/255.0 green:73/255.0 blue:120/255.0 alpha:1.0]] forState:UIControlStateSelected];
        btn.layer.cornerRadius = 15;
        btn.clipsToBounds = YES;
        [self addSubview:btn];
        if (btn.tag == 200) {
            btn.selected = YES;
            self.lastBtn = btn;
        }
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/6, 0, SCREEN_WIDTH/6, 30);
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

-(UIImage *)imageWithColor:(UIColor *)color {
   CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
   UIGraphicsBeginImageContext(rect.size);
   CGContextRef context = UIGraphicsGetCurrentContext();
   CGContextSetFillColorWithColor(context, [color CGColor]);
   CGContextFillRect(context, rect);
   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return image;
}
-(void)dismiss
{   
    [self.inputTF endEditing:YES];
    [self TextFieldWillDissMiss];
}

-(void)changeKind:(UIButton *)sender
{
    
    [self.backGroundView removeFromSuperview];
    self.backGroundView = nil;
    self.lastBtn.selected = NO;
    sender.selected = YES;
    self.lastBtn = sender;
    
    switch (sender.tag) {
        case 200:
            [self.inputTF becomeFirstResponder];
            break;
        case 201:
        {
            [self.inputTF endEditing:YES];
            TextDirectionSelectView *view = [[TextDirectionSelectView alloc]initWithFrame:self.backGroundView.bounds withBlock:^(NSInteger Alignment) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(TextDirection:)]) {
                    [self.delegate TextDirection:Alignment];
                }
            }];
            [self.backGroundView addSubview:view];
        }
            
            
            break;
        case 202:
        {
            [self.inputTF endEditing:YES];
            ColorSelectView * view = [[ColorSelectView alloc]initWithFrame:self.backGroundView.bounds withBlock:^(NSString * _Nonnull color) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(TextColor:)]) {
                    [self.delegate TextColor:color];
                }
            }];
            [self.backGroundView addSubview:view];
        }
            break;
        case 203:
            [self.inputTF endEditing:YES];
            //展示字体选择
            break;
        default:
            break;
    }
    
    
}
-(void)addTextField
{
    self.inputTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, SCREEN_WIDTH-60, 30)];
    self.inputTF.backgroundColor = [UIColor whiteColor];
    self.inputTF.textColor = [UIColor blackColor];
    [self addSubview:self.inputTF];
}

-(void)TextFieldWillShow:(NSNotification *)notifi
{
    NSDictionary *dict = notifi.userInfo;
    CGRect endRect = [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect rect = self.frame;
    rect.origin.y = endRect.origin.y - 60;
    rect.size.height = endRect.size.height + 60;
    self.frame = rect;
}
-(void)TextFieldWillDissMiss
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(editEnd)]) {
        [self.delegate editEnd];
    }
}

-(void)dealloc
{
    NSLog(@"文字输入控件释放");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
