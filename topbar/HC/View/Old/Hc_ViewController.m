//
//  Hc_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2019/9/17.
//  Copyright © 2019 guo feng zou. All rights reserved.
//
//行情

#import "Hc_ViewController.h"
#import "All_ViewController.h"
#import "Zb_ViewController.h"
#import "Cyb_ViewController.h"
#import "Hy_a_ViewController.h"





@interface Hc_ViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@end

@implementation Hc_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self initPageViewController];
}

- (void)initPageViewController {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    config.shadowLineColor = [UIColor colorWithRed:254/255.0f green:129/255.0f blue:1/255.0f alpha:1];
    config.titleSelectedFont = [UIFont boldSystemFontOfSize:12];
    config.titleNormalFont = [UIFont systemFontOfSize:12];
  //config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
    config.titleViewStyle = XLPageTitleViewStyleSegmented;
    config.showTitleInNavigationBar = true;
    config.separatorLineHidden = true;
    config.shadowLineAnimationType = XLPageShadowLineAnimationTypeZoom;
    config.shadowLineWidth = 35;
    
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
           All_ViewController *vc = [[All_ViewController alloc] init];
           return vc;
           
       }else if (index == 1) {
           Zb_ViewController *vc = [[Zb_ViewController alloc] init];
           return vc;
       }else if (index == 2) {
           Cyb_ViewController *vc = [[Cyb_ViewController alloc] init];
           return vc;
       }else {
           Hy_a_ViewController *vc = [[Hy_a_ViewController alloc] init];
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
    NSLog(@"切换到了：%@",[self titles][index]);
}

#pragma mark -
#pragma mark 标题数据
- (NSArray *)titles {
    return @[@"全部",@"主板",@"创业板",@"合约"];
}

@end
