//
//  WBStatusResult.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/30.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBStatusResult.h"

#import "WBStatus.h"
@implementation WBStatusResult

+(NSDictionary *)objectClassInArray
{
    return @{@"statuses":[WBStatus class]};
}
@end
