//
//  QiushiRequestManager.h
//  QiushibaikeClient
//
//  Created by MouXiangyang on 14/10/13.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import "QiushiBaseManager.h"
@class QiushiRequestManager;

@protocol QiushiRequestManagerDelegate <NSObject>

- (void)request:(QiushiRequestManager *)request
didFinshiLoadingWithData:(NSData *)data;
- (void)request:(QiushiRequestManager *)request didFaildWithError:(NSError *)error;

@end

@interface QiushiRequestManager : QiushiBaseManager

@property (nonatomic, retain) NSMutableDictionary *paramsDictionary;//请求的参数字典
@property (nonatomic, retain) NSString *destinationURLString;//目标地址
@property (nonatomic, assign) id<QiushiRequestManagerDelegate> delegate;

- (void)startRequest;//开始请求数据

@end
