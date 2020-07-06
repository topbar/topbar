//
//  Default_root_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/2/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Default_root_ViewController.h"
//#import "Default_conter_ViewController.h"
#import "NearbyViewController.h"
#import "SquareViewController.h"
#import "RecommendViewController.h"
#import "Account_ViewController.h"
#import "Authentication_ViewController.h"
#import "OrderType_ViewController.h"
#import "Wallet_ViewController.h"
#import "Other_web_ViewController.h"
#import "Announcement_ViewController.h"//公告
#import "ZLAdvertViewController.h"//启动广告图

@interface Default_root_ViewController ()
@property (nonatomic, strong) UIScrollView *myScrollView;//滚动视图

@end

@implementation Default_root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self jsonParse];//加载公告及弹窗服务器上的内容
    [self xppage];//懒加载，预先加载
     
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * BgmA = [[UIView alloc]initWithFrame:CGRectMake(0, 89, ScreenWidth, ScreenHeight/2)];//下拉状态栏背景
    BgmA.backgroundColor  = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
    [self.view addSubview:BgmA];
    [self share];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"ZLPushToAdvert" object:nil];//接收，以通知形式启动广告图


}
// 进入广告链接页
- (void)pushToAd {
    _block_id = @"1";//电池栏状态,当同一页面需要调用二个以上不同黑白状态栏使用传值
    ZLAdvertViewController *adVc = [[ZLAdvertViewController alloc] init];
    [self.navigationController pushViewController:adVc animated:YES];
    
}
-(void)share
{

    //设置导航控制器的代理(隐藏顶部-nav)
    self.navigationController.delegate = self;
    [self.view addSubview:self.myScrollView];
    [self xppage];
    [self Nav_UI];
    [self HeadCon];
    [self Menu];
    
   
}
-(void)Advertise
{
 
        APopView  = [[Pop_rz alloc]init];
        APopView.type = @"10"; //传值，到底是认证时间还是认证等级，因为调用同一个窗口。 0 认证等级（默认）  、1 认证时间
        APopView.AD_URL = _Ad_url;
        APopView.AD_id  = _Ad_id;
        //NSLog(@"iiii===%@",_Ad_url);
    
        //APopView.currentTime = [NSString stringWithFormat:@"%ld",(long)currentTime];
        
    
        //三选其一显示
        [APopView showInView];//遮挡新建的view
        //[APopView coutomshowInView:self.view];
        //[PopView coutomshowInView:[UIApplication sharedApplication].keyWindow];
        __block Default_root_ViewController *blockSelf = self;//创建一个本地变量blockSelf，指向self，然后用结构体语法访问实例变量
        APopView.block = ^(NSString *text) {


            // NSLog(@"%@",text);
           // self->_text_num = [NSString stringWithFormat:@"%@",text];
            
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                         // Do something...

            
             [blockSelf Advertise_h5];


         });

            
        };
    

}
-(void)Advertise_h5
{
    Placard_list_h5_ViewController * vc = [[Placard_list_h5_ViewController alloc]init];
    vc.news_id =  self->_Ad_id;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)xppage
{
    
    //配置
      XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
     
                 config.titleSpace = 25;
                 //标题高度
                 config.titleViewHeight = 45;
                 //标题选中颜色
                 config.titleSelectedColor = [self colorOfR:19 G:121 B:214];
                 //标题选中字体
                 config.titleSelectedFont = [UIFont systemFontOfSize:16];
                 //标题正常颜色
                 config.titleNormalColor = [self colorOfR:142 G:153 B:160];
                 //标题正常字体
                 config.titleNormalFont = [UIFont systemFontOfSize:16];
                 //阴影颜色
                 config.shadowLineColor = [self colorOfR:19 G:121 B:214];
                 //阴影宽度
                 config.shadowLineWidth = 44;
                 //阴影高度
                 config.shadowLineHeight = 5.0f;
                 //分割线颜色
                 config.separatorLineColor = [self colorOfR:255 G:255 B:255];
                 //标题居中
                 config.titleViewAlignment = XLPageTitleViewAlignmentLeft;
    

      
      //设置缩进
     // config.titleViewInset = UIEdgeInsetsMake(5, 50, 5, 50);
      
      self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
      self.pageViewController.view.frame = self.view.bounds;
      self.pageViewController.delegate = self;
      self.pageViewController.dataSource = self;
      [self addChildViewController:self.pageViewController];
     // [self.view addSubview:self.pageViewController.view];
      
      UIView * Foort = [[UIView alloc]initWithFrame:CGRectMake(0, 300, ScreenWidth, ScreenHeight)];
    Foort.backgroundColor  = [UIColor whiteColor];
      [_myScrollView addSubview: Foort];
      [Foort addSubview:self.pageViewController.view];
}
- (UIScrollView *) myScrollView{


if (!_myScrollView) {

  

    UIScrollView *myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 89, ScreenWidth, ScreenHeight)];
    myScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight+(ScreenHeight/2.1));
    myScrollView.showsVerticalScrollIndicator = FALSE;//去掉滚动条
    

    myScrollView.delegate = self;

    //myScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    //myScrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
     
     // 设置自动切换透明度(在导航栏下面自动隐藏)
     header.automaticallyChangeAlpha = YES;
     // 隐藏时间
     header.lastUpdatedTimeLabel.hidden = YES;
     // 马上进入刷新状态
     //[header beginRefreshing];
     // 设置header
     myScrollView.mj_header = header;
    
    

