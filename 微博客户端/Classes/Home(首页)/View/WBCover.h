//
//  WBCover.h
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/28.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBCover;
@protocol WBCoverDelegate <NSObject>

@optional
// 点击蒙版的时候调用
- (void)coverDidClickCover:(WBCover *)cover;

@end
@interface WBCover : UIView
/**
 *  显示蒙板
 */
+ (instancetype)show;

// 设置浅灰色蒙板
@property (nonatomic, assign) BOOL dimBackground;

@property (nonatomic, weak) id<WBCoverDelegate> delegate;
@end
