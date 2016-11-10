//
//  WBRetweetView.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/31.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBRetweetView.h"
#import "WBStatus.h"
#import "WBStatusFrame.h"
#import "WBPhotosView.h"

@interface WBRetweetView ()

// 昵称
@property (nonatomic, weak) UILabel *nameView;

// 正文
@property (nonatomic, weak) UILabel *textView;

// 配图
@property (nonatomic, weak) WBPhotosView *photosView;

@end
@implementation WBRetweetView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    
    return self;
}

- (void)setUpAllChildView
{
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = WBNameFont;
    [self addSubview:nameView];
    _nameView = nameView;

    
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
    
    WBStatus *status = statusFrame.status;
    
    // 昵称
    _nameView.frame = statusFrame.retweetNameFrame;
//    _nameView.text = status.retweeted_status.user.name;
    _nameView.text = status.retweetName;
    _nameView.textColor = [UIColor colorWithRed:25/255.0 green:160/255.0 blue:205/255.0 alpha:1];
    
    // 正文
    _textView.frame = statusFrame.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
    
    // 配图
    _photosView.frame = statusFrame.retweetPhotosFrame;
    _photosView.pic_urls = status.retweeted_status.pic_urls;
}
@end
