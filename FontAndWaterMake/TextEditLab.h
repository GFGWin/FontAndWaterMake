//
//  TextEditLab.h
//  FontAndWaterMake
//
//  Created by 谷富国 on 2019/10/19.
//  Copyright © 2019 GFGWin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextEnterView.h"
@class TextEditLab;
NS_ASSUME_NONNULL_BEGIN

@protocol TextEditLabDelegate <NSObject>

-(void)showEnterView;
-(void)removeEnterView;

-(void)theUsingLabel:(TextEditLab *)label;

@end


@interface TextEditLab : UILabel<TextEnterViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,weak)id<TextEditLabDelegate> delegate;
@property(nonatomic,assign)BOOL EnterViewIsShow;
@property(nonatomic,strong ,nullable)UIButton * deleteBtn;
@end

NS_ASSUME_NONNULL_END
