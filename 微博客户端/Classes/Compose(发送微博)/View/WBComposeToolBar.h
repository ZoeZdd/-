//
//  WBComposeToolBar.h
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/3.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBComposeToolBar;
@protocol WBComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(WBComposeToolBar *)composeToolBar didClickBtn:(NSInteger)index;

@end
@interface WBComposeToolBar : UIView

@property (nonatomic,weak) id<WBComposeToolBarDelegate> delegate;
@end
