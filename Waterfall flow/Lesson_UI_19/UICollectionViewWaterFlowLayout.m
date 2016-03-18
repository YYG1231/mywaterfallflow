//
//  UICollectionViewWaterFlowLayout.m
//  Lesson_UI_19
//
//  Created by MouXiangyang on 14/10/15.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import "UICollectionViewWaterFlowLayout.h"

@interface UICollectionViewWaterFlowLayout ()
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, retain) NSMutableArray *columnHeights;
@property (nonatomic, retain) NSMutableArray *itemAttributs;

@end

@implementation UICollectionViewWaterFlowLayout

- (id)init{
    if (self = [super init]) {
        self.columnCount = 2;
        self.itemWidth = 145.0;
        self.sectionInsets = UIEdgeInsetsZero;
    }
    return self;
}
- (NSMutableArray *)itemAttributs{
    if (!_itemAttributs) {
        self.itemAttributs = [NSMutableArray array];
    }
    return _itemAttributs;
}

- (NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        self.columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (void)dealloc{
  
}

- (int)_shortestColumnIndex{
    int index = 0;
    CGFloat shortestHeight = CGFLOAT_MAX;
    for (int i = 0; i < self.columnHeights.count; i++) {
        CGFloat height = [self.columnHeights[i] floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            index = i;
        }
    }
    return index;
}

- (int)_longestColumnIndex{
    int index = 0;
    CGFloat longestHeight = 0;
    for (int i = 0; i < self.columnHeights.count; i++) {
        CGFloat height = [self.columnHeights[i] floatValue];
        if (height > longestHeight) {
            longestHeight = height;
            index = i;
        }
    }
    return index;
}

- (void)_calculateItemPosition
{
    self.itemCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat contentWidth = self.collectionView.frame.size.width - self.sectionInsets.left - self.sectionInsets.right;
    
    self.interitemSpacing = floorf((contentWidth - self.columnCount * self.itemWidth) / (self.columnCount - 1));
    
    for (int i = 0; i < self.columnCount; i++) {
        self.columnHeights[i] = @(self.sectionInsets.top);
    }
    
    for (int i = 0; i < self.itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        NSLog(@"%@", self.columnHeights);
        CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];
        
        int shortestColumnIndex = [self _shortestColumnIndex];
        
        CGFloat delta_x = self.sectionInsets.left + (self.itemWidth + self.interitemSpacing) * shortestColumnIndex;
        CGFloat delta_y = [self.columnHeights[shortestColumnIndex] floatValue];
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(delta_x, delta_y, self.itemWidth, itemHeight);
        [self.itemAttributs addObject:attributes];
        
        self.columnHeights[shortestColumnIndex] = @(ceilf(delta_y + self.interitemSpacing + itemHeight));
    }
}

- (void)prepareLayout{
    [super prepareLayout];
    [self _calculateItemPosition];
}

- (CGSize)collectionViewContentSize{
    CGSize contentSize = self.collectionView.frame.size;
    int longestColumnIndex = [self _longestColumnIndex];
    CGFloat longestHeight = [self.columnHeights[longestColumnIndex] floatValue];
    contentSize.height = longestHeight - self.interitemSpacing + self.sectionInsets.bottom;
    return contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemAttributs[indexPath.item];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.itemAttributs;
}


@end
