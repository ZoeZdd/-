//
//  WBSettingViewController.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/4.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBSettingViewController.h"

#import "WBBadgeItem.h"
#import "WBArrowItem.h"
#import "WBGroupItem.h"
#import "WBLabelItem.h"

#import "WBCommonSettingViewController.h"

@interface WBSettingViewController ()

@end

@implementation WBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
}

- (void)setUpGroup0
{
    // 账号管理
    WBBadgeItem *account = [WBBadgeItem itemWithTitle:@"账号管理"];
    account.badgeValue = @"8";
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[account];
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    // 提醒和通知
    WBArrowItem *notice = [WBArrowItem itemWithTitle:@"我的相册" ];
    // 通用设置
    WBArrowItem *setting = [WBArrowItem itemWithTitle:@"通用设置" ];
    setting.descVc = [WBCommonSettingViewController class];
    // 隐私与安全
    WBArrowItem *secure = [WBArrowItem itemWithTitle:@"隐私与安全" ];
    
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[notice,setting,secure];
    [self.groups addObject:group];
}

- (void)setUpGroup2{
    // 意见反馈
    WBArrowItem *suggest = [WBArrowItem itemWithTitle:@"意见反馈" ];
    // 关于微博
    WBArrowItem *about = [WBArrowItem itemWithTitle:@"关于微博"];
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[suggest,about];
    [self.groups addObject:group];
}

- (void)setUpGroup3
{
    // 账号管理
    WBLabelItem *layout = [[WBLabelItem alloc] init];
    layout.text = @"退出当前账号";
    
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[layout];
    [self.groups addObject:group];
}


@end
