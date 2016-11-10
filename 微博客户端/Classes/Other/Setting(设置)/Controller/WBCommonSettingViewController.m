//
//  WBCommonSettingViewController.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/4.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBCommonSettingViewController.h"

#import "WBArrowItem.h"
#import "WBSwitchItem.h"
#import "WBGroupItem.h"

#import "WBFontSizeViewController.h"
#import "WBQualityViewController.h"
#import "UIImageView+WebCache.h"
@interface WBCommonSettingViewController ()
@property (nonatomic, weak) WBSettingItem *fontSize;
@end

@implementation WBCommonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
    // 添加第4组
    [self setUpGroup4];

    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSizeChange:) name:WBFontSizeChangeNote object:nil];
}

- (void)fontSizeChange:(NSNotification *)notication
{
    _fontSize.subTitle = notication.userInfo[WBFontSizeKey];
    // WBLog(@"%@",notication);
    [self.tableView reloadData];
}

- (void)setUpGroup0
{
    // 阅读模式
    WBSettingItem *read = [WBSettingItem itemWithTitle:@"阅读模式"];
    read.subTitle = @"有图模式";
    
    // 字体大小
    WBSettingItem *fontSize = [WBSettingItem itemWithTitle:@"字体大小"];
    _fontSize = fontSize;
    NSString *fontSizeStr =  [WBUserDefaults objectForKey:WBFontSizeKey];
    if (fontSizeStr == nil) {
        fontSizeStr = @"中";
    }
    fontSize.subTitle = fontSizeStr;
    fontSize.descVc = [WBFontSizeViewController class];
    
    // 显示备注
    WBSwitchItem *remark = [WBSwitchItem itemWithTitle:@"显示备注"];
    
    
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[read,fontSize,remark];
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    // 图片质量
    WBArrowItem *quality = [WBArrowItem itemWithTitle:@"图片质量" ];
    quality.descVc = [WBQualityViewController class];
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[quality];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 声音
    WBSwitchItem *sound = [WBSwitchItem itemWithTitle:@"声音" ];
    
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[sound];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 多语言环境
    WBSettingItem *language = [WBSettingItem itemWithTitle:@"多语言环境"];
    language.subTitle = @"跟随系统";
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[language];
    [self.groups addObject:group];
}

- (void)setUpGroup4
{
    // 清空图片缓存
    WBArrowItem *clearImage = [WBArrowItem itemWithTitle:@"清空图片缓存"];
    CGFloat fileSize = [SDWebImageManager sharedManager].imageCache.getSize / 1024.0;
    clearImage.subTitle = [NSString stringWithFormat:@"%.fKB",fileSize];
    if (fileSize > 1024) {
        fileSize =   fileSize / 1024.0;
        clearImage.subTitle = [NSString stringWithFormat:@"%.1fM",fileSize];
    }
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    
    CGFloat size =  [self sizeWithFile:filePath];
    // NSLog(@"%f",size);
    clearImage.option = ^{
        
        [[SDWebImageManager sharedManager].imageCache clearDisk];
        clearImage.subTitle = nil;
        [self.tableView reloadData];
        
        //     NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        //      NSString *filePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
        //
        //        [self removeFile:filePath];
        
    };
    WBGroupItem *group = [[WBGroupItem alloc] init];
    group.items = @[clearImage];
    [self.groups addObject:group];
}

- (CGFloat)sizeWithFile:(NSString *)filePath
{
    CGFloat totalSize = 0;
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (isExists) {
        
        if (isDirectory) {
            
            NSArray *subPaths =  [mgr subpathsAtPath:filePath];
            
            for (NSString *subPath in subPaths) {
                NSString *fullPath = [filePath stringByAppendingPathComponent:subPath];
                
                BOOL isDirectory;
                [mgr fileExistsAtPath:fullPath isDirectory:&isDirectory];
                
                if (!isDirectory) { // 计算文件尺寸
                    NSDictionary *dict =  [mgr attributesOfItemAtPath:fullPath error:nil];
                    
                    totalSize += [dict[NSFileSize] floatValue];;
                }
            }
            
            
            
        }else{
            
            NSDictionary *dict =  [mgr attributesOfItemAtPath:filePath error:nil];
            totalSize =  [dict[NSFileSize] floatValue];
            
        }
        
    }
    return totalSize;
}

- (void)removeFile:(NSString *)filePath
{
    
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}


@end
