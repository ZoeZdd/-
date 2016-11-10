//
//  WBOriginalView.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/31.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBOriginalView.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBPhotosView.h"

#import "UIImageView+WebCache.h"

@interface WBOriginalView ()

// 头像
@property (nonatomic, weak) UIImageView *iconView;

// 昵称
@property (nonatomic, weak) UILabel *nameView;

// vip
@property (nonatomic, weak) UIImageView *vipView;

// 时间
@property (nonatomic, weak) UILabel *timeView;

// 来源
@property (nonatomic, weak) UILabel *sourceView;

// 正文
@property (nonatomic, weak) UILabel *textView;

// 配图
@property (nonatomic, weak) WBPhotosView *photosView;

@end

@implementation WBOriginalView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
    }
    
    return self;
}

#pragma mark - 添加所有子控件
- (void)setUpAllChildView
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = WBNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = WBTimeFont;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = WBSourceFont;
    sourceView.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = WBTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    // 配图
    WBPhotosView *photosView = [[WBPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
    
}

-(void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 设置子控件frame
    [self setUpFrame];
    
    // 设置子控件data
    [self setUpData];
    
}

#pragma mark - 设置子控件frame
- (void)setUpFrame
{
    // 头像
    _iconView.frame = _statusFrame.originalIconFrame;
    
    // 昵称
    _nameView .frame = _statusFrame.originalNameFrame;
    
    // vip
    if (_statusFrame.status.user.vip) { // 是vip
        _vipView.frame = _statusFrame.originalVipFrame;
        _vipView.hidden = NO;
    }else{
        _vipView.hidden = YES;
    }
    
    // 时间
//    _timeView.frame = _statusFrame.originalTimeFrame;
    
    // 来源
//    _sourceView.frame = _statusFrame.originalSourceFrame;
    
    // 取模型数据
    WBStatus *status = _statusFrame.status;
    // 时间    每次有新的时间都需要重新计算
    CGFloat timeX = _nameView .frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView .frame) + WBStatusCellMargin * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:WBTimeFont];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + WBStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:WBSourceFont];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 正文
    _textView.frame = _statusFrame.originalTextFrame;
    
    // 配图
    _photosView.frame = _statusFrame.originalPhotosFrame;
    
}

#pragma mark - 设置子控件data
- (void)setUpData
{
    // 取模型数据
    WBStatus *status = _statusFrame.status;
    
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    _vipView.image = image;
    
    // 时间
    _timeView.text = status.created_at;
    
    // 来源
    _sourceView.text = status.source;
    
    // 正文
    _textView.text = status.text;
    
    // 配图
    _photosView.pic_urls = status.pic_urls;
    
}
@end



















