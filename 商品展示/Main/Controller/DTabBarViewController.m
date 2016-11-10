//
//  DTabBarViewController.m
//  商品展示
//
//  Created by 庄丹丹 on 16/10/17.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "DTabBarViewController.h"
#import "DNavigationViewController.h"
#import "DFoodsViewController.h"
#import "DGoodsViewController.h"

@interface DTabBarViewController ()

@end

@implementation DTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置tabbar的背景色
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = rgb(249, 249, 249);
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
    
    
    // 食品
    DFoodsViewController *foodsVC = [[DFoodsViewController alloc] init];
    [self addChildViewController:foodsVC title:@"食品" image:@"tabbar_icon_news_normal" selectImage:@"tabbar_icon_news_highlight"];
    
    // 商品
    DGoodsViewController *goodsVC = [[DGoodsViewController alloc] init];
    [self addChildViewController:goodsVC title:@"商品" image:@"farming_normal" selectImage:@"farming_pressed"];
    
}

/**
 *  添加控制器到TabBar
 *
 *  @param childController 子控制器
 *  @param title           标题
 *  @param imageName       图片
 *  @param selectImageName 选中图片
 */
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)imageName selectImage:(NSString *)selectImageName {
    //  设置样式
    childController.tabBarItem.title                 = title;//设置tabBar的文字
    childController.navigationItem.title             = @"SHOW";//设置navigationBar的文字
    childController.tabBarItem.image                 = [UIImage imageNamed:imageName];
    //  显示原图
    childController.tabBarItem.selectedImage         = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //  设置不同状态下字体样式
    NSMutableDictionary * textAttr                   = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName]         = [UIColor blackColor];
    [childController.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    //  选中文字样式
    NSMutableDictionary * selectedTextAttr           = [NSMutableDictionary dictionary];
    selectedTextAttr[NSForegroundColorAttributeName] = rgb(220, 0, 15);
    [childController.tabBarItem setTitleTextAttributes:selectedTextAttr forState:UIControlStateSelected];
    
    //  包涵导航栏控制器
    DNavigationViewController *navigation           = [[DNavigationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:navigation];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
