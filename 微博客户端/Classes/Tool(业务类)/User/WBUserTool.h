//
//  WBUserTool.h
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/30.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//
// 处理用户的业务

#import <Foundation/Foundation.h>

@class WBUserResult,WBUser;
@interface WBUserTool : NSObject

/**
 *  请求用户的未读书
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */

+ (void)unreadWithSuccess:(void(^)(WBUserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */

+ (void)userInfoWithSuccess:(void(^)(WBUser *user))success failure:(void(^)(NSError *error))failure;

@end
