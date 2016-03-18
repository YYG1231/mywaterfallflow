//
//  ItemModel.m
//  Lesson_UI_19
//
//  Created by MouXiangyang on 14/10/15.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

- (id)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.thumbURLstring = dict[@"thumbURL"];
        self.imageWidth = [dict[@"width"] floatValue];
        self.imageHeight = [dict[@"height"] floatValue];
    }
    return self;
}

+ (id)itemWithDictionary:(NSDictionary *)dict{
    return [[[self class] alloc] initWithDictionary:dict];
}
- (void)dealloc{
   }

@end
