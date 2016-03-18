//
//  CollectionImageCell.m
//  Lesson_UI_19
//
//  Created by MouXiangyang on 14/10/15.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import "CollectionImageCell.h"

@implementation CollectionImageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
    self.titleLabel.frame = self.contentView.bounds;
}

//- (UILabel *)titleLabel{
//    if (!_titleLabel) {
//        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:_titleLabel];
//    }
//    return _titleLabel;
//}

- (UIImageView *)imageView{
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds] ;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (void)dealloc{
   
}

@end
