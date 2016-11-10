//
//  WBQualityViewController.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/4.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBQualityViewController.h"
#import "WBGroupItem.h"
#import "WBCheakItem.h"
#import "WBProfileCell.h"

@interface WBQualityViewController ()

@property (nonatomic, strong) WBCheakItem *selUploadItem;
@property (nonatomic, strong) WBCheakItem *selDoloadItem;
@end

@implementation WBQualityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加第0组
    [self setUpGroup0];
    
    // 添加第1组
    [self setUpGroup1];
}

- (void)setUpGroup0
{
    // 高清
    WBCheakItem *high = [WBCheakItem itemWithTitle:@"高清"];
    high.subTitle = @"建议在Wifi或3G网络使用";
    __weak typeof(self) vc = self;
    high.option = ^{
        [vc selUploadItem:high];
    };
    
    // 普通
    WBCheakItem *normal = [WBCheakItem itemWithTitle:@"普通"];
    normal.subTitle = @"上传速度快，省流量";
    
    normal.option = ^{
        [vc selUploadItem:normal];
    };
    
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.headerTitle = @"上传图片质量";
    group.items = @[high,normal];
    [self.groups addObject:group];
    
    // 默认选中第0组的一行
    NSString *upload = [WBUserDefaults objectForKey:WBSelUploadKey];
    if (upload == nil) {
        [self selUploadItem:high];
        return;
    }
    for (WBCheakItem *item in group.items) {
        if ([item.title isEqualToString:upload]) {
            [self selUploadItem:item];
        }
    }
    
}


- (void)setUpGroup1
{
    // 高清
    WBCheakItem *high = [WBCheakItem itemWithTitle:@"高清"];
    high.subTitle = @"建议在Wifi或3G网络使用";
    __weak typeof(self) vc = self;
    high.option = ^{
        [vc selDoloadItem:high];
        
    };
    
    // 普通
    WBCheakItem *normal = [WBCheakItem itemWithTitle:@"普通"];
    normal.subTitle = @"下载速度快，省流量";
    normal.option = ^{
        [vc selDoloadItem:normal];
    };
    
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.headerTitle = @"下载图片质量";
    group.items = @[high,normal];
    [self.groups addObject:group];
    
    // 默认选中第0组的一行
    NSString *downLoad = [WBUserDefaults objectForKey:WBSelDownloadKey];
    if (downLoad == nil) {
        [self selDoloadItem:high];
        return;
    }
    
    for (WBCheakItem *item in group.items) {
        if ([item.title isEqualToString:downLoad]) {
            [self selDoloadItem:item];
        }
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBProfileCell *cell = [WBProfileCell cellWithTableView:tableView];
    
    // 获取模型
    WBGroupItem *groupItem = self.groups[indexPath.section];
    WBSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];
    return cell;
}
- (void)selUploadItem:(WBCheakItem *)item
{
    _selUploadItem.cheak = NO;
    item.cheak = YES;
    _selUploadItem = item;
    [self.tableView reloadData];
    
    // 数据存储
    [WBUserDefaults setObject:item.title forKey:WBSelUploadKey];
    [WBUserDefaults synchronize];
}

- (void)selDoloadItem:(WBCheakItem *)item
{
    _selDoloadItem.cheak = NO;
    item.cheak = YES;
    _selDoloadItem = item;
    [self.tableView reloadData];
    
    // 数据存储
    [WBUserDefaults setObject:item.title forKey:WBSelDownloadKey];
    [WBUserDefaults synchronize];
}

@end
