//
//  WBSettingItem.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/4.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBSettingItem.h"

@implementation WBSettingItem


+(instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image
{
    WBSettingItem *item = [[self alloc] init];
    item.title = title;
    item.image = image;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    WBSettingItem *item = [self itemWithTitle:title image:nil];
    return item;
}

@end
