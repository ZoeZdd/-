//
//  WBBasicSettingViewController.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/4.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBBasicSettingViewController.h"
#import "WBBasicSettingCell.h"
#import "WBGroupItem.h"
#import "WBSettingItem.h"
#import "WBArrowItem.h"

@interface WBBasicSettingViewController ()

@end

@implementation WBBasicSettingViewController
-(instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = WBColor(247, 247, 247 );
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    WBGroupItem *groupItem = self.groups[section];
    return groupItem.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBBasicSettingCell *cell = [WBBasicSettingCell cellWithTableView:tableView];
    
    // 获取模型
    WBGroupItem *groupItem = self.groups[indexPath.section];
    WBSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];
   
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    WBGroupItem *groupItem = self.groups[section];
    return groupItem.headerTitle;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    WBGroupItem *groupItem = self.groups[section];
    return groupItem.footerTitle;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取模型
    WBGroupItem *groupItem = self.groups[indexPath.section];
    WBSettingItem *item = groupItem.items[indexPath.row];
    
    if (item.option) {
        item.option();
        return;
    }
    
    if (item.descVc) {
        UIViewController *vc = [[item.descVc alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
