//
//  WBPhotoView.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/2.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBPhotoView.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"

@interface WBPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation WBPhotoView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;
        // 裁剪图片,超出空间的部分裁剪
        self.clipsToBounds = YES;
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
        
    }
    return self;
}

-(void)setPhoto:(WBPhoto *)photo
{
    _photo = photo;
    
    // 赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 判断下是否显示GIF
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
        
    }else{
        self.gifView.hidden = YES;
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}
@end
