//
//  WBOAuthViewController.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/29.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBOAuthViewController.h"

#import "MBProgressHUD.h"

#import "WBAccountTool.h"

#import "WBRootTool.h"

#define WBAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define WBClient_id     @"1272181806"
#define WBRedirect_uri  @"http://www.baidu.com"
#define WBClient_secret @"fb6e095528327c233ca8944af58fb014"


@interface WBOAuthViewController ()<UIWebViewDelegate>

@end

@implementation WBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 展示登陆的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    // 加载网页
    // 完整的URL:基本URL + 参数
    //https://api.weibo.com/oauth2/authorize?client_id=1272181806&redirect_uri=http://www.baidu.com
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",WBAuthorizeBaseUrl,WBClient_id,WBRedirect_uri];
    
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 加载请求
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;
}

#pragma mark -- UIWebViewDelegate
// webView开始加载的时候调用
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载中...";
}

// webView加载完的时候调用
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

//  webview加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
// 拦截webView请求
// 当webView需要加载一个请求的时候,就会调用这个方法,询问是否加载请求
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
//    WBLog(@"%@",urlStr);
    
    // 获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) { // 有code=
        
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
       // 获取授权accessToken
        [self accessTokenWithCode:code];
        
        // 不会去加载回调界面
        return NO;
    }
    return YES;
}
#pragma mark -- 获取授权accessToken
-(void)accessTokenWithCode:(NSString *)code
{
    [WBAccountTool accountWithCode:code success:^{
        // 进入主页或者新特性,选择窗口的根控制器
        [WBRootTool chooseRootViewController:WBKeyWindow];

    } failure:^(NSError *error) {
        
    }];
    
    
}


@end


















