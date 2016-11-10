//
//  WBStatusTool.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/30.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBStatusTool.h"

#import "WBHttpTool.h"
#import "WBStatus.h"
#import "WBAccount.h"
#import "WBAccountTool.h"

#import "WBStatusParam.h"
#import "WBStatusResult.h"

#import "MJExtension.h"

@implementation WBStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    WBStatusParam  *params = [[WBStatusParam alloc] init];
    params.access_token = [WBAccountTool account].access_token;
    if (sinceId) { // 有微博数据,才需要下拉刷新
        params.since_id = sinceId;
    }
    
    // 发送get请求
    [WBHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {
        // 请求成功的时候调用,代码先保存
        
        // 把结果字典转换成结果模型
        WBStatusResult *result = [WBStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    WBStatusParam  *params = [[WBStatusParam alloc] init];
    
    if (maxId) { // 有微博数据,才需要下拉刷新
        params.max_id = maxId;
    }
    params.access_token = [WBAccountTool account].access_token;
    
    // 发送get请求
    [WBHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {
        // 请求成功的时候调用,代码先保存
        
        // 把结果字典转换成结果模型
        WBStatusResult *result = [WBStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

}
@end
