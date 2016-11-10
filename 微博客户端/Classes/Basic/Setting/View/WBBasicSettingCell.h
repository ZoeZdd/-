//
//  WBBasicSettingCell.h
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/4.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBSettingItem;

@interface WBBasicSettingCell : UITableViewCell

@property (nonatomic,strong) WBSettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(NSUInteger)rowCount;
@end
