//
//  UIImage+WBImage.h
//  微博项目
//
//  Created by 庄丹丹 on 16/7/18.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WBImage)
// 加载最原始的图片
+(instancetype)imageWithOriginalName:(NSString *)ImageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end
