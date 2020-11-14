//
//  FontSelectionView.m
//  FontAndWaterMake
//
//  Created by 谷富国 on 2019/10/21.
//  Copyright © 2019 GFGWin. All rights reserved.
//

#import "FontSelectionView.h"

@implementation FontSelectionView
- (instancetype)initWithFrame:(CGRect)frame withBlock:(sendFont)block
{
    self = [super initWithFrame:frame];
    if (self) {
        self.block = block;
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
