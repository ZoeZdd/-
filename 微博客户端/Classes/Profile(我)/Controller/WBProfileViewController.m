//
//  WBProfileViewController.m
//  微博项目
//
//  Created by 庄丹丹 on 16/7/19.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBProfileViewController.h"
#import "WBGroupItem.h"
#import "WBArrowItem.h"
#import "WBProfileCell.h"
#import "WBSettingViewController.h"

@interface WBProfileViewController ()

@property(nonatomic, weak) UIBarButtonItem *settingBtn;

@end

@implementation WBProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // 设置导航条item
    [self setUpNav];
    
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
    
}
#pragma mark -- 设置导航条item
- (void)setUpNav
{
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    _settingBtn = setting;
    self.navigationItem.rightBarButtonItem = setting;
}
#pragma mark -- 点击设置的时候调用
- (void)setting{
    WBSettingViewController *settingVc = [[WBSettingViewController alloc] init];
    settingVc.title = _settingBtn.title;
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - 添加组
- (void)setUpGroup0
{
    // 新的好友
    WBArrowItem *friend = [WBArrowItem itemWithTitle:@"新的好友" image:[UIImage imageNamed:@"new_friend"]];
    
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[friend];
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    // 我的相册
    WBArrowItem *album = [WBArrowItem itemWithTitle:@"我的相册" image:[UIImage imageNamed:@"album"]];
    album.subTitle = @"(12)";
    
    // 我的收藏
    WBArrowItem *collect = [WBArrowItem itemWithTitle:@"我的收藏" image:[UIImage imageNamed:@"collect"]];
    collect.subTitle = @"(0)";
    
    // 赞
    WBArrowItem *like = [WBArrowItem itemWithTitle:@"赞" image:[UIImage imageNamed:@"like"]];
    like.subTitle = @"(0)";
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[album,collect,like];
    [self.groups addObject:group];

}

- (void)setUpGroup2
{
    // 微博支付
    WBArrowItem *pay = [WBArrowItem itemWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    // 个性化
    WBArrowItem *vip = [WBArrowItem itemWithTitle:@"个性化" image:[UIImage imageNamed:@"vip"]];
    vip.subTitle = @"微博来源、皮肤、封面图";
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[pay,vip];
    [self.groups addObject:group];

}

- (void)setUpGroup3
{
    // 我的二维码
    WBArrowItem *card = [WBArrowItem itemWithTitle:@"我的二维码" image:[UIImage imageNamed:@"card"]];
    // 草稿箱
    WBArrowItem *draft = [WBArrowItem itemWithTitle:@"草稿箱" image:[UIImage imageNamed:@"draft"]];
    
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[card,draft];
    [self.groups addObject:group];
}



#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WBProfileCell *cell = [WBProfileCell cellWithTableView:tableView];
    
    // 获取模型
    WBGroupItem *groupItem = self.groups[indexPath.section];
    WBSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];

    
        
    return cell;
}



@end
