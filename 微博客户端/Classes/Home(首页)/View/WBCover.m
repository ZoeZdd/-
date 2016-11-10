//
//  WBCover.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/28.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBCover.h"

@implementation WBCover

// 设置浅灰色蒙板
-(void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    if (dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
    }
}

// 显示蒙板
+(instancetype)show
{
    WBCover *cover = [[WBCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    [WBKeyWindow addSubview:cover];
    return cover;
}

// 点击蒙板的时候做事情
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 移除蒙板
    [self removeFromSuperview];
    
    // 通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        [_delegate coverDidClickCover:self];
    }
}
@end
