//
//  WBStatusFrame.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/31.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//
// 模型 + 对应控件的frame

#import "WBStatusFrame.h"
#import "WBStatus.h"


@implementation WBStatusFrame
-(void)setStatus:(WBStatus *)status
{
    _status = status;
    
    // 计算原创微博
    [self setUpoRiginalViewFrame];
    
    CGFloat statusToolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        // 计算转发微博
        [self setUpRetweetViewFrame];
        
        statusToolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    
    // 计算工具条
    CGFloat statusToolBarX = 0;
    CGFloat statusToolBarW = WBScreenW;
    CGFloat statusToolBarH = 35;
    _statusToolBarFrame = CGRectMake(statusToolBarX, statusToolBarY, statusToolBarW, statusToolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_statusToolBarFrame);
}

#pragma mark - 计算原创微博
- (void)setUpoRiginalViewFrame
{
    // 头像
    CGFloat imageX = WBStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
 
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + WBStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:WBNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + WBStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    
//    // 时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + WBStatusCellMargin * 0.5;
//    CGSize timeSize = [_status.created_at sizeWithFont:WBTimeFont];
//    _originalTimeFrame = (CGRect){{timeX,timeY},timeSize};
//    
//    // 来源
//    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + WBStatusCellMargin;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [_status.source sizeWithFont:WBSourceFont];
//    _originalSourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + WBStatusCellMargin;
    
    CGFloat textW = WBScreenW - 2 * WBStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:WBTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + WBStatusCellMargin;

    
    // 配图
    if (_status.pic_urls.count) {
        CGFloat photosX = WBStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + WBStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + WBStatusCellMargin;
    }

    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = WBScreenW;
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    

}

#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    int cols = count == 4? 2 : 3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = (WBScreenW - 4 * WBStatusCellMargin) / 3;
    CGFloat w = cols * photoWH + (cols - 1) * WBStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * WBStatusCellMargin;
    
    
    return CGSizeMake(w, h);
    
}


#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = WBStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweetName sizeWithFont:WBNameFont];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + WBStatusCellMargin;
    
    CGFloat textW = WBScreenW - 2 * WBStatusCellMargin;
    // 注意：一定要是转发微博的正文
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:WBTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + WBStatusCellMargin;

    // 配图
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = WBStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + WBStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + WBStatusCellMargin;
    }

    
    // 原创微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = WBScreenW;
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);

}
@end
