//
//  Placard _list_h5_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/4/25.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Placard_list_h5_ViewController.h"
#import "MJRefresh.h"
@interface Placard_list_h5_ViewController ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,UINavigationControllerDelegate>


@end

@implementation Placard_list_h5_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
  // [self news_web];
//    UIImage *leftImage = [[UIImage imageNamed:@"app_back_btn_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem * leftButton_top  = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(left:)];
//    self.navigationItem.leftBarButtonItem = leftButton_top;
//    //右滑手势解决
//     self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//    //设置导航控制器的代理(隐藏顶部-nav)
//    // self.navigationController.delegate = self;
//
//    UIImage *rightImage = [[UIImage imageNamed:@"share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem * rightButton_top  = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(searchbtn)];
//    self.navigationItem.rightBarButtonItem = rightButton_top;

    

  
 
   [self createWebView];
   [self Nav_UI];
   [self progressViewA];//进度条
    

}
-(void)progressViewA
{
    // 设置进度条
    _progressView = [[UIProgressView alloc]init];
    _progressView.frame = CGRectMake(0, 89, ScreenWidth, 5);
    _progressView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_progressView];
      
    // 添加监测
    [_wkwebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];

}
// 实现监测(进度条)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    //NSLog(@" %s,change = %@",__FUNCTION__,change);
    if ([keyPath isEqual: @"estimatedProgress"] && object == _wkwebView) {
    [self.progressView setAlpha:1.0f];
    [self.progressView setProgress:_wkwebView.estimatedProgress animated:YES];
    if(_wkwebView.estimatedProgress >= 1.0f)
    {
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:0.0f animated:NO];
        }];
    }
      }
     else {
       [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
     }
    
    
}
-(void)Nav_UI
{
//    //----右滑手势解决
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//
//              //给导航条设置一个空的背景图 使其透明化
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//
//              //去除导航条透明后导航条下的黑线
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
       
             //设置导航控制器的代理(隐藏顶部-nav)
     self.navigationController.delegate = self;
    
    //-------自己定义Nav
     UIView * vc =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 89)];
     vc.backgroundColor  = [UIColor whiteColor];
     [self.view addSubview:vc];
     //-------左返回
     UIButton *Button_Left = [[UIButton alloc]initWithFrame:CGRectMake(10,(89-20)/2+10,40,40)];
     [Button_Left setImage:[UIImage imageNamed:@"app_back_btn_n"] forState:UIControlStateNormal];
     [Button_Left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:Button_Left];
     //-----居中的title
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-45, (89-20)/2+10, 90, 40)];
     // [title setText:_news_Title];
     title.font = [UIFont systemFontOfSize:16];
     title.textColor =  [UIColor orangeColor];
     [vc addSubview:title];
    
    //--右则按钮
    UIButton *DD = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50,(89-20)/2+10,40,40)];
    [DD setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [DD addTarget:self action:@selector(searchbtn) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:DD];
    

    
}

- (void)createWebView{
    UIView * webwindows  = [[UIView alloc]initWithFrame:CGRectMake(0, 89, ScreenWidth, ScreenHeight)];
    //webwindows.backgroundColor = [UIColor redColor];
    [self.view addSubview:webwindows];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    self.wkwebView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];

    [self.view addSubview:_wkwebView];
    _wkwebView.UIDelegate = self;
    _wkwebView.navigationDelegate = self;
    
    
    // WKWebView隐藏滚动条
    [_wkwebView.scrollView setShowsVerticalScrollIndicator:NO];
    [_wkwebView.scrollView setShowsHorizontalScrollIndicator:NO];
   
    
    NSString *api_url = [NSString stringWithFormat:@"Placard_list_h5.php?id=%@",self.news_id];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
    
   // NSString *urlString = [NSString stringWithFormat:@"http://192.168.14.109/website/admin/news_list_h5.php?id=%@",self.news_id];
    NSURL *url = [NSURL URLWithString: urlString];
    [_wkwebView loadRequest:[NSURLRequest requestWithURL:url]];
    
     //self.view = _wkwebView;
    [webwindows addSubview:_wkwebView];


  

    
    
    __weak UIScrollView *scrollView = _wkwebView.scrollView;
       
       scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reload)];
     //  [_wkwebView.scrollView.mj_header beginRefreshing];
    

}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //页面开始加载
     [webView.scrollView.mj_header endRefreshing];
    //[self CheckNet];
    //NSLog(@"111");

}
//
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //内容开始到达时
     [webView.scrollView.mj_header endRefreshing];
    //[self CheckNet];

}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //页面加载完成
     [webView.scrollView.mj_header endRefreshing];

}

- (void)reload
{
    
    [self.wkwebView reload];
}

- (void)dealloc {
[_wkwebView removeObserver:self forKeyPath:@"estimatedProgress"];
// if you have set either WKWebView delegate also set these to nil here
[_wkwebView setNavigationDelegate:nil];
[_wkwebView setUIDelegate:nil];
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

-(void)CheckNet
{
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 1.f;//请求时间
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=1&type=1"];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
   
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
           
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          // NSLog(@"请求成功%@", responseObject);
            
             

             MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.wkwebView animated:YES];
             HUD.minSize = CGSizeMake(100, 10);
             HUD.contentColor = [UIColor whiteColor];
             HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
             HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
             [MBProgressHUD hideHUDForView:self.wkwebView animated:YES];
           

             
             
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //  NSLog(@"请求失败");
           MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.wkwebView animated:YES];
           //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
           HUD.label.text = @"未连接服务器";
           HUD.minSize = CGSizeMake(100, 10);
           HUD.contentColor = [UIColor whiteColor];
           HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
           HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
           [MBProgressHUD hideHUDForView:self.wkwebView animated:YES];
         
            
           return;
        }];
}
//返回时会压住上一页底部而显示本页出栈。
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // 将hidesBottomBarWhenPushed属性设置如果为YES，当这个控制器push的时候，底部的Bar，比如Tabbar会滑走，也就是不会在push后的视图上显示出来，默认值为NO。
        
        //这个属性只支持非自定义的Tabbar，也就是只支持原生Tabbar，
        
        self.hidesBottomBarWhenPushed = YES;
        
    }
    
    return self;

}
@end
