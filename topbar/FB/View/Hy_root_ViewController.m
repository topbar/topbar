//
//  Hy_root_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/11.
//  Copyright © 2020 guo feng zou. All rights reserved.
//OTC/C2C交易

#import "Hy_root_ViewController.h"
#import "Hy_chusou_ViewController.h"
#import "Hy_goumai_ViewController.h"
@interface Hy_root_ViewController ()

@end

@implementation Hy_root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self initPageViewController];
 
}

- (void)initPageViewController {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
//    config.shadowLineColor = [UIColor colorWithRed:254/255.0f green:129/255.0f blue:1/255.0f alpha:1];
//    config.titleSelectedFont = [UIFont boldSystemFontOfSize:24];
//    config.titleNormalFont = [UIFont systemFontOfSize:24];
    //config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
    //config.titleViewStyle = XLPageTitleViewStyleSegmented;
    config.showTitleInNavigationBar = true;
    config.separatorLineHidden = true;
    //config.shadowLineAnimationType = XLPageShadowLineAnimationTypeZoom;

    
    //设置标题样式为分段
    config.titleViewStyle = XLPageTitleViewStyleSegmented;
    //
    config.segmentedTintColor = [UIColor redColor];
    //分段选择器背景颜色
        config.segmentedBgColor = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
    //标题正常颜色
    config.titleNOcolor = [UIColor whiteColor];
    //标题正常字体
    config.titleNOdFont = [UIFont systemFontOfSize:14];
    //标题选择后颜色
    config.titleSedcolor = [UIColor whiteColor];
    //标题选择后字体
    config.titleSedFont = [UIFont systemFontOfSize:14];
    
    //标题缩进
    config.titleViewInset = UIEdgeInsetsMake(5, 100, 5, 100);

 


  
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
//    UIImage *rightImage = [[UIImage imageNamed:@"search@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//    UIBarButtonItem * rightButton_top  = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStyleDone target:self action:@selector(right:)];
//    self.navigationItem.rightBarButtonItem = rightButton_top;
//    UIView * aa  = [[UIView alloc]initWithFrame:CGRectMake(300, 0, 20, 20)];
//    aa.backgroundColor  = [UIColor redColor];
//    [self.pageViewController.view addSubview:aa];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {

    if (index == 0) {
           Hy_goumai_ViewController *vc = [[Hy_goumai_ViewController alloc] init];


           return vc;
           
       }else  {
           Hy_chusou_ViewController *vc = [[Hy_chusou_ViewController alloc] init];
           return vc;
       }


}
#pragma mark 辅助方法
- (UIColor *)colorOfR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B {
    return [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1];
}
- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return [self titles][index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return [self titles].count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
   // NSLog(@"切换到了：%@",[self titles][index]);
}

#pragma mark -
#pragma mark 标题数据
- (NSArray *)titles {
    return @[@"购买",@"出售"];
 
}

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
//从N级子目录返回到本页，调用这个方法（需在.H添加）。主要是显示顶部
- (void)nav_new
{
  
      self.navigationController.navigationBarHidden= NO;
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

      //NSLog(@"1");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateIndex:) name:@"updateTransferIndex" object:nil];

      //反回时顶部加一张白色背景图
     // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BgmBC"] forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBarHidden= NO;
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateIndex:) name:@"updateTransferIndex" object:nil];

    UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleHeavy];
    [impactLight impactOccurred];

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    //NSLog(@"2");


}
//计价方式返回用到调用
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

    //NSLog(@"3");
    _stus_type = @"1";
    [self setNeedsStatusBarAppearanceUpdate];
}
 




- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];

   // NSLog(@"4");
    if ([_block_id isEqualToString:@"1"])  {
        _stus_type = @"1";
        //NSLog(@"44---%@",_stus_type);
        [self setNeedsStatusBarAppearanceUpdate];
    } else {
        _stus_type = @"0";
        [self setNeedsStatusBarAppearanceUpdate];
    }
    _block_id = @"0";//反回时恢复按钮原值为0,0为白色
    


}
- (void)UpdateIndex:(NSNotification *)notification
{


    _block_id = @"1";
    [self setNeedsStatusBarAppearanceUpdate];
    [self dell];
}


- (void)dell{

    //删除观察者,十常重要，如果不删徐会出现大量重复数据，会死机

    [[NSNotificationCenter defaultCenter] removeObserver:self ];
    // NSLog(@"删了！！！！");
}

@end
