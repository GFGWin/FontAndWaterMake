//
//  TextDirectionSelectView.h
//  FontAndWaterMake
//
//  Created by 谷富国 on 2019/10/21.
//  Copyright © 2019 GFGWin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^sendAlignment)(NSInteger Alignment);

@interface TextDirectionSelectView : UIView
@property(nonatomic,copy)sendAlignment block;

- (instancetype)initWithFrame:(CGRect)frame withBlock:(sendAlignment) block;
@end

NS_ASSUME_NONNULL_END
