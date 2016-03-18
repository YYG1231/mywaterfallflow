//
//  QiushiRequestManager.m
//  QiushibaikeClient
//
//  Created by MouXiangyang on 14/10/13.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import "QiushiRequestManager.h"

@interface QiushiRequestManager ()<NSURLConnectionDataDelegate>

@property (nonatomic, retain) NSMutableData *receivedData;//暂存下载到的数据

- (void)_cleanCatchedData;//清空暂存的数据
- (NSArray *)_packageParamsToArray;//将参数打包成数组
- (NSData *)_postBodyFromParamsArray;//将参数数组在转成post请求参数

@end


@implementation QiushiRequestManager

+ (id)sharedManager{
    static id manager = nil;
    if (manager == nil) {
        manager = [[[self class] alloc] init];
    }
    return manager;
}

- (NSMutableData *)receivedData{
    if (!_receivedData) {
        self.receivedData = [NSMutableData data];
    }
    return _receivedData;
}

- (NSMutableDictionary *)paramsDictionary{
    if (!_paramsDictionary) {
        self.paramsDictionary = [NSMutableDictionary dictionary];
    }
    return _paramsDictionary;
}

- (void)dealloc{
   
}

- (void)_cleanCatchedData{
    [self.receivedData setData:nil];
    [self.paramsDictionary removeAllObjects];
}


- (void)startRequest{
    NSURL *url = [NSURL URLWithString:self.destinationURLString];
    //可变request对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //判断如果字典的键值对个数不为0说明时post请求,否则为get请求
    if (self.paramsDictionary.count != 0) {
        [request setHTTPMethod:@"POST"];
        //设置请求参数
        [request setHTTPBody:[self _postBodyFromParamsArray]];
    }
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (NSArray *)_packageParamsToArray{
    NSMutableArray *params = [NSMutableArray array];
    for (NSString *key in self.paramsDictionary) {
        NSString *oneParam = [NSString stringWithFormat:@"%@=%@", key, self.paramsDictionary[key]];
        [params addObject:oneParam];
    }
    return params;
}

- (NSData *)_postBodyFromParamsArray{
    NSArray *params = [self _packageParamsToArray];
    NSString *postString = [params componentsJoinedByString:@"&"];
    NSLog(@"%@", postString);
    return [postString dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //完成下载
    if (self.delegate && [self.delegate respondsToSelector:@selector(request:didFinshiLoadingWithData:)]) {
        [self.delegate request:self didFinshiLoadingWithData:self.receivedData];
    }
    
    [self _cleanCatchedData];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //下载失败
    if (self.delegate && [self.delegate respondsToSelector:@selector(request:didFaildWithError:)]) {
        [self.delegate request:self didFaildWithError:error];
    }
    
    [self _cleanCatchedData];
}

@end
