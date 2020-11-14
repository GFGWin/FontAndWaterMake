//
//  TextEnterView.h
//  FontAndWaterMake
//
//  Created by 谷富国 on 2019/10/19.
//  Copyright © 2019 GFGWin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TextEnterViewDelegate <NSObject>

-(void)editEnd;
-(void)TextDirection:(NSInteger)Alignment;
-(void)TextColor:(NSString *)ColorHex;
@end
@interface TextEnterView : UIView
@property(nonatomic,strong)UITextField *inputTF;
@property(nonatomic,copy)NSString *placeHolderText;
@property(nonatomic,weak)id <TextEnterViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
