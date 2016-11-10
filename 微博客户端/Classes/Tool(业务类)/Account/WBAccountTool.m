//
//  WBAccountTool.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/29.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"

#import "WBHttpTool.h"
#import "WBAccountParam.h"

#import "MJExtension.h"

#define WBAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]


#define WBAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define WBClient_id     @"1272181806"
#define WBRedirect_uri  @"http://www.baidu.com"
#define WBClient_secret @"fb6e095528327c233ca8944af58fb014"


@implementation WBAccountTool
// 类方法一般用静态变量代替成员属性

static WBAccount *_account;
+ (void)saveAccount:(WBAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:WBAccountFileName];
}

+ (WBAccount *)account
{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:WBAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期
            return nil;
        }
        
    }
    
    
    return _account;
}


+(void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    WBAccountParam *params = [[WBAccountParam alloc] init];
    params.client_id = WBClient_id;
    params.client_secret = WBClient_secret;
    params.grant_type = @"authorization_code";
    params.code = code;
    params.redirect_uri = WBRedirect_uri;
    
    
    // 发送请求
    [WBHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(id responseObject) {
        // 字典转模型
        WBAccount *account = [WBAccount accountWithDict:responseObject];
        
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        [WBAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}





@end











