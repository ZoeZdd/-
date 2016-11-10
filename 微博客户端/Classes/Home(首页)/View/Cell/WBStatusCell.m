//
//  WBStatusCell.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/31.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBOriginalView.h"
#import "WBRetweetView.h"
#import "WBStatusToolBar.h"

#import "WBStatusFrame.h"
#import "WBStatus.h"

@interface WBStatusCell ()

@property (nonatomic, weak) WBOriginalView *originalView;
@property (nonatomic, weak) WBRetweetView *retweetView;
@property (nonatomic, weak) WBStatusToolBar *statusToolBar;


@end

@implementation WBStatusCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 添加所有子控件
- (void)setUpAllChildView
{
    // 原创微博
    WBOriginalView *originalView = [[WBOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    // 转发微博
    WBRetweetView *retweetView = [[WBRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    // 工具条
    WBStatusToolBar *statusToolBar = [[WBStatusToolBar alloc] init];
    [self addSubview:statusToolBar];
    _statusToolBar = statusToolBar;
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
    return cell;

}

/*
         解决:MVVM思想
         M:模型
         V:视图
         VM:视图模型（模型包装视图模型，模型+模型对应视图的frame）
 */

- (void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 计算每个子控件的位置
    // 赋值
    
    // 设置原创微博frame
    _originalView.frame = statusFrame.originalViewFrame;
    _originalView.statusFrame = statusFrame;
    
    if (statusFrame.status.retweeted_status) {
        // 设置转发微博frame
        _retweetView.frame = statusFrame.retweetViewFrame;
        _retweetView.statusFrame = statusFrame;
        _retweetView.hidden = NO;

    }else{
        _retweetView.hidden = YES;
    }
    
    
    // 设置工具条frame
    _statusToolBar.frame = statusFrame.statusToolBarFrame;
    _statusToolBar.status = statusFrame.status;
    
}
@end










