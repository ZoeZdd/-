//
//  WBNewFeatureCell.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/29.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBNewFeatureCell.h"
#import "WBTabBarController.h"

@interface WBNewFeatureCell ()
@property (nonatomic,weak) UIImageView *imageView;

@property (nonatomic,weak) UIButton *shareButton;

@property (nonatomic,weak) UIButton *startButton;


@end
@implementation WBNewFeatureCell

-(UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        // 一定要加在contentView
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
// 分享按钮
-(UIButton *)shareButton
{
    if (!_shareButton) {
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
        [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [shareButton sizeToFit];
        
        [self.contentView addSubview:shareButton];
        
        _shareButton = shareButton;
        
    }
    return _shareButton;
}
-(void)share:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
}
// 开始按钮
-(UIButton *)startButton
{
    if (!_startButton) {
        UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
        [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startButton sizeToFit];
        [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startButton];
        _startButton = startButton;
    }
    return _startButton;
}

// 布局子控件的frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    // 滚动图片
    self.imageView.frame = self.bounds;
    
    // 分享按钮
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    
    // 开始按钮
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

// 判断当前cell是否是最后一页
-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1) { // 最后一页,显示分享和开始按钮
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    }else{  // 非最后一页，隐藏分享和开始按钮
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}
// 点击开始微博的时候调用
- (void)start
{
    // 进入tabBarVc
    WBTabBarController *tabBarVc = [[WBTabBarController alloc] init];
    
    // 切换根控制器:可以直接把之前的根控制器清空
    WBKeyWindow.rootViewController = tabBarVc;
}


@end
