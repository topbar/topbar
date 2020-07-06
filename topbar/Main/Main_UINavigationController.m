//
//  Main_UINavigationController.m
//  topbar
//
//  Created by guo feng zou on 2019/9/17.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "Main_UINavigationController.h"

@interface Main_UINavigationController ()

@end

@implementation Main_UINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self slideToBack];

}

- (void)slideToBack{
    // 禁止系统原来的滑动返回手势，防止手势冲突
    self.interactivePopGestureRecognizer.enabled = NO;
    // 自定义滑动手势添加到self.view 调用系统原来的滑动返回方法
    // 即self.interactivePopGestureRecognizer.delegate的handleNavigationTransition:方法

    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    #pragma clang diagnostic pop
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}


#pragma mark - 手势代理方法
// 是否开始触发手势，如果是根控制器就不触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 判断下当前控制器是否是根控制器
    return (self.topViewController != [self.viewControllers firstObject]);
}


+ (void)initialize
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态 灰色
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    // 设置导航栏主题
    [self setupNavBarTheme];
}

// 状态栏字体 白色 重写preferredStatusBarStyle 方法



//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    // UIStatusBarStyleLightContent 白色
//    // UIStatusBarStyleDefault      黑色
//    return UIStatusBarStyleDefault;
//}


//这个很重要，搞了几天时间。设置这个其他页面可以自定义
//在 Info.plist 文件中添加 View controller-based status bar appearance 设置为 YES （理论同上，必须添加且必须设置为 YES ，否则不生效） 。
- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

+ (void)setupNavBarTheme
{
    
    //象征控制所有导航栏的外观
    //appearance方法返回一个导航栏的外观
    UINavigationBar* bar = [UINavigationBar appearance];
    
    //设置导航栏的背景颜色
    //[bar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1]] forBarMetrics:UIBarMetricsDefault];
      [bar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    //时间、电池、运营商显示白色
    bar.barStyle = UIBarStyleBlackOpaque;

    //设置导航栏文字的主题
    [bar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIColor colorWithRed:5.0/255 green:86.1/255 blue:189.0/255 alpha:1],NSForegroundColorAttributeName, [UIFont systemFontOfSize:20],NSFontAttributeName,nil]];//顶部字体颜色/字体大细
    
  

    
    UITabBar *tabBar = [UITabBar appearance];
    //设置全局tabBar字体
    [tabBar setTintColor:[UIColor colorWithRed:0.0/255 green:119.0/255 blue:204.0/255 alpha:1]];
   // rgb(0, 119, 170)
    
    
    //底部白色
    tabBar.backgroundColor = [UIColor whiteColor];
    //tabBar.backgroundImage = [UIImage imageNamed:@"bbs_ico_f"];
    //tabBar.backgroundImage = [self createImageWithColor:[UIColor darkGrayColor]];
    
    
}

//#pragma mark 颜色转换为图片
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
