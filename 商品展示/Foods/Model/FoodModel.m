//
//  FoodModel.m
//  商品展示
//
//  Created by 庄丹丹 on 16/10/17.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "FoodModel.h"

@implementation CategoryModel

+ (NSDictionary *)objectClassInArray
{
    return @{@"spus": @"FoodModel"};
}

@end
@implementation FoodModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"foodId": @"id" };
}

@end
