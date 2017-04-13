//
//  CustomCollectionViewLayout.h
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/15.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCollectionViewLayoutDelegate <NSObject>

@optional
- (void)scrolledToTheCurrentIntemAtIndex:(NSInteger)itemIndex;

@end

@interface CustomCollectionViewLayout : UICollectionViewLayout<UIGestureRecognizerDelegate>
//每个cell之间的间隔，固定大小
@property(nonatomic,assign) CGFloat internalItemSpacing;
//每个cell的大小
@property(nonatomic,assign) CGSize itemSize;
//每个section的间距
@property(nonatomic,assign) UIEdgeInsets sectionEdgeInsets;
//表示左边或右边的cell的缩放系数
@property(nonatomic,assign) CGFloat scale;
//表示当前cell在UICollectionView中的索引
@property(nonatomic,assign) NSInteger currentItemIndex;
//表示总共有多少个cell
@property(nonatomic,assign) NSInteger itemCount;
//代理对象
@property(nonatomic,assign) id<CustomCollectionViewLayoutDelegate> delegate;

#pragma mark - methods

- (void)prepareLayout;

@end


