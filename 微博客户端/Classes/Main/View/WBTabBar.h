//
//  WBTabBar.h
//  微博项目
//
//  Created by 庄丹丹 on 16/7/18.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTabBar;
@protocol WBTabBarDelegate <NSObject>

@optional
- (void)tabBar:(WBTabBar *)tabBar didClickButton:(NSInteger)index;

// 点击➕按钮的时候调用
- (void)tabBarDidClickPlusButton:(WBTabBar *)tabBar;

@end
@interface WBTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<WBTabBarDelegate> delegate;

@end
