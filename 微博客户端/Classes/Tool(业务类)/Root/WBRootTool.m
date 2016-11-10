//
//  WBRootTool.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/29.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBRootTool.h"

#import "WBTabBarController.h"
#import "WBNewFeatureControllerViewController.h"

#define WBVersionKey @"version"
@implementation WBRootTool
// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window
{
    // 1.获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:WBVersionKey];
    
    // 判断当前是否有新版本
    if ([currentVersion isEqualToString:lastVersion]) { // 没有新的版本号
        // 创建tabBarVc
        WBTabBarController *tabBarVc = [[WBTabBarController alloc] init];
        
        // 设置窗口的根控制器
        window.rootViewController = tabBarVc;
    }else{ // 有新的版本号
        // 如果有新特性,进入新特性界面
        WBNewFeatureControllerViewController *newFeatureControllerVC = [[WBNewFeatureControllerViewController alloc] init];
        
        window.rootViewController = newFeatureControllerVC;
        
        // 保存当前的版本号到 偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:WBVersionKey];
        
        
    }
}
    
@end
