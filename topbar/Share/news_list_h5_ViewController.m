//
//  nes_list_h5_ViewController.m
//  topbar
//
//  Created by topbar on 2019/10/8.
//  Copyright © 2019 guo feng zou. All rights reserved.
//
//新闻加载H5页面，采用WKWebView，系统导航（顶部）
#import "news_list_h5_ViewController.h"
#import "MJRefresh.h"


@interface news_list_h5_ViewController ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,UINavigationControllerDelegate>

@end

@implementation news_list_h5_ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
  // [self news_web];
    UIImage *leftImage = [[UIImage imageNamed:@"app_back_btn_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftButton_top  = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(left:)];
    self.navigationItem.leftBarButtonItem = leftButton_top;
    //右滑手势解决
     self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    //设置导航控制器的代理(隐藏顶部-nav)
    // self.navigationController.delegate = self;
      
    UIImage *rightImage = [[UIImage imageNamed:@"share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * rightButton_top  = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(searchbtn)];
    self.navigationItem.rightBarButtonItem = rightButton_top;

    

    
 
   [self createWebView];
    

}


- (void)createWebView{
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    self.wkwebView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];
    [self.view addSubview:_wkwebView];
    _wkwebView.UIDelegate = self;
    _wkwebView.navigationDelegate = self;
    
    
    // WKWebView隐藏滚动条
    [_wkwebView.scrollView setShowsVerticalScrollIndicator:NO];
    [_wkwebView.scrollView setShowsHorizontalScrollIndicator:NO];
   
    
    NSString *api_url = [NSString stringWithFormat:@"news_list_h5.php?id=%@",self.news_id];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
    
   // NSString *urlString = [NSString stringWithFormat:@"http://192.168.14.109/website/admin/news_list_h5.php?id=%@",self.news_id];
    NSURL *url = [NSURL URLWithString: urlString];
    [_wkwebView loadRequest:[NSURLRequest requestWithURL:url]];
    
     self.view = _wkwebView;


  

    
    
    __weak UIScrollView *scrollView = _wkwebView.scrollView;
       
       scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reload)];
     //  [_wkwebView.scrollView.mj_header beginRefreshing];
    

}

//-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    //页面开始加载
//     [webView.scrollView.mj_header endRefreshing];
//    NSLog(@"111");
//
//}
//
//-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
//    //内容开始到达时
//     [webView.scrollView.mj_header endRefreshing];
//    NSLog(@"222");
//}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //页面加载完成
     [webView.scrollView.mj_header endRefreshing];

}

- (void)reload
{
    
    [self.wkwebView reload];
}





-(void)news_web
{
    
    // 添加背景
    // _webView.backgroundColor = [UIColor redColor];
    // 显示标题
    // self.title = self.data.username;
    
    // 1.网页控件
    UIWebView *webView = [[UIWebView alloc] init];
    
    
    // 2.设置frm,自动调整高度及宽度
    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    // webView.frame = self.view.bounds;//view全屏
    self.webView = webView;
    
    // 3.添加webview
    [self.view addSubview:webView];
    
    // 4.显示网页
    NSString * web =[NSString stringWithFormat:@"http://192.168.14.109/website/admin/news_list_h5.php?id=%@",_news_id];
  //  NSLog(@"%@",web);
    
 
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:web]]];
    // 用于调整界面 （适配手机版网页）
    webView.scalesPageToFit = YES;
   
    
    // 5. 设置代理 添加下拉刷新
    webView.delegate = self;
    
    __weak UIScrollView *scrollView = webView.scrollView;
    
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reload)];
    

  //  [webView.scrollView.mj_header beginRefreshing];
    

    
}



#pragma mark - webViewDelegate//
//UIWebView中几个重要的函数
//1.- (void )webViewDidStartLoad:(UIWebView  *)webView   网页开始加载的时候调用
//2.- (void )webViewDidFinishLoad:(UIWebView  *)webView  网页加载完成的时候调用
//3.- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error 网页加载错误的时候调用

- (void) webViewDidFinishLoad:(nonnull UIWebView *)webView
{
    ///NSLog(@"webViewDidFinishLoad");
    [self.webView.scrollView.mj_header endRefreshing];
     
}
//- (void)reload
//{
//
//    [self.webView reload];
//}
- (void)left:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
   
}
- (void)searchbtn{

    NSLog(@"分享");
    

}

// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
   // NSLog(@"222");
}

@end
