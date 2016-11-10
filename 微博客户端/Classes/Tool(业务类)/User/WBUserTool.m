//
//  WBUserTool.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/30.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//
// 处理用户的业务

#import "WBUserTool.h"
#import "WBHttpTool.h"
#import "WBUserParam.h"
#import "WBUserResult.h"

#import "WBAccount.h"
#import "WBAccountTool.h"
#import "MJExtension.h"

#import "WBUser.h"
@implementation WBUserTool

+(void)unreadWithSuccess:(void (^)(WBUserResult *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    WBUserParam *param = [WBUserParam param];
    param.uid = [WBAccountTool account].uid;
    
    [WBHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        // 字典转模型
        WBUserResult *result = [WBUserResult objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)userInfoWithSuccess:(void (^)(WBUser *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    WBUserParam *param = [WBUserParam param];
    param.uid = [WBAccountTool account].uid;
    
    [WBHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
         // 字典转模型
        WBUser *user = [WBUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
