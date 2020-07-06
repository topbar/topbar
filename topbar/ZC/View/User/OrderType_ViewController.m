//
//  OrderType_ViewController.m
//  topbar
//
//  Created by topbar on 2019/11/14.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "OrderType_ViewController.h"
#import "XLPageViewController.h"
#import "Order_ViewController.h"

@interface OrderType_ViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>
@property (nonatomic, strong) XLPageViewController *pageViewController;
@end

@implementation OrderType_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航控制器的代理(隐藏顶部-nav)
    self.navigationController.delegate = self;

    [self Nav_UI];

    self.view.backgroundColor = [UIColor whiteColor];
    //配置
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    

               //标题间距
               config.titleSpace = 80;
               //标题高度
               config.titleViewHeight = 45;
               //标题选中颜色
               config.titleSelectedColor = [self colorOfR:3 G:33 B:89];
               //标题选中字体
               config.titleSelectedFont = [UIFont boldSystemFontOfSize:15];
               //标题正常颜色
               config.titleNormalColor = [self colorOfR:142 G:153 B:160];
               //标题正常字体
               config.titleNormalFont = [UIFont systemFontOfSize:15];
               //阴影颜色
               config.shadowLineColor = [self colorOfR:19 G:121 B:214];
               //阴影宽度
               config.shadowLineWidth = 44.0f;
               //阴影高度
                config.shadowLineHeight = 2.0f;
               //分割线颜色
               config.separatorLineColor = [self colorOfR:238 G:238 B:238];
               //文字居中
               config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
               //设置缩进
               //config.titleViewInset = UIEdgeInsetsMake(5, 50, 5, 50);

    
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    //self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.view.frame = CGRectMake(0, 89, ScreenWidth, ScreenHeight);//重要设置Nav预留高度
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
     
}
-(void)Nav_UI
{
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
      [title setText:@"订单记录"];
      title.font = [UIFont systemFontOfSize:18];
      title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
      [vc addSubview:title];
}

#pragma mark 辅助方法
- (UIColor *)colorOfR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B {
    return [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1];
}
#pragma mark -
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
 
        Order_ViewController *vc = [[Order_ViewController alloc] init];
        vc.type = [self typeID][index];
        vc.titlea = [self vcTitles][index];
    
        return vc;
   
}

#pragma mark -
#pragma mark PageViewControllerDelegate
- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
   // NSLog(@"切换到了全部下属：%@",[self vcTitles][index]);
}

#pragma mark 标题
- (NSArray *)vcTitles {
    return @[@"全部",@"已撤销",@"已成交"];
}

#pragma mark 与标题对应的ID，要与数据库(MySql的新闻类型一致)
- (NSArray *)typeID {
    return @[@"1",@"2",@"3"];
}

// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

}
- (void)left:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
   
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
////从N级子目录返回到本页，调用这个方法（需在.H添加）。主要是显示顶部
//- (void)nav_new
//{
//
//      self.navigationController.navigationBarHidden= NO;
//
//}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // UIStatusBarStyleLightContent 白色
    // UIStatusBarStyleDefault      黑色
    
    if ([_stus_type isEqualToString:@"0"]) {
         //NSLog(@"我是白色==%@",_stus_type);
        return UIStatusBarStyleLightContent;
       
    } else {
        //NSLog(@"我是黑色==%@",_stus_type);
        return UIStatusBarStyleDefault;
        
    }
   
 
    
}
//
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

   //NSLog(@"3");
    _stus_type = @"1";
    [self setNeedsStatusBarAppearanceUpdate];

    




}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];

    //NSLog(@"4");
    _stus_type = @"0";




}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

      //NSLog(@"1");
      //反回时顶部加一张白色背景图
      // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BgmBC"] forBarMetrics:UIBarMetricsDefault];
       // self.navigationController.navigationBarHidden= YES;
      self.navigationController.delegate = self;

}
@end
