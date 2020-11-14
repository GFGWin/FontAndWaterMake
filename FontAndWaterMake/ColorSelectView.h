//
//  ColorSelectView.h
//  FontAndWaterMake
//
//  Created by 谷富国 on 2019/10/21.
//  Copyright © 2019 GFGWin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^sendColor)(NSString * color);
@interface ColorSelectView : UIView
@property(nonatomic,copy)sendColor block;
- (instancetype)initWithFrame:(CGRect)frame withBlock:(sendColor)block;
@end

NS_ASSUME_NONNULL_END
