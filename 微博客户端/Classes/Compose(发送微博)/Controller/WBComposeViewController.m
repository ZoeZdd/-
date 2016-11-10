//
//  WBComposeViewController.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/2.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBTextView.h"
#import "WBComposeToolBar.h"
#import "WBComposePhotosView.h"
#import "WBComposeTool.h"
#import "MBProgressHUD.h"

@interface WBComposeViewController ()<UITextViewDelegate,WBComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) WBTextView *textView;

@property (nonatomic,strong) WBComposeToolBar *toolBar;

@property (nonatomic, weak) WBComposePhotosView *photosView;

@property (nonatomic,weak) UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation WBComposeViewController

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条
    [self setUpNavgitonBar];
    
    // 添加textView
    [self setUpTextView];
    
    // 添加工具条
    [self setUpToolBar];
    
    // 监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 添加PhotosView相册视图
    [self setUpPhotosView];
    
    
}

#pragma mark - 添加PhotosView相册视图
-(void)setUpPhotosView
{
    CGFloat photosViewY = 100;
    CGFloat photosViewh = self.view.height - photosViewY;
    WBComposePhotosView *photosView = [[WBComposePhotosView alloc] initWithFrame:CGRectMake(0, photosViewY, self.view.width, photosViewh)];
    _photosView = photosView;
    
    [_textView addSubview:photosView];
}

#pragma mark - 键盘frame值改变的时候调用
- (void)keyboardFrameChange:(NSNotification *)note
{
    
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 获取键盘frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y == self.view.height) { // 没有弹出键盘
        [UIView animateWithDuration:durtion animations:^{
            _toolBar.transform = CGAffineTransformIdentity;
        }];
    }else{ // 弹出键盘,向上移动
        [UIView animateWithDuration:durtion animations:^{
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
    
}

#pragma mark - 添加工具条
-(void)setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    WBComposeToolBar *toolBar = [[WBComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    
}
#pragma mark - 点击工具条的时候调用 13952799798
-(void)composeToolBar:(WBComposeToolBar *)composeToolBar didClickBtn:(NSInteger)index
{
    // switch
    if (index == 0) { // 点击相册
        // 弹出系统相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 设置相册类型,相册集
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
#pragma mark - 选择图片完成的时候调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    WBLog(@"%@",info);
    // 获取选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    _photosView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    _rightItem.enabled = YES;
    
}

#pragma mark - 添加textView
- (void)setUpTextView
{
    WBTextView *textView = [[WBTextView alloc] initWithFrame:self.view.frame];
    
    // 设置占位符
    textView.placeHolder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:18];
    _textView = textView;
    [self.view addSubview:textView];
    
    // 默认允许垂直方向的拖拽
    textView.alwaysBounceVertical = YES;
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    // 监听文本框的输入
    /**
     * Observer: 谁需要监听通知
     * name: 监听的通知名称
     * object : 监听谁发出的通知,  nil : 表示谁发送的通知我都监听
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    // 监听拖拽
    textView.delegate = self;
}

#pragma mark - 开始拖拽的时候调用
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark- 文字改变的时候调用
- (void)textChange
{
    // 判断下textView有没有内容
    if (-_textView.text.length) { // 有内容
        _textView.hideplaceHolder = YES;
        _rightItem.enabled = YES;
    }else{
        _textView.hideplaceHolder = NO;
        _rightItem.enabled = NO;
    }
}

#pragma mark - 视图已经出现的时候弹出键盘
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}

#pragma mark - 移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 设置导航条
- (void)setUpNavgitonBar
{
    self.title = @"发微博";
    
    //left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    // right
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [rightBtn sizeToFit];
    [rightBtn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    _rightItem = rightItem;
    _rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 点击取消按钮
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 点击发送按钮
// 发送微博
-(void)compose
{
    // 新浪上传：文字不能为空，分享图片
    // 二进制数据不能拼接url的参数，只能使用formdata
    // 判断下有没有图片
    if (self.images.count) {
        
        // 发送图片
        [self sendPicture];
    }else{
        
        // 发送文字
        [self sendTitle];
    }
}
#pragma mark - 发送图片
- (void)sendPicture
{
    UIImage *image = self.images[0];
    
    NSString *status = _textView.text.length?_textView.text:@"分享图片";
    
    _rightItem.enabled = NO;
    [WBComposeTool composeWithStatus:status image:image success:^{
        // 提示用户发送成功
        //        WBLog(@"发送成功");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"发送成功";
        [hud hideAnimated:YES afterDelay:1.5];
        
        
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        _rightItem.enabled = YES;

    } failure:^(NSError *error) {
        // 提示用户发送失败
        //        WBLog(@"发送失败");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"发送失败";
        [hud hideAnimated:YES afterDelay:1.5];
        WBLog(@"%@",error);
        
        _rightItem.enabled = YES;
    }];
}

#pragma mark - 发送文字
- (void)sendTitle
{
    // 发送微博
    [WBComposeTool composeWithStatus:_textView.text success:^{
        
        // 提示用户发送成功
        //        WBLog(@"发送成功");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"发送成功";
        [hud hideAnimated:YES afterDelay:1.5];
        
         // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        //        WBLog(@"发送失败");
    }];

}

@end
