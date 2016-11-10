//
//  WBUserResult.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/30.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBUserResult.h"

@implementation WBUserResult

-(int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

-(int)totalCount
{
    return self.messageCount + _status + _follower;
}
@end
