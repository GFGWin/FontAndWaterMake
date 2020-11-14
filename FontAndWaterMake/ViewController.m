//
//  ViewController.m
//  FontAndWaterMake
//
//  Created by 谷富国 on 2019/10/19.
//  Copyright © 2019 GFGWin. All rights reserved.
//



#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "TextEditLab.h"
#import "TextEnterView.h"
#import <GPUImage/GPUImage.h>



@interface ViewController ()<TextEditLabDelegate>
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)TextEditLab *currentLabel;
@property(nonatomic,strong)TextEnterView *enterView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = [UIImage imageNamed:@"1.jpeg"];
    self.imageView.userInteractionEnabled = YES;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 64, 50, 50);
    btn.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(addTransverseLab) forControlEvents:UIControlEventTouchUpInside];
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(50, 64, 50, 50);
    btn2.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(addPortraitLab) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(SCREEN_WIDTH-60, 64, 50, 50);
    btn3.backgroundColor=[UIColor blackColor];
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(addwatermake) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addwatermake
{
    
    //将所有的label的边框去除
    for (UIView *view  in self.imageView.subviews) {
        if ([view isKindOfClass:[TextEditLab class]]) {
            TextEditLab *lab = (TextEditLab *)view;
            lab.layer.borderWidth = 0;
        }
    }
    
    
   
    GPUImageUIElement *uiElement = [[GPUImageUIElement alloc] initWithView:self.imageView];
    
    GPUImageFilter *disFilter = [[GPUImageFilter alloc] init];
    [disFilter forceProcessingAtSize:self.imageView.bounds.size];
    [disFilter useNextFrameForImageCapture];
    
    GPUImagePicture *sourcePicture = [[GPUImagePicture alloc] initWithImage:self.imageView.image];
    
    [sourcePicture addTarget:disFilter];
    
    GPUImageDissolveBlendFilter *_filter = [[GPUImageDissolveBlendFilter alloc] init];
    _filter.mix = 1;
    [disFilter addTarget:_filter];
    [uiElement addTarget:_filter];
    
    [uiElement update];
    [sourcePicture processImageUpToFilter:_filter withCompletionHandler:^(UIImage *processedImage) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.imageView.image = processedImage;
            for (UIView *view  in self.imageView.subviews) {
                if ([view isKindOfClass:[TextEditLab class]]) {
                    TextEditLab *lab = (TextEditLab *)view;
                    [lab removeFromSuperview];
                }
            }
  
        });
        
    }];
    
}
-(void)addTransverseLab
{
    TextEditLab*label = [[TextEditLab alloc]init];
    label.frame = CGRectMake(0, 0, SCREEN_WIDTH-60, 50);
    label.center = self.imageView.center;
    label.delegate = self;
    [self.imageView addSubview:label];
    
}

-(void)addPortraitLab
{
    TextEditLab*label = [[TextEditLab alloc]init];
    label.frame = CGRectMake(0, 0, 50, SCREEN_HEIGHT - 120);
    label.center = self.imageView.center;
    label.delegate = self;
    [self.imageView addSubview:label];
   
}

#pragma mark - TextEditLabDelegate
-(void)theUsingLabel:(TextEditLab *)label
{
    self.currentLabel = label;
}

- (void)removeEnterView {
    [self.enterView removeFromSuperview];
    self.enterView = nil;
}

- (void)showEnterView {
    if (!self.enterView) {
        self.enterView = [[TextEnterView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60)];
        self.enterView.placeHolderText = self.currentLabel.text;
        [self.enterView.inputTF becomeFirstResponder];
        [self.view addSubview:self.enterView];
        [self.enterView.inputTF addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        self.enterView.delegate = self.currentLabel;
    }
}
-(void)textFieldTextChanged:(UITextField *)TF
{
    self.currentLabel.text = TF.text;
    //自适应高度
    CGRect txtFrame = self.currentLabel.frame;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.currentLabel.font,NSFontAttributeName, nil];
    CGSize size = CGSizeMake(txtFrame.size.width, CGFLOAT_MAX);
    txtFrame.size.height =[self.currentLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
    self.currentLabel.frame = txtFrame;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.enterView removeFromSuperview];
    self.enterView = nil;
    [self.enterView.inputTF endEditing:YES];
    self.currentLabel.EnterViewIsShow = NO;
    self.currentLabel.layer.borderColor =[UIColor blueColor].CGColor;
       [self.currentLabel.deleteBtn removeFromSuperview];
       self.currentLabel.deleteBtn = nil;
}

@end
