//
//  Jc_ViewController.m
//  topbar
//
//  Created by topbar on 2019/12/18.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "Jc_ViewController.h"
#import "XLPageViewController.h"
//#import "All_a_ViewController.h"
//#import "Search_ViewController.h"
#import "Jy_content_ViewController.h"
@interface Jc_ViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;


@end

@implementation Jc_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //配置
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
   
               config.titleSpace = 25;
               //标题高度
               config.titleViewHeight = 45;
               //标题选中颜色
               config.titleSelectedColor = [self colorOfR:34 G:34 B:34];
               //标题选中字体
               config.titleSelectedFont = [UIFont systemFontOfSize:16];
               //标题正常颜色
               config.titleNormalColor = [self colorOfR:142 G:153 B:160];
               //标题正常字体
               config.titleNormalFont = [UIFont systemFontOfSize:16];
               //阴影颜色
               config.shadowLineColor = [self colorOfR:19 G:121 B:214];
               //阴影宽度
               config.shadowLineWidth = 30;
               //阴影高度
               config.shadowLineHeight = 2.0f;
               //分割线颜色
               config.separatorLineColor = [self colorOfR:238 G:238 B:238];
               //标题居中
               config.titleViewAlignment = 1;
    
    

    
    //设置缩进
   // config.titleViewInset = UIEdgeInsetsMake(5, 50, 5, 50);
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    
    
//      UIImage *rightImage = [[UIImage imageNamed:@"search@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//      UIBarButtonItem * rightButton_top  = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStyleDone target:self action:@selector(right:)];
//      self.navigationItem.rightBarButtonItem = rightButton_top;
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
 
        Jy_content_ViewController *vc = [[Jy_content_ViewController alloc] init];
        vc.type = [self typeID][index];
        vc.titlea = [self vcTitles][index];
        return vc;
   
}

#pragma mark -
#pragma mark PageViewControllerDelegate
- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
   // NSLog(@"切换到了全部下属：%@",[self vcTitles][index]);
}

#pragma mark -
#pragma mark 标题
- (NSArray *)vcTitles {
    return @[@"小白",@"里程碑",@"使用教程"];
}
#pragma mark 与标题对应的ID，要与数据库(MySql的新闻类型一致)
- (NSArray *)typeID {
    return @[@"4",@"5",@"6"];
}
//- (void)right:(id)sender
//{
//    Search_ViewController * vc = [[Search_ViewController alloc]init];
//     vc.hidesBottomBarWhenPushed =YES;//Push到news_list_h5_ViewController.m隐藏tabBar（底部导航）
//    [self.navigationController pushViewController:vc animated:YES];
//}

@end