self.myScrollView = myScrollView;

  }

return _myScrollView;

}


#pragma mark 下拉刷新数据
- (void)loadNewData
{

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            //结束上拉刷新
            [self.myScrollView.mj_header endRefreshing];

        //    // NSLog(@"1");
        //    // 刷除myScrollView,释放内存
        //     [self.myScrollView removeFromSuperview];
        //     [self.myScrollView.layer removeFromSuperlayer];
        //     _myScrollView=nil;
        //     [self share];
             [self jsonParse];//加载公告及弹窗服务器上的内容
             [self xppage];
             [self Menu];

            //第一次下拉时，刷新出3条数据，同时刷新上拉为还有更多字眼出现
             [self.myScrollView.mj_footer endRefreshing];
    

                   });

    
}


-(void)Nav_UI
{
    
     //-------自己定义Nav
     UIView * vc =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 89)];
     vc.backgroundColor  = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
     //vc.backgroundColor  = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
     [self.view addSubview:vc];

    //-------左返回
    UIButton *Button_Left = [[UIButton alloc]initWithFrame:CGRectMake(10,(89-20)/2+13,36,36)];
    [Button_Left setImage:[UIImage imageNamed:@"logo_234"] forState:UIControlStateNormal];
    //[Button_Left setImage:[UIImage imageNamed:@"qr-code"] forState:UIControlStateNormal];
    //[Button_Left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:Button_Left];
    
    UILabel * logo_text  = [[UILabel alloc]initWithFrame:CGRectMake(44, (89-20)/2+10,100,40)];
    logo_text.text = @"Topbar";
    logo_text.textColor  = [UIColor whiteColor];
    logo_text.font  =[UIFont boldSystemFontOfSize:30];
    [vc addSubview:logo_text];

     //-----居中的title
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-25+2, (89-20)/2+10, 50, 40)];
     //[title setText:@"合约"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];
     //--右则按钮
     UIButton *DD = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50,(89-20)/2+10,40,40)];
     //[DD setImage:[UIImage imageNamed:@"Mesg"] forState:UIControlStateNormal];
     //[DD addTarget:self action:@selector(Authentication) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:DD];

    
}

