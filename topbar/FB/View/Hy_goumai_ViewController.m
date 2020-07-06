//
//  Hy_goumai_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/11.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Hy_goumai_ViewController.h"
#import "XLPageViewController.h"
#import "Hy_goumai_con_ViewController.h"
#import "Add_root_ViewController.h"


@interface Hy_goumai_ViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;


@end

@implementation Hy_goumai_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //配置
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
   
               config.titleSpace = 25;
               //标题高度
               config.titleViewHeight = 45; 
               //标题选中颜色
               config.titleSelectedColor = [self colorOfR:5 G:86 B:198];
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
    [self Add_Meg];

    
    

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
 
        Hy_goumai_con_ViewController *vc = [[Hy_goumai_con_ViewController alloc] init];
        vc.type = [self typeID][index];
        vc.titlea = [self vcTitles][index];
 
        return vc;
   
}

#pragma mark -
#pragma mark PageViewControllerDelegate
- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    //NSLog(@"切换到了全部下属：%@",[self vcTitles][index]);
    _NS_title = [self vcTitles][index];
}

#pragma mark -
#pragma mark 标题
- (NSArray *)vcTitles {
    return @[@"USDT",@"BTC",@"ETH"];
}
#pragma mark 与标题对应的ID，要与数据库(MySql的新闻类型一致)
- (NSArray *)typeID {
    return @[@"1",@"2",@"3"];
}

//设置悬浮按钮
-(void)Add_Meg
{
  
       
        //取沙盒用户信息
        NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [documentsPathArr lastObject];
        NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
        _type = [dic objectForKey:@"type"];
    
        #define Topbar_INPUTVIEW_HEIGHT 320.f
        UIButton *rbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rbtn setFrame:CGRectMake(ScreenWidth-64, ScreenHeight - Topbar_INPUTVIEW_HEIGHT, 50, 50)];
        [rbtn setImage:[UIImage imageNamed:@"Add_P@2x"] forState:UIControlStateNormal];
        [rbtn addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:rbtn];

};
-(void)Add_Meg_canel//本身按钮透明，如果不取消就会重叠
{
  
       
        //取沙盒用户信息
        NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [documentsPathArr lastObject];
        NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
        _type = [dic objectForKey:@"type"];
    
        #define Topbar_INPUTVIEW_HEIGHT 320.f
        UIButton *rbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rbtn setFrame:CGRectMake(ScreenWidth-64, ScreenHeight - Topbar_INPUTVIEW_HEIGHT, 50, 50)];
       // [rbtn setImage:[UIImage imageNamed:@"Add_P@2x"] forState:UIControlStateNormal];
        [rbtn addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:rbtn];

};

- (void)rightButtonAction {
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTransferIndex" object:self userInfo:nil];//通知hy_root_viewcontrloller刷新状态栏
    
    if ([_type isEqualToString:@"1"]) {
            //NSLog(@"购买");
         Add_root_ViewController * VC  = [[Add_root_ViewController alloc]init];
         VC.titlea = _NS_title;
         VC.type =@"0";
        [self.navigationController pushViewController:VC animated:YES];
    } else {
         [self performSelector:@selector(Login:) withObject:self ];
    }


    
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

    // NSLog(@"2");
    //AudioServicesPlaySystemSound(SOUNDID);//文件类型
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动类型


}
//其它根目录跳转过来时执行（最主要是其他页面退出登陆后，而这里还没有检测到用户已退出）
- (void)viewDidAppear:(BOOL)animated{
     [super viewDidAppear:animated];
    //接收通知，然后执行刷新
     //NSLog(@"333");
    // [self Add_Meg];//刷新需要登陆才能看的功能
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateIndex:) name:@"updateTransferIndex" object:nil];
     // NSLog(@"已收到通知，并准备执行");

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
       [self Add_Meg_canel];//刷新需要登陆才能看的功能
       [self dell];


}
- (void)dell{

    //删除观察者,十常重要，如果不删徐会出现大量重复数据，会死机

    [[NSNotificationCenter defaultCenter] removeObserver:self ];
     //NSLog(@"删了！！！！");
}
@end
