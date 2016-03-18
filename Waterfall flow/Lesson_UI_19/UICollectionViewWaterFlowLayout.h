//
//  UICollectionViewWaterFlowLayout.h
//  Lesson_UI_19
//
//  Created by MouXiangyang on 14/10/15.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UICollectionViewWaterFlowLayout;

@protocol UICollectionViewDelegateWaterFlowLayout <UICollectionViewDelegate>

//
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterFlowLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface UICollectionViewWaterFlowLayout : UICollectionViewLayout

@property (nonatomic, assign) id<UICollectionViewDelegateWaterFlowLayout> delegate;
@property (nonatomic, assign) NSUInteger columnCount;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

@end
