//
//  DRightTableViewCell.h
//  商品展示
//
//  Created by 庄丹丹 on 16/10/17.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

#define dCellIdentifier_Right @"RightTableViewCell"

@class FoodModel;

@interface DRightTableViewCell : UITableViewCell

@property (nonatomic,strong) FoodModel *foodModel;
@end
