//
//  WBFontSizeViewController.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/4.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBFontSizeViewController.h"
#import "WBGroupItem.h"
#import "WBCheakItem.h"

@interface WBFontSizeViewController ()
@property (nonatomic, strong) WBCheakItem *selCheakItem;

@end

@implementation WBFontSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加第0组
    [self setUpGroup0];
}

- (void)setUpSelItem:(WBCheakItem *)item
{
    NSString *fontSizeStr =  [WBUserDefaults objectForKey:WBFontSizeKey];
    if (fontSizeStr == nil) {
        [self selItem:item];
        return;
    }
    
    for (WBGroupItem *group in self.groups) {
        for (WBCheakItem *item in group.items) {
            if ( [item.title isEqualToString:fontSizeStr]) {
                [self selItem:item];
            }
            
        }
        
    }
}

- (void)setUpGroup0
{
    
    
    // 大
    WBCheakItem *big = [WBCheakItem itemWithTitle:@"大"];
    __weak typeof(self) vc = self;
    big.option = ^{
        [vc selItem:big];
    };
    
    // 中
    WBCheakItem *middle = [WBCheakItem itemWithTitle:@"中"];
    
    middle.option = ^{
        [vc selItem:middle];
    };
    _selCheakItem = middle;
    // 小
    WBCheakItem *small = [WBCheakItem itemWithTitle:@"小"];
    small.option = ^{
        [vc selItem:small];
    };
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.headerTitle = @"上传图片质量";
    group.items = @[big,middle,small];
    [self.groups addObject:group];
    
    // 默认选中item
    [self setUpSelItem:middle];
    
}

- (void)selItem:(WBCheakItem *)item
{
    _selCheakItem.cheak = NO;
    item.cheak = YES;
    _selCheakItem = item;
    [self.tableView reloadData];
    
    
    // 存储
    [WBUserDefaults setObject:item.title forKey:WBFontSizeKey];
    [WBUserDefaults synchronize];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:WBFontSizeChangeNote object:nil userInfo:@{WBFontSizeKey:item.title}];
    
}

@end
