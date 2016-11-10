//
//  WBAccountTool.h
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/29.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//
//  专门处理账号的业务（账号存储和读取）

@class WBAccount;
#import <Foundation/Foundation.h>

@interface WBAccountTool : NSObject

+ (void)saveAccount:(WBAccount *)account;

+ (WBAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;
@end