-(void)HeadCon
{
    //取沙盒用户信息
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    _type = [dic objectForKey:@"type"];
    //--
    UIView * Bgm = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    Bgm.backgroundColor = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
    [_myScrollView addSubview:Bgm];
    
    UIImageView * lineT = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2, 30, ScreenWidth/2, 100)];
    lineT.image = [UIImage imageNamed:@"line_topbar"];
    [Bgm addSubview:lineT];
    
    
    
    UILabel * Title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 40, 200, 20)];
    Title.text = @"新手入门";
    Title.textColor= [UIColor whiteColor];
    Title.font=[UIFont systemFontOfSize:30];
    [Bgm addSubview:Title];
    
    UILabel * Meny = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 70, 400, 40)];
    Meny.text = @"快速拥有数字货币，让你的交易快人一步！";
    Meny.textColor = [UIColor colorWithRed:255.0/255 green:255.1/255 blue:255.0/255 alpha:0.5];
    Meny.font=[UIFont systemFontOfSize:16];
    [Bgm addSubview:Meny];

    
    //----
    UIView * baner = [[UIView alloc]initWithFrame:CGRectMake(0, 140, ScreenWidth, 80)];
    baner.backgroundColor = [UIColor whiteColor];
    
        CGFloat UIButtonWidth = ScreenWidth;
        UIButton *AA = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4-(UIButtonWidth/4/2+10),30,20,20)];
        [AA setImage:[UIImage imageNamed:@"user_1"] forState:UIControlStateNormal];
        [AA addTarget:self action:@selector(Account) forControlEvents:UIControlEventTouchUpInside];
      
    
        [AA setTitle:@"帐户" forState:UIControlStateNormal];
        AA.titleLabel.font = [UIFont systemFontOfSize:12];
        AA.titleLabel.textAlignment = NSTextAlignmentCenter;
        [AA setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [AA setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [AA setImageEdgeInsets:UIEdgeInsetsMake(-AA.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -AA.titleLabel.intrinsicContentSize.width)];
        [AA setTitleEdgeInsets:UIEdgeInsetsMake(AA.currentImage.size.height + 10, -AA.currentImage.size.width-10, 0, 0)];
        [baner addSubview:AA];
        
        
        UIButton *BB = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4*2-(UIButtonWidth/4/2+10),30,20,20)];
        [BB setImage:[UIImage imageNamed:@"wallet"] forState:UIControlStateNormal];
        //[BB addTarget:self action:@selector(Action_wallet) forControlEvents:UIControlEventTouchUpInside];
        //[BB setTitle:@"钱包" forState:UIControlStateNormal];
        [BB addTarget:self action:@selector(Action_G) forControlEvents:UIControlEventTouchUpInside];
        [BB setTitle:@"买币" forState:UIControlStateNormal];
        BB.titleLabel.font = [UIFont systemFontOfSize:12];
        BB.titleLabel.textAlignment = NSTextAlignmentCenter;
        [BB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [BB setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [BB setImageEdgeInsets:UIEdgeInsetsMake(-BB.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -BB.titleLabel.intrinsicContentSize.width)];
        [BB setTitleEdgeInsets:UIEdgeInsetsMake(BB.currentImage.size.height + 10, -BB.currentImage.size.width-10, 0, 0)];
        [baner addSubview:BB];
        
        UIButton *CC = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4*3-(UIButtonWidth/4/2+10),30,20,20)];
        [CC setImage:[UIImage imageNamed:@"increasing"] forState:UIControlStateNormal];
        [CC addTarget:self action:@selector(Action_order) forControlEvents:UIControlEventTouchUpInside];
        [CC setTitle:@"订单" forState:UIControlStateNormal];
        CC.titleLabel.font = [UIFont systemFontOfSize:12];
        CC.titleLabel.textAlignment = NSTextAlignmentCenter;
        [CC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [CC setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [CC setImageEdgeInsets:UIEdgeInsetsMake(-CC.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -CC.titleLabel.intrinsicContentSize.width)];
        [CC setTitleEdgeInsets:UIEdgeInsetsMake(CC.currentImage.size.height + 10, -CC.currentImage.size.width-10, 0, 0)];
        [baner addSubview:CC];
        
        UIButton *DD = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4*4-(UIButtonWidth/4/2+10),30,20,20)];
        [DD setImage:[UIImage imageNamed:@"security"] forState:UIControlStateNormal];
        //[DD addTarget:self action:@selector(Authentication) forControlEvents:UIControlEventTouchUpInside];
        //[DD setTitle:@"认证" forState:UIControlStateNormal];
        [DD addTarget:self action:@selector(Action_help) forControlEvents:UIControlEventTouchUpInside];
        //[DD addTarget:self action:@selector(Advertise) forControlEvents:UIControlEventTouchUpInside];
        [DD setTitle:@"帮助" forState:UIControlStateNormal];
        DD.titleLabel.font = [UIFont systemFontOfSize:12];
        DD.titleLabel.textAlignment = NSTextAlignmentCenter;
        [DD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [DD setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [DD setImageEdgeInsets:UIEdgeInsetsMake(-DD.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -DD.titleLabel.intrinsicContentSize.width)];
        [DD setTitleEdgeInsets:UIEdgeInsetsMake(DD.currentImage.size.height + 10, -DD.currentImage.size.width-10, 0, 0)];
        [baner addSubview:DD];
    
    [_myScrollView addSubview:baner];
    
    
    //自定义分割线
    UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 219, ScreenWidth, 0.5)];
    VC.backgroundColor = RGBA(239, 239, 244, 1);
    //.backgroundColor = [UIColor orangeColor];
    [_myScrollView addSubview:VC];
    //----
    [self Messages];//单独加载消息及小banner文字
    //----
    
}
-(void)Messages{
        UIView * gonggao = [[UIView alloc]initWithFrame:CGRectMake(0, 220, ScreenWidth, 40)];
        gonggao.backgroundColor = [UIColor whiteColor];
        
        UIButton * MegUi = [[UIButton alloc]initWithFrame:CGRectMake(20,10,20,20)];
        [MegUi setImage:[UIImage imageNamed:@"volume"] forState:UIControlStateNormal];
        [gonggao addSubview:MegUi];
        //---------
        //NSArray *titles = _Titles ;
        NSArray *titles = [_Titles subarrayWithRange:NSMakeRange(0, 5)];//获取NSArray的前几个元素
        SDCycleScrollView *SDScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(50, 0, ScreenWidth-100, 40) delegate:self placeholderImage:nil];
         
        SDScrollview.onlyDisplayText=YES;
        SDScrollview.autoScroll=YES;
        //轮播时间
        SDScrollview.autoScrollTimeInterval =3;
        //字体高度
        SDScrollview.titleLabelHeight=40;
        //字体颜色
        SDScrollview.titleLabelTextColor=[UIColor blackColor];
        //背景颜色
        SDScrollview.titleLabelBackgroundColor=[UIColor whiteColor];
        //字体大小
        SDScrollview.titleLabelTextFont=[UIFont systemFontOfSize:14];
        //字体数组
        SDScrollview.titlesGroup=titles;
        //上下滚动
        SDScrollview.scrollDirection=UICollectionViewScrollDirectionVertical;
        [gonggao addSubview:SDScrollview];
        
        
        
    //    UILabel * gonggao_text = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, ScreenWidth, 40)];
    //    gonggao_text.text  = @"全球领先的交易所公链OKChain测试网上线";
    //    gonggao_text.font = [UIFont systemFontOfSize:12];
    //    gonggao_text.textColor = [UIColor grayColor];
    //    [gonggao addSubview:gonggao_text];
        
        UIButton * MegUi_R = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-26,10,20,20)];
        [MegUi_R setImage:[UIImage imageNamed:@"app_back_btn_F"] forState:UIControlStateNormal];
        [MegUi_R addTarget:self action:@selector(Announcement) forControlEvents:UIControlEventTouchUpInside];
        [gonggao addSubview:MegUi_R];
        
        [_myScrollView addSubview:gonggao];
    
    
        UIView * BgmB = [[UIView alloc]initWithFrame:CGRectMake(0, 260, ScreenWidth, 40)];
        BgmB.backgroundColor  = [UIColor whiteColor];
        
        UIView * ADbaner = [[UIView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 40)];
        ADbaner.layer.cornerRadius = 5.0;//圆角
        ADbaner.layer.masksToBounds = NO;
        ADbaner.backgroundColor = [UIColor blackColor];
        
        UILabel * ban_text = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 40)];
        ban_text.text = @"USDT";
        ban_text.font = [UIFont systemFontOfSize:18];
        ban_text.textColor = [UIColor systemBlueColor];
        [ADbaner addSubview:ban_text];
        
        UILabel * ban_text_1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 400, 40)];
        //ban_text_1.text = @"交割合约上线九大币种合约交易";
        NSArray *ADDtitlesa = [_Titles subarrayWithRange:NSMakeRange(0, 1)];//获取NSArray的前几个元素
        NSString *string = [ADDtitlesa componentsJoinedByString:@","];
        ban_text_1.text =string;
        ban_text_1.font = [UIFont systemFontOfSize:16];
        ban_text_1.textColor = [UIColor whiteColor];
        [ADbaner addSubview:ban_text_1];
        [BgmB addSubview:ADbaner];
        
        [_myScrollView addSubview:BgmB];
}
#pragma mark - SDCycleScrollViewDelegate//公告事件
///** 点击图片回调 */
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
//
///** 图片滚动回调 */
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
       _block_id = @"1";//电池栏状态,当同一页面需要调用二个以上不同黑白状态栏使用传值
      //NSLog(@"---点击了第%ld条公告", (long)index);
      //NSLog(@"%@",[_IDs objectAtIndex:(long)index]);
      Placard_list_h5_ViewController * vc = [[Placard_list_h5_ViewController alloc]init];
      vc.news_id = [_IDs objectAtIndex:(long)index]  ;//传值到WEB页面
      [self.navigationController pushViewController:vc animated:YES];
     
    
    // [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}
