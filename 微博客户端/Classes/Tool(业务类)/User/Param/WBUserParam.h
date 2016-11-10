//
//  WBUserParam.h
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/30.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//
// 用户未读数请求的参数模型

#import <Foundation/Foundation.h>
#import "WBBaseParam.h"

@interface WBUserParam : WBBaseParam

/**
 *  当前用户的唯一标识
 */
@property (nonatomic,copy) NSString *uid;
@end
