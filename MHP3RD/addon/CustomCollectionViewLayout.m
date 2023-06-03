//
//  CustomCollectionViewLayout.m
//  PresentationLayer
//
//  Created by Ivan_deng on 2017/3/15.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#import "CustomCollectionViewLayout.h"
#import "MHPLogger.h"

@implementation CustomCollectionViewLayout

#pragma mark - usless for now

- (void)scrollToTheCurrentItemAtIndex:(NSInteger)currentIndex {
    
}

- (void)collectionViewTapped:(UIGestureRecognizer*)sender {
    //获取当前手指在滑动的view中的位置
    CGPoint location = [sender locationInView:self.collectionView];
    //获取当前位置中属于collectionview的哪个item;
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    if(indexPath == nil){
        return ;
    }
    if(_currentItemIndex == indexPath.item){
        if([self.collectionView.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)])
           [self.collectionView.delegate collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    }else{
        //如果手指滑动到某个item上方，则将画面移到item正中。
        _currentItemIndex = indexPath.item;
        [self.collectionView setContentOffset:CGPointMake(indexPath.item * (_internalItemSpacing + _itemSize.width), 0) animated:true];
        if([self.delegate respondsToSelector:@selector(scrolledToTheCurrentIntemAtIndex:)])
            [self.delegate scrolledToTheCurrentIntemAtIndex:self.currentItemIndex];
    }
    return;
}

#pragma mark - main methods

- (CGSize)collectionViewContentSize {
    CGFloat contentWidth = _sectionEdgeInsets.left + _sectionEdgeInsets.right + _itemCount * _itemSize.width + (_itemCount - 1) * _internalItemSpacing;
    CGFloat contentHeight = _sectionEdgeInsets.top + _sectionEdgeInsets.bottom + self.collectionView.frame.size.height;
    return CGSizeMake(contentWidth, contentHeight); 
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = _itemSize;
    CGFloat xPoint = (int)indexPath.row * (_itemSize.width + _internalItemSpacing) + _sectionEdgeInsets.left;
    CGFloat yPoint = (self.collectionView.bounds.size.height - _itemSize.height)/2 + _sectionEdgeInsets.top;
    CGFloat wSize = attributes.size.width;
    CGFloat hSize = attributes.size.height;
    attributes.frame = CGRectMake(xPoint, yPoint, wSize, hSize);
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attrs = [NSMutableArray array];
    CGRect visiableRect = CGRectMake(self.collectionView.contentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    CGFloat centerX = self.collectionView.contentOffset.x + [UIScreen mainScreen].bounds.size.width/2;
    
    for (NSInteger i = 0; i < _itemCount; i++){
        //这里设置了section 0
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attrs addObject:attr];
        //如果两个范围是不相交的
        if(CGRectIntersectsRect(attr.frame, visiableRect) == false)
            continue;
        //求绝对值
        CGFloat xOffset = fabs(attr.center.x - centerX);
        
        CGFloat scale = 1 - (xOffset * (1 - _scale))/(([UIScreen mainScreen].bounds.size.width + self.itemSize.width)/2 - self.internalItemSpacing);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attrs;
}

//当滚动的时候，重新生成对应属性
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return TRUE;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    NSInteger itemIndex = (NSInteger)(self.collectionView.contentOffset.x/ (_itemSize.width + _internalItemSpacing));
    CGFloat xOffset = itemIndex * (_internalItemSpacing + _itemSize.width);
    CGFloat xOffset_1 = (itemIndex + 1) * (_internalItemSpacing + _itemSize.width);
    
    if(fabs(proposedContentOffset.x - xOffset) > fabs(xOffset_1 - proposedContentOffset.x)) {
        _currentItemIndex = itemIndex + 1;
        if([self.delegate respondsToSelector:@selector(scrollToTheCurrentItemAtIndex:)])
            [self.delegate scrolledToTheCurrentIntemAtIndex:_currentItemIndex];
        return CGPointMake(xOffset_1, 0);
    }
    
    _currentItemIndex = itemIndex;
    if([self.delegate respondsToSelector:@selector(scrolledToTheCurrentIntemAtIndex:)])
        [self.delegate scrolledToTheCurrentIntemAtIndex:_currentItemIndex];
    return CGPointMake(xOffset_1, 0);
}

- (void)prepareLayout {
    [super prepareLayout];
    self.itemCount = [self.collectionView numberOfItemsInSection:0];
    
    if(self.internalItemSpacing == 0){
        _internalItemSpacing = 5;
    }
    if(self.sectionEdgeInsets.top == 0 && _sectionEdgeInsets.bottom == 0 && _sectionEdgeInsets.left == 0 && _sectionEdgeInsets.right == 0) {
        _sectionEdgeInsets = UIEdgeInsetsMake(0,(SCREENWIDTH - self.itemSize.width)/2, 0,(SCREENWIDTH - self.itemSize.height)/2);
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(collectionViewTapped:)];
//        [tapGesture setDelegate:self];
//        [self.collectionView addGestureRecognizer:tapGesture];
    }
}




@end
