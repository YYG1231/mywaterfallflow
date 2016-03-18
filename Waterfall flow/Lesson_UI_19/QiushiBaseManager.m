//
//  QiushiBaseManager.m
//  QiushibaikeClient
//
//  Created by MouXiangyang on 14/10/13.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import "QiushiBaseManager.h"

@implementation QiushiBaseManager

+ (id)sharedManager{
    static id manager = nil;
    if (manager == nil) {
        manager = [[[self class] alloc] init];
    }
    return manager;
}

@end
