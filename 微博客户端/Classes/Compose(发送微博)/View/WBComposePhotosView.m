//
//  WBComposePhotosView.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/3.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBComposePhotosView.h"

@implementation WBComposePhotosView

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

// 每添加一个子控件的时候也会调用,特殊:如果在viewDidLoad中添加子控件,就不会调用layoutSubviews
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat margin = 10;
    CGFloat wh = ( self.width - (cols + 1) * margin ) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (margin + wh) + margin;
        y = row * (margin + wh) + margin;
        imageView.frame = CGRectMake(x, y, wh, wh);
    }
    
}
@end