-(void)Announcement
{
    _block_id = @"1";//电池栏状态,当同一页面需要调用二个以上不同黑白状态栏使用传值
    Announcement_ViewController * vc = [[Announcement_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)Menu
{
    //涨跌、实时价、最高价、最低价
    UIView * Mume  = [[UIView alloc]initWithFrame:CGRectMake(0, 342, ScreenWidth, 40)];
    Mume.backgroundColor  = [UIColor whiteColor];
    [_myScrollView addSubview:Mume];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 7.5, 120, 30)];
    name.text  = @"币种/流通市值($)";
    name.font= [UIFont systemFontOfSize:14];
    name.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    [Mume addSubview:name];
    
//    UILabel * higt_low = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3,7.5, 80, 30)];
//    higt_low.text  = @"高/低价($)";
//    higt_low.font= [UIFont systemFontOfSize:14];
//    higt_low.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
//    [Mume addSubview:higt_low];
    
    UILabel * new = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.2,7.5, 80, 30)];
    new.text  = @"全球指数($)";
    new.font= [UIFont systemFontOfSize:14];
    new.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    [Mume addSubview:new];
    
    UILabel * Upsdowns = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.25, 7.5, 80, 30)];
    Upsdowns.text  = @"24H涨跌";
    Upsdowns.font= [UIFont systemFontOfSize:14];
    Upsdowns.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    [Mume addSubview:Upsdowns];
    
 
}
#pragma mark 辅助方法
- (UIColor *)colorOfR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B {
    return [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1];
}


