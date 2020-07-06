//
//  OtherA_web_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/10.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "OtherA_web_ViewController.h"

@interface OtherA_web_ViewController ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,UINavigationControllerDelegate>


@end

@implementation OtherA_web_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
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
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // UIStatusBarStyleLightContent 白色
    // UIStatusBarStyleDefault      黑色
    return UIStatusBarStyleLightContent;
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
     vc.backgroundColor  = [UIColor colorWithRed:21.0/255 green:31.0/255 blue:47.0/255 alpha:1];
     [self.view addSubview:vc];
     //-------左返回
     UIButton *Button_Left = [[UIButton alloc]initWithFrame:CGRectMake(10,(89-20)/2+10,40,40)];
     [Button_Left setImage:[UIImage imageNamed:@"app_back_btn_W"] forState:UIControlStateNormal];
     [Button_Left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:Button_Left];
     //-----居中的title
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-45, (89-20)/2+10, 90, 40)];
     [title setText:_news_Title];
     title.font = [UIFont systemFontOfSize:16];
     title.textColor =  [UIColor orangeColor];
     [vc addSubview:title];
    
    //--右则按钮
    UIButton *DD = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50,(89-20)/2+10,40,40)];
    [DD setImage:[UIImage imageNamed:@"share_w"] forState:UIControlStateNormal];
    [DD addTarget:self action:@selector(searchbtn) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:DD];
    

    
}

- (void)createWebView{

    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    UIView * Vc_web =[[UIView alloc]initWithFrame:CGRectMake(0, 89, ScreenWidth, ScreenHeight)];
    
    [self.view addSubview:Vc_web];
    self.wkwebView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];
    //self.wkwebView.scrollView.backgroundColor = [UIColor colorWithRed:21.0/255 green:31.0/255 blue:47.0/255 alpha:1];
    
    [Vc_web addSubview:_wkwebView];
    _wkwebView.UIDelegate = self;
    _wkwebView.navigationDelegate = self;
    
    // WKWebView隐藏滚动条
    [_wkwebView.scrollView setShowsVerticalScrollIndicator:NO];
    [_wkwebView.scrollView setShowsHorizontalScrollIndicator:NO];
    
   
    
     NSString *urlString = [NSString stringWithFormat:@"%@", _news_url];
     //有中文网址进行转码
     NSString * Get_Url_String = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
       /***
       stringByAddingPercentEncodingWithAllowedCharacters 对字符串进行编码
         URLFragmentAllowedCharacterSet                                "#%<>[\]^`{|}
         URLHostAllowedCharacterSet                                    "#%/<>?@\^`{|}
         URLPasswordAllowedCharacterSet                                "#%/:<>?@[\]^`{|}
         URLPathAllowedCharacterSet                                    "#%;<>?[\]^`{|}
         URLQueryAllowedCharacterSet                                   "#%<>[\]^`{|}
         URLUserAllowedCharacterSet                                    "#%/:<>?@[\]^`
       ***/
    
   
    NSURL *url = [NSURL URLWithString: Get_Url_String];
    [_wkwebView loadRequest:[NSURLRequest requestWithURL:url]];

    
     Vc_web = _wkwebView;


    
    //下拉刷新动作
    __weak UIScrollView *scrollView = self->_wkwebView.scrollView;
     scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reload)];
    //[_wkwebView.scrollView.mj_header beginRefreshing];
    

}


-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //页面开始加载
     [webView.scrollView.mj_header endRefreshing];
     [self CheckNet];
    

    

    

}
//
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //内容开始到达时
    [webView.scrollView.mj_header endRefreshing];
    [self CheckNet];

   
}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //页面加载完成
     [webView.scrollView.mj_header endRefreshing];

}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation;
{
    //加载失败

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



#pragma mark - webViewDelegate//
//UIWebView中几个重要的函数
//1.- (void )webViewDidStartLoad:(UIWebView  *)webView   网页开始加载的时候调用
//2.- (void )webViewDidFinishLoad:(UIWebView  *)webView  网页加载完成的时候调用
//3.- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error 网页加载错误的时候调用

- (void) webViewDidFinishLoad:(nonnull UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
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


//// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
  //  NSLog(@"222");


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
             HUD.label.text = @"正在加载";
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
- (void)searchbtn{

    NSLog(@"分享");
    

}
@end
