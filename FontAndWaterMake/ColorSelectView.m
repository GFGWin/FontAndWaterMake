//
//  ColorSelectView.m
//  FontAndWaterMake
//
//  Created by 谷富国 on 2019/10/21.
//  Copyright © 2019 GFGWin. All rights reserved.
//

#import "ColorSelectView.h"
#import "UIColor+Hex.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ColorSelectView()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation ColorSelectView
{
    NSArray *ColorArr;
    UICollectionView *collectionView;
}
- (instancetype)initWithFrame:(CGRect)frame withBlock:(sendColor)block
{
    self = [super initWithFrame:frame];
    if (self) {
        ColorArr = [[NSArray alloc]initWithObjects:@"ffffff",@"eee0cd",@"fcd1ff",@"ffd5c2",@"fff1b1",@"f5e184",@"fffd00",@"bfff00",@"84ff85",@"88efe4",@"6de0ff",@"57baff",@"ffcc00",@"ffa424",@"ff7474",@"e2355a",@"d65cda",@"8f6e52",@"b90071",@"28f5af",@"4f3c8d",@"ff5722",@"008a27",@"9b82fc",@"d2d2d2",@"b0b0b0",@"9a9999",@"666666",@"333333",@"000000", nil];
        self.block = block;
        [self addCollectionView];
    }
    return self;
}
-(void)addCollectionView
{
    UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc] init];
    flow_layout.itemSize= CGSizeMake(SCREEN_WIDTH/7.5, SCREEN_WIDTH/7.5);
    flow_layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:flow_layout];
    
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"colorCell"];
    collectionView.userInteractionEnabled = true;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    [self addSubview:collectionView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"colorCell";
    UICollectionViewCell * colorCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    colorCell.backgroundColor = [UIColor colorWithHexString:ColorArr[indexPath.row]];
    colorCell.layer.cornerRadius = SCREEN_WIDTH/15;
    colorCell.clipsToBounds = YES;
    return colorCell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return ColorArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.block(ColorArr[indexPath.row]);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
