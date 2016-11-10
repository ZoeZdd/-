//
//  WBStatusResult.h
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/30.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"
@interface WBStatusResult : NSObject<MJKeyValue>

/**
 *  用户的微博数组（WBStatus）
 */
@property (nonatomic,strong) NSArray *statuses;

/**
 *  用户最近微博总数
 */

@property (nonatomic,assign) int *total_number;

@end