#pragma mark PageViewControllerDataSource
//分页数
- (NSInteger)pageViewControllerNumberOfPage {
    return [self vcTitles].count;
}

//分页标题
- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    
    return [self vcTitles][index];
}

//分页视图控制器
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {

//        Default_conter_ViewController *vc = [[Default_conter_ViewController alloc] init];
//        vc.type =[self vcTitlesid][index];
//        vc.titlea = [self vcTitles][index];
//        return vc;
    
    if (index == 1) {
        RecommendViewController *vc = [[RecommendViewController alloc] init];
        //NSLog(@"1");

        
              return vc;
          }
    
    if (index == 2) {
        SquareViewController *vc = [[SquareViewController alloc] init];
        //NSLog(@"2");

               return vc;
   
           }
    
     else  {
        NearbyViewController *vc = [[NearbyViewController alloc] init];
        //NSLog(@"3");
              return vc;
         
          }

}


#pragma mark -
#pragma mark PageViewControllerDelegate
- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
   // NSLog(@"切换到了全部下属：%@",[self vcTitles][index]);
}

#pragma mark -
#pragma mark 标题
- (NSArray *)vcTitles {
    return @[@"成交榜",@"新币榜",@"涨幅榜"];
}
#pragma mark 与标题对应的ID
- (NSArray *)vcTitlesid {
    return @[@"1",@"2",@"3"];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{
    
    
        //创建session对象
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *UserApi=APIURL_USER;
           
        NSURL *url = [NSURL URLWithString:UserApi];
        NSString * Urladd =[NSString stringWithFormat:@"action=Placard&all=all"];
        //NSLog(@"cc==%@",Urladd);
           
             
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        //设置request
        request.HTTPMethod = @"POST" ;
           
        NSData *data=[Urladd dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = data;
    
        //创建任务
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                             
          if (!error )
             {
               // JSON数据格式解析
               NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
               //NSLog(@"aaa==%@",dic);
          
               //----------------公告
               NSMutableArray * array = [dic objectForKey:@"Megss"];
               NSMutableArray * Announcement = [array valueForKey:@"Announcement"];//公告信息5条
               self->_IDs = [[NSMutableArray alloc]init];//
               self->_Titles = [[NSMutableArray alloc]init];//

               self->_IDs = [Announcement valueForKeyPath:@"id"];
               self->_Titles = [Announcement valueForKeyPath:@"Title"];
               self->_Dates = [Announcement valueForKeyPath:@"date"];
           
                 if (Announcement != nil && ![Announcement isKindOfClass:[NSNull class]] && Announcement.count != 0) {
                   
                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                     
                        [self Messages];//首页消息
                                  });
                 } else {
                     
                       //NSLog(@"没有数据");

                 }
                 
               //  NSLog(@"%@",Announcement);
               //----------------弹窗
               NSMutableArray * Advertise = [array valueForKey:@"Advertise"];//弹窗1条
               self->_Ad_url = [Advertise valueForKey:@"pic_url" ];
               self->_Ad_id = [Advertise valueForKey:@"id"];
               //NSLog(@"%@==%@",self->_Ad_id,self->_Ad_url);
               //  NSLog(@"==%@",self->_Ad_url);
                 
                 if (Advertise != nil && ![Advertise isKindOfClass:[NSNull class]] && Advertise.count != 0) {
                   
                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 8 * NSEC_PER_SEC);//数字为时间延时
                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                     
                        [self Advertise];//广告
                                  });
                 } else {
                     
                       //NSLog(@"没有数据");

                 }
                 

              
                 
                 
                 //if (dic == (NULL))
