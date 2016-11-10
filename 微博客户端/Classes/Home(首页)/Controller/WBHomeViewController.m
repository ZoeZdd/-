//
//  WBHomeViewController.m
//  微博项目
//
//  Created by 庄丹丹 on 16/7/19.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBHomeViewController.h"

#import "UIBarButtonItem+Item.h"
#import "WBTitleButton.h"

#import "WBPopMenu.h"
#import "WBCover.h"

#import "WBOneViewController.h"


#import "WBAccountTool.h"
#import "WBAccount.h"

#import "WBStatus.h"
#import "WBUser.h"

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "WBHttpTool.h"
#import "WBStatusTool.h"

#import "WBUserTool.h"

#import "WBStatusCell.h"

#import "WBStatusFrame.h"

@interface WBHomeViewController ()<WBCoverDelegate>

@property (nonatomic,weak) WBTitleButton *titleButton;

@property (nonatomic,strong) WBOneViewController *oneViewController;

/**
 *  ViewModel: WBStatusFrame
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation WBHomeViewController

-(NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

-(WBOneViewController *)oneViewController
{
    if (!_oneViewController) {
        _oneViewController = [[WBOneViewController alloc] init];
        
    }
    return _oneViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = WBColor(247, 247, 247);
    
    // 设置导航条内容
    [self setUpNavgationBar];
    
    // 添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    // 添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    // 请求当前用户的昵称
    [WBUserTool userInfoWithSuccess:^(WBUser *user) {
        // 请求当前账号的用户昵称
        // 设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 获取当前的账号
        WBAccount *account = [WBAccountTool account];
        account.name = user.name;
        // 保存用户的名称
        [WBAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        
    }];
    
    

}
#pragma mark - 刷新最新的微博
-(void)refresh
{
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
}

#pragma mark - 请求更多旧的微博
-(void)loadMoreStatus
{
    
    NSString *maxIdStr = nil;
    
    if (self.statusFrames.count) { // 有微博数据,才需要下拉刷新
        WBStatus *status = [[self.statusFrames lastObject] status];
        long long maxId = [status.idstr longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    // 请求更多的微博数据
    [WBStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];

        // 模型转换成视图模型  WBStatus -> WBStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (WBStatus *status in statuses) {
            WBStatusFrame *statusF = [[WBStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        // 把数组中元素添加进去
        [self.statusFrames addObjectsFromArray:statusFrames];
        
        // 刷新表格
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark - 请求最新的微博
- (void)loadNewStatus
{
    
    NSString *sinceId = nil;
    
    if (self.statusFrames.count) { // 有微博数据,才需要下拉刷新
        WBStatus *status = [self.statusFrames[0] status];
        sinceId = status.idstr;
    }
    
    [WBStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        
        // 展示最新的微博数
        [self showNewStatusCount:statuses.count];
        
        // 结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        // 模型转换成视图模型  WBStatus -> WBStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (WBStatus *status in statuses) {
            WBStatusFrame *statusF = [[WBStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        // 把最新的数据插入到最前面
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
#pragma mark - 展示最新的微博数
- (void)showNewStatusCount:(int)count
{
    if (count == 0) {
        return;
    }
    
    // 展示最新的微博数
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat x = 0;
    CGFloat w = self.view.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.text = [NSString stringWithFormat:@"刚刚更新了%d条微博",count];
    label.textAlignment = NSTextAlignmentCenter;
    
    // 插入导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 动画往下平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        // 往上平移
        [UIView animateWithDuration:0.25 delay:1.5 options:UIViewAnimationOptionCurveLinear  animations:^{
            // 还原
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}

#pragma mark - 设置导航条
- (void)setUpNavgationBar
{
     // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
    WBTitleButton *titleButton = [WBTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    NSString *title = [WBAccountTool account].name?:@"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;

}
// 以后只要显示在最前面的控件，一般都加在主窗口
// 点击标题按钮
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    // 弹出蒙板
    WBCover *cover = [WBCover show];
    cover.delegate = self;
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popH = popW;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popY = 55;
    WBPopMenu *menu = [WBPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.oneViewController.view;
    
    
}

// 点击蒙板的时候调用
- (void)coverDidClickCover:(WBCover *)cover
{
    
    // 隐藏pop菜单
    [WBPopMenu hide];
    
    _titleButton.selected = NO;
    
}


- (void)friendsearch
{
    
}

- (void)pop
{
    // 创建WBOneViewController
    WBOneViewController *one = [[WBOneViewController alloc] init];
    one.hidesBottomBarWhenPushed = YES;
   [self.navigationController pushViewController:one animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    
    // 获取status模型
    WBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    // 给cell传递模型
    cell.statusFrame = statusFrame;
    // 用户昵称
//    cell.textLabel.text = status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;
    
    return cell;
}

// 返回cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取status模型
    WBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

@end




















