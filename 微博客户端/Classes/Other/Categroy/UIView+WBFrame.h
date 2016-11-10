//
//  UIView+WBFrame.h
//  微博项目
//
//  Created by 庄丹丹 on 16/7/20.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WBFrame)

// 分类不能添加成员属性
// @property如果在分类里，只会生成成员变量get和set方法的声明，不会生成成员变量属性和方法的实现
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

@end
