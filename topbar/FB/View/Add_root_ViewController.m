//
//  Add_root_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/11.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Add_root_ViewController.h"
#import "Add_goumail_ViewController.h"
#import "Add_chusou_ViewController.h"
#import "Hy_root_ViewController.h"



@interface Add_root_ViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>
@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

@implementation Add_root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@aaaaa==",_titlea);
    
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
               config.shadowLineWidth = 60.0f;
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
      UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+6-100, (89-20)/2+10, 200, 40)];
    
      NSString * titles =[NSString stringWithFormat:@"发布委托单(%@/CNY)",_titlea];
      if (_titlea == nil) {
         [title setText:@"发布委托单(USDT/CNY)"];
      } else {
         [title setText:titles];
      }

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

//    if (index == 1) {
//            Add_chusou_ViewController *vc = [[Add_chusou_ViewController alloc] init];
////                   vc.typeA = [self typeID][index];
////                   vc.titlea = [self vcTitles][index];
//                   return vc;
//
//
//       }else   {
//           Add_goumail_ViewController *vc = [[Add_goumail_ViewController alloc] init];
////                   vc.typeA = [self typeID][index];
////                   vc.titlea = [self vcTitles][index];
//                   return vc;
//
//       }
    if ([_type isEqualToString:@"0"])
              {
        
                       if (index == 1) {
                               Add_chusou_ViewController *vc = [[Add_chusou_ViewController alloc] init];
                               vc.titlea = _titlea;
                               return vc;
                          }else{
                               Add_goumail_ViewController *vc = [[Add_goumail_ViewController alloc] init];
                               vc.titlea = _titlea;
                               return vc;
                          }
              }else{
                        if (index == 1) {
                                Add_goumail_ViewController *vc = [[Add_goumail_ViewController alloc] init];
                                vc.titlea = _titlea;
                                return vc;
            
            
                          }else {
                                Add_chusou_ViewController *vc = [[Add_chusou_ViewController alloc] init];
                                vc.titlea = _titlea;
                                return vc;
                         }
               }

    
}

#pragma mark -
#pragma mark PageViewControllerDelegate
- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
   // NSLog(@"切换到了全部下属：%@",[self vcTitles][index]);
}

#pragma mark 标题
- (NSArray *)vcTitles {
    

    if ([_type isEqualToString:@"0"]) {
        return @[@"我要购买",@"我要出售"];
    } else {
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"我要购买",@"我要出售",nil];
        NSArray* reversedArray = [[array reverseObjectEnumerator] allObjects];
        return reversedArray;
    }
    

    
}

#pragma mark 与标题对应的ID，要与数据库(MySql的新闻类型一致)
- (NSArray *)typeID {
    return @[@"1",@"2"];
}

// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

}
- (void)left:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
           for (UIViewController *controller in self.navigationController.viewControllers) {
               if ([controller isKindOfClass:[Hy_root_ViewController class]]) {
                   Hy_root_ViewController *vc =(Hy_root_ViewController *)controller;
                   [self.navigationController popToViewController:vc animated:YES];
       //            直接调用MyViewController里面的加载数据的方法即isRefreshData
                   [vc nav_new];//POP回去刷新页面
       //            若是需要传值的直接属性
                  // vc.name = @"你好！帅哥";
               }

           }
    
   
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

@end
