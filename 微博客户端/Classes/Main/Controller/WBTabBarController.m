//
//  WBTabBarController.m
//  微博项目
//
//  Created by 庄丹丹 on 16/7/18.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBTabBarController.h"
#import "UIImage+WBImage.h"
#import "WBTabBar.h"

#import "WBHomeViewController.h"
#import "WBMessageViewController.h"
#import "WBDiscoverViewController.h"
#import "WBProfileViewController.h"

#import "WBNavigationController.h"

#import "WBUserTool.h"
#import "WBUserResult.h"

#import "WBComposeViewController.h"

@interface WBTabBarController ()<WBTabBarDelegate>
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) WBHomeViewController *home;
@property (nonatomic, weak) WBMessageViewController *message;
@property (nonatomic, weak) WBDiscoverViewController *discover;
@property (nonatomic, weak) WBProfileViewController *profile;
@end

@implementation WBTabBarController
- (NSMutableArray *)items
{
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加子控制器
    [self setUpAllChildViewController];
   
    // 自定义tabBar
    [self setUpTabBar];

    // 每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
}

#pragma mark - 请求微博未读数
- (void)requestUnread
{
    // 请求微博未读数
    [WBUserTool unreadWithSuccess:^(WBUserResult *result) {
        // 设置首页的未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        
        // 设置消息的未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        
        //设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        // 设置应用程序的所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    // 自定义tabBar
    WBTabBar *tabBar = [[WBTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    // 添加自定义tabBar
    [self.tabBar addSubview:tabBar];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    }

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(WBTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) { // 点击首页
        [_home refresh];
    }
    self.selectedIndex = index;
}

// 点击➕按钮的时候调用
-(void)tabBarDidClickPlusButton:(WBTabBar *)tabBar
{
    // 创建发送微博控制器
    WBComposeViewController *composeVC = [[WBComposeViewController alloc] init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark --添加所有的子控制器
-(void)setUpAllChildViewController{
    
    // 首页
    WBHomeViewController *home = [[WBHomeViewController alloc] init];
    [self setUpOneChildViewController:home imageName:[UIImage imageNamed:@"tabbar_home"] selImageName:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    self.home = home;
    // 消息
    WBMessageViewController *message = [[WBMessageViewController alloc] init];
    [self setUpOneChildViewController:message imageName:[UIImage imageNamed:@"tabbar_message_center"] selImageName:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    self.message = message;
    
    // 发现
    WBDiscoverViewController *discover = [[WBDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover imageName:[UIImage imageNamed:@"tabbar_discover"] selImageName:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    self.discover = discover;
    
    // 我
    WBProfileViewController *profile = [[WBProfileViewController alloc] init];
    [self setUpOneChildViewController:profile imageName:[UIImage imageNamed:@"tabbar_profile"] selImageName:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    self.profile = profile;
}

#pragma mark --添加一个子控制器
-(void)setUpOneChildViewController:(UIViewController *)vc imageName:(UIImage *)imageName selImageName:(UIImage *)selImageName title:(NSString *)title
{
//    vc.tabBarItem.title = title;
    vc.tabBarItem.image = imageName;
    vc.tabBarItem.selectedImage = selImageName;
    vc.title = title;
//    vc.tabBarItem.badgeValue = @"10000";
   
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}


@end
