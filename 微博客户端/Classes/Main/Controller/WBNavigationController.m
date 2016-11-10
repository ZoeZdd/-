//
//  WBNavigationController.m
//  微博项目
//
//  Created by 庄丹丹 on 16/7/20.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBNavigationController.h"
#import "UIBarButtonItem+Item.h"

#import "WBTabBar.h"

@interface WBNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) id popDelgate;
@end

@implementation WBNavigationController

+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 保存滑动返回手势代理的值
    _popDelgate = self.interactivePopGestureRecognizer.delegate;
    
    
    self.delegate = self;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count != 0) { //不是根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航条的按钮 左边 右边
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];

        // 设置导航条的按钮 左边
        viewController.navigationItem.leftBarButtonItem = left;
        
        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置导航条的按钮 右边
        viewController.navigationItem.rightBarButtonItem = right;
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}

- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

#pragma mark -- UINavigationController代理
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) { // 是根控制器
        // 还原滑动返回手势的代理
        self.interactivePopGestureRecognizer.delegate = _popDelgate;
        
    }else{ // 不是根控制器
        // 实现滑动返回功能
        // 清空滑动返回手势的代理,就会实现滑动功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

// 导航控制器即将显示新的控制器的时候调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)WBKeyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[WBTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

@end
























