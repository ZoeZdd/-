//
//  WBBaseParam.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/30.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBBaseParam.h"
#import "WBAccountTool.h"
#import "WBAccount.h"

@implementation WBBaseParam

+(instancetype)param
{
    WBBaseParam *param = [[self alloc] init];
    
    param.access_token = [WBAccountTool account].access_token;
    
    return param;
}
@end
