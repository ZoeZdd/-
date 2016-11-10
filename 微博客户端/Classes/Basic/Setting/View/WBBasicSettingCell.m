//
//  WBBasicSettingCell.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/4.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBBasicSettingCell.h"

#import "WBSettingItem.h"
#import "WBArrowItem.h"
#import "WBSwitchItem.h"
#import "WBCheakItem.h"
#import "WBBadgeItem.h"
#import "WBLabelItem.h"
#import "WBBadgeView.h"

@interface WBBasicSettingCell ()

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIImageView *cheakView;
@property (nonatomic, strong) WBBadgeView *badgeView;
@property (nonatomic, weak) UILabel *labelView;


@end
@implementation WBBasicSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UILabel *)labelView
{
    if (!_labelView) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.width = WBScreenW;
        _labelView = label;
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
        [self addSubview:_labelView];
    }
    return _labelView;
}

-(WBBadgeView *)badgeView
{
    if (!_badgeView) {
        _badgeView = [[WBBadgeView alloc] init];
    }
    return _badgeView;
}

-(UIImageView *)arrowView
{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
        
    }
    return _arrowView;
}

-(UISwitch *)switchView
{
    if (!_switchView) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (UIImageView *)cheakView
{
    if (!_cheakView) {
        _cheakView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _cheakView;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    WBBasicSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
    }
    return cell;
}

-(void)setItem:(WBSettingItem *)item
{
    _item = item;
    
    // 设置数据
    [self setUpData];
    // 设置模型
    [self setUpRightView];
    
}

- (void)setUpData{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    self.imageView.image = _item.image;
}

-(void)setUpRightView
{
    if ([_item isKindOfClass:[WBArrowItem class]]) { // 箭头
        self.accessoryView = self.arrowView;
    }else if ([_item isKindOfClass:[WBSwitchItem class]]){ // 开关
        self.accessoryView = self.switchView;
        WBSwitchItem  *switchItem = (WBSwitchItem *)_item;
        self.switchView.on = switchItem.on;
    }else if ([_item isKindOfClass:[WBCheakItem class]]){ // 打钩
        WBCheakItem *badgeItem = (WBCheakItem *)_item;
        if (badgeItem.cheak) {
            self.accessoryView = self.cheakView;
        }else{
            self.accessoryView = nil;
        }
    }else if ([_item isKindOfClass:[WBBadgeItem class]]){
        WBBadgeItem *badgeItem = (WBBadgeItem *)_item;
        WBBadgeView *badge = self.badgeView;
        self.accessoryView = badge;
        badge.badgeValue = badgeItem.badgeValue;
    }else if ([_item isKindOfClass:[WBLabelItem class]]){
        WBLabelItem *labelItem = (WBLabelItem *)_item;
        UILabel *label = self.labelView;
        label.text = labelItem.text;
        
    }else{ // 没有
        self.accessoryView = nil;
        [_labelView removeFromSuperview];
        _labelView = nil;
    }

}

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(NSUInteger)count
{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selBgView = (UIImageView *)self.selectedBackgroundView;
    if (count == 1) { // 只有一行
        bgView.image = [UIImage imageWithStretchableName:@"common_card_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_background_highlighted"];
        
    }else if(indexPath.row == 0){ // 顶部cell
        bgView.image = [UIImage imageWithStretchableName:@"common_card_top_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_top_background_highlighted"];
        
    }else if (indexPath.row == count - 1){ // 底部
        bgView.image = [UIImage imageWithStretchableName:@"common_card_bottom_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_bottom_background_highlighted"];
        
    }else{ // 中间
        bgView.image = [UIImage imageWithStretchableName:@"common_card_middle_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_middle_background_highlighted"];
    }
    
}

- (void)switchChange:(UISwitch *)switchView
{
    
    WBSwitchItem *switchItem = (WBSwitchItem *)_item;
    switchItem.on = switchView.on;
    
}

@end


































