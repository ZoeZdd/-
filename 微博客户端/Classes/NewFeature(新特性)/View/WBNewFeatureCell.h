//
//  WBNewFeatureCell.h
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/29.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBNewFeatureCell : UICollectionViewCell
@property (nonatomic,strong) UIImage *image;

// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end
