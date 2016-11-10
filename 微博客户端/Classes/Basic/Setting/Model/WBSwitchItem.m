//
//  WBSwitchItem.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/4.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBSwitchItem.h"

@implementation WBSwitchItem

- (void)setOn:(BOOL)on
{
    _on = on;
    
    // 数据存储
    [WBUserDefaults setBool:on forKey:self.title];
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    self.on = [WBUserDefaults boolForKey:title];
}
@end
