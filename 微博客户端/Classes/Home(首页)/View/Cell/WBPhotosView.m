//
//  WBPhotosView.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/31.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBPhotosView.h"
#import "WBPhoto.h"
#import "UIImageView+WebCache.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "WBPhotoView.h"

@implementation WBPhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        // 添加9个子控件
        
        [self setUpAllChildView];
    }
    return self;
}

#pragma mark -- 添加9个子控件
- (void)setUpAllChildView
{
    for (int i = 0; i < 9; i++) {
        WBPhotoView *imageView = [[WBPhotoView alloc] init];
        imageView.tag = i;
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        
        [self addSubview:imageView];
    }
}

#pragma mark - 点击图片的时候调用
- (void)tap:(UITapGestureRecognizer *)tap
{
    
    UIImageView *tapView = tap.view;
    
    // WBPhoto - >  MJPhoto
    
    int i = 0;
    NSMutableArray *photoArrM = [NSMutableArray array];
    for (WBPhoto *photo in _pic_urls) {
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjPhoto.url = [NSURL URLWithString:urlStr];
        mjPhoto.index = i;
        i++;
        mjPhoto.srcImageView = tapView;
        [photoArrM addObject:mjPhoto];
    }
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc] init];
    photoBrowser.photos = photoArrM;
    photoBrowser.currentPhotoIndex = tapView.tag;

    [photoBrowser show];
}
-(void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    int count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        WBPhotoView *imageView = self.subviews[i];
        
        if (i < _pic_urls.count) { // 显示
            imageView.hidden = NO;
            // 获取WBPhoto模型
            WBPhoto *photo = _pic_urls[i];
            
            imageView.photo = photo;

        }else{
            imageView.hidden = YES;
        }
        
        
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat margin = 10;
    CGFloat w = (WBScreenW - 4 * margin) / 3 ;
    CGFloat h = w;
    
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
    // 计算显示出来的imageview
    for (int i = 0; i < 9; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageView  = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageView.frame = CGRectMake(x, y, w, h);
    }
    
}
@end






















