//
//  Topbar_ViewController.m
//  topbar
//
//  Created by topbar on 2019/11/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "Topbar_ViewController.h"
#import "Topbar_conter_ViewController.h"

@interface Topbar_ViewController ()

@end

@implementation Topbar_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

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
               config.shadowLineWidth = 30;
               //阴影高度
               config.shadowLineHeight = 2.0f;
               //分割线颜色
               config.separatorLineColor = [self colorOfR:255 G:255 B:255];
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
    [self Menu];

}
-(void)Menu
{
    //涨跌、实时价、最高价、最低价
    UIView * Mume  = [[UIView alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth, 40)];
    Mume.backgroundColor  = [UIColor colorWithRed:248.0/255 green:248.0/255 blue:255.0/255 alpha:1];
    [self.view addSubview:Mume];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 7.5, 80, 30)];
    name.text  = @"币种/成交量";
    name.font= [UIFont systemFontOfSize:14];
    name.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    [Mume addSubview:name];
    
    UILabel * higt_low = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3,7.5, 80, 30)];
    higt_low.text  = @"高/低价";
    higt_low.font= [UIFont systemFontOfSize:14];
    higt_low.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    [Mume addSubview:higt_low];
    
    UILabel * new = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.8,7.5, 80, 30)];
    new.text  = @"最新价";
    new.font= [UIFont systemFontOfSize:14];
    new.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    [Mume addSubview:new];
    
    UILabel * Upsdowns = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.25, 7.5, 60, 30)];
    Upsdowns.text  = @"24H涨跌";
    Upsdowns.font= [UIFont systemFontOfSize:14];
    Upsdowns.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    [Mume addSubview:Upsdowns];
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

        Topbar_conter_ViewController *vc = [[Topbar_conter_ViewController alloc] init];
        vc.type =[self vcTitlesid][index];
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
    return @[@"USDT",@"BTC",@"QC"];
}
#pragma mark 与标题对应的ID
- (NSArray *)vcTitlesid {
    return @[@"2",@"3",@"1"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    // NSLog(@"2");
    //AudioServicesPlaySystemSound(SOUNDID);//文件类型
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动类型


}

@end