//                 if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
//                               //主线程
//
//
//                 } else {
//
//                 }
//
                 

               
             // 判断是否解析成功
             if (error)
                {
                 NSLog(@"解析失败%@",error.localizedDescription);
                }
             else
                {
                 // NSLog(@"解析成功%@",teamtitles);
                }
             }
           else
             {
             NSLog(@"error is :%@",error.localizedDescription);
             }
           }];
            [task resume];//恢复线程，启动任务
            

    }




-(void)Action_wallet
{
    if ([_type isEqualToString:@"1"]) {
        Wallet_ViewController * vc = [[Wallet_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {

        [self performSelector:@selector(Login:) withObject:self ];


    }

}
-(void)Action_order
{
    
    if ([_type isEqualToString:@"1"]) {
        OrderType_ViewController *vc  = [[OrderType_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    } else {

        [self performSelector:@selector(Login:) withObject:self ];

    }

}


-(void)Account
{
//    _stus_type = @"0";//当按下“帐户”后传参数0，然后强制刷新(UIStatusBarStyle)preferredStatusBarStyle
//    [self setNeedsStatusBarAppearanceUpdate];//强制刷新电池栏
    
    if ([_type isEqualToString:@"1"]) {
        _block_id = @"1";//电池栏状态,当同一页面需要调用二个以上不同黑白状态栏使用传值
        Account_ViewController * vc =[[Account_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    } else {

        [self performSelector:@selector(Login:) withObject:self ];

    }

    
}
-(void)Authentication
{

    
    if ([_type isEqualToString:@"1"]) {
        Authentication_ViewController *vc = [[Authentication_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    } else {

        [self performSelector:@selector(Login:) withObject:self ];

    }


}
-(void)Action_G{
    
     //NSLog(@"买币");

     //跳转到UITabBarController的第四个页面
     self.tabBarController.selectedIndex = 3;

}
-(void)Action_help{
    
    _block_id = @"1";//电池栏状态,当同一页面需要调用二个以上不同黑白状态栏使用传值

    
     // NSLog(@"点击了帮助中心！");
     Other_web_ViewController *vc =[[Other_web_ViewController alloc]init];
     vc.news_Title = @"帮助中心";
     vc.news_url = @"https://www.okex.me/support-center.html";
     [self.navigationController pushViewController:vc animated:YES];
}
-(void)Login:(UITapGestureRecognizer*)sender{
    //具体事件
   
    Login_ViewController *toVC = [Login_ViewController alloc];
    
    Login_PresentationController *presentationC = [[Login_PresentationController alloc] initWithPresentedViewController:toVC presentingViewController:self];
    
    toVC.transitioningDelegate = presentationC ;  // 指定自定义modal动画的代理
    
    [self presentViewController:toVC animated:YES completion:nil];
    //[self dismissView];//清除顶部黑边
  
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

     //NSLog(@"2");


}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

      //NSLog(@"1");

      // 刷除myScrollView,释放内存
      // [self.myScrollView removeFromSuperview];
      // [self.myScrollView.layer removeFromSuperlayer];
      // _myScrollView=nil;
      // [self share];
      // [self viewDidLoad];
      //设置导航控制器的代理(隐藏顶部-nav)
      self.navigationController.delegate = self;
     // [self.view addSubview:self.myScrollView];
     // [self xppage];
     // [self Nav_UI];
     //[self HeadCon];//刷新需要登陆才能看的功能
     // [self Menu];

    //多种震动效果
     UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleHeavy];
     [impactLight impactOccurred];
     //多种震动效果
     // UIImpactFeedbackStyleLight,
     //UIImpactFeedbackStyleMedium,
     //UIImpactFeedbackStyleHeavy
    
    // AudioServicesPlaySystemSound(SOUNDID);//文件类型
     //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动类型
     //AudioServicesPlaySystemSound(1519);
     //AudioServicesPlaySystemSound(1520);



}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // UIStatusBarStyleLightContent 白色
    // UIStatusBarStyleDefault      黑色
    if ([_stus_type isEqualToString:@"0"]) {
         return UIStatusBarStyleDefault;
    } else {
         return UIStatusBarStyleLightContent;//初始化，默认电池栏为白色
    }
 
}
- (void)viewDidAppear:(BOOL)animated{
     [super viewDidAppear:animated];
    //接收通知，然后执行刷新
     //NSLog(@"333");
     [self HeadCon];//刷新需要登陆才能看的功能
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateIndex:) name:@"updateTransferIndex" object:nil];
     // NSLog(@"已收到通知，并准备执行");
    if ([_block_id isEqualToString:@"1"]) {
       // NSLog(@"1");
        
        _stus_type = @"1";//反回后，强制度刷新(UIStatusBarStyle)preferredStatusBarStyle
        [self setNeedsStatusBarAppearanceUpdate];//强制刷新电池栏
      
    }
     _block_id = @"0";//反回时恢复按钮原值为0,以便点击K线状态栏为白色使用
}

//计价方式返回用到调用

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];

    //NSLog(@"4");
    if ([_block_id isEqualToString:@"1"]) {
        _stus_type = @"0";
        //NSLog(@"0");
        [self setNeedsStatusBarAppearanceUpdate];
     
    }





}

- (void)UpdateIndex:(NSNotification *)notification
{
//     //接收login传过来的成功失败状态代码
//      _code =[notification.userInfo objectForKey:@"code"];
//     [self beginA];
    //NSLog(@"已执行ZC刷新");
     // 刷除tableV,释放内存
//     [self.tableV removeFromSuperview];
//     [self.tableV.layer removeFromSuperlayer];
//
//     _tableV=nil;
//     [self Share];
       [self HeadCon];//刷新需要登陆才能看的功能
      [self dell];


}
- (void)dell{

    //删除观察者,十常重要，如果不删徐会出现大量重复数据，会死机

    [[NSNotificationCenter defaultCenter] removeObserver:self ];
    // NSLog(@"删了！！！！");
}
////// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

}
@end
