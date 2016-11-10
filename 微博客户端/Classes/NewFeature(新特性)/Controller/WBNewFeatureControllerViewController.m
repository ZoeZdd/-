//
//  WBNewFeatureControllerViewController.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/29.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBNewFeatureControllerViewController.h"
#import "WBNewFeatureCell.h"

@interface WBNewFeatureControllerViewController ()

@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation WBNewFeatureControllerViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置cell的尺寸
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    // 清空行距
    flowLayout.minimumLineSpacing = 0;
    // 设置滚动的方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:flowLayout];
}

//    self.collectionView != self.view;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor greenColor];
    
    // 注册cell
    [self.collectionView registerClass:[WBNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 添加pageControl
    [self setUpPageControl];
}

#pragma mark -- 添加pageControl
- (void)setUpPageControl
{
    // 添加pageControl,只需要设置位置,不需要管理尺寸
    UIPageControl *pageControl = [[UIPageControl alloc] init];

    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 设置center
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height - 20);
    _pageControl =pageControl;
    [self.view addSubview:pageControl];
}
#pragma mark - UIScrollView代理
// 只要一滚动就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量,计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _pageControl.currentPage = page;
    
}
#pragma mark <UICollectionViewDataSource>

// 返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 返回第section组有多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
// 返回cell长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //dequeueReusableCellWithReuseIdentifier
    // 1.首先从缓存池中取cell
    // 2.看下当前是否有注册cell,如果注册了cell,就帮你创建cell
    // 3.没有注册,报错
    WBNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    // 拼接图片名称
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row+1];
    cell.image = [UIImage imageNamed:imageName];
    [cell setIndexPath:indexPath count:4];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
