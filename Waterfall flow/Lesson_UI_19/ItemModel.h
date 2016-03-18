//
//  ItemModel.h
//  Lesson_UI_19
//
//  Created by MouXiangyang on 14/10/15.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic, retain) NSString *thumbURLstring;//图片地址
@property (nonatomic, assign) CGFloat imageWidth;//图片宽度
@property (nonatomic, assign) CGFloat imageHeight;//图片高度

- (id)initWithDictionary:(NSDictionary *)dict;
+ (id)itemWithDictionary:(NSDictionary *)dict;

@end
