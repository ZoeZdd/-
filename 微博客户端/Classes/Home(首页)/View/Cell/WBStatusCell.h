//
//  WBStatusCell.h
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/31.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatusFrame;
@interface WBStatusCell : UITableViewCell

@property (nonatomic,strong) WBStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
