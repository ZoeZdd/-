//
//  WBUserResult.h
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/30.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 status	int	新微博未读数
 follower	int	新粉丝数
 cmt	int	新评论数
 dm	int	新私信数
 mention_status	int	新提及我的微博数
 mention_cmt	int	新提及我的评论数
 */
@interface WBUserResult : NSObject
/**
 *  新微博未读数
 */
@property (nonatomic,assign) int status;
/**
 *  新粉丝数
 */
@property (nonatomic,assign) int follower;
/**
 *  新评论数
 */
@property (nonatomic,assign) int cmt;
/**
 *  新私信数
 */
@property (nonatomic,assign) int dm;
/**
 *  新提及我的微博数
 */
@property (nonatomic,assign) int mention_status;
/**
 *  新提及我的评论数
 */
@property (nonatomic,assign) int mention_cmt;
/**
 *  消息的总和
 */
- (int)messageCount;
/**
 *  所有未读数的总和
 */
- (int)totalCount;
@end
