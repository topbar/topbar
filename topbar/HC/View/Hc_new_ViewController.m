//
//  Hc_new_ViewController.m
//  topbar
//
//  Created by topbar on 2019/11/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "Hc_new_ViewController.h"
#import "Topbar_ViewController.h"
#import "Global_ViewController.h"

@interface Hc_new_ViewController ()

@end

@implementation Hc_new_ViewController

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
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {

    if (index == 0) {
           Topbar_ViewController *vc = [[Topbar_ViewController alloc] init];


           return vc;
           
       }else  {
           Global_ViewController *vc = [[Global_ViewController alloc] init];
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
    return @[@"TopBar",@"全球"];
 
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

       //NSLog(@"1");


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

@end
