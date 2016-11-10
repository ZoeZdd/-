//
//  UIImage+WBImage.m
//  微博项目
//
//  Created by 庄丹丹 on 16/7/18.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "UIImage+WBImage.h"

@implementation UIImage (WBImage)
// 加载最原始的图片
+(instancetype)imageWithOriginalName:(NSString *)ImageName
{
    UIImage *selImage = [UIImage imageNamed:ImageName];
    return [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
