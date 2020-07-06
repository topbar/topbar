//
//  Main_UITabBarController.m
//  topbar
//
//  Created by guo feng zou on 2019/9/17.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "Main_UITabBarController.h"
#import "Main_UINavigationController.h"
#import "Default_root_ViewController.h"
//#import "myScrollView_ViewController.h"
//#import "Hc_ViewController.h"
//#import "DiscoverHomeViewController.h"
#import "Hc_new_ViewController.h"
//#import "Jy_ViewController.h"
#import "jy_root_ViewController.h"
//#import "Hy_ViewController.h"
#import "Hy_root_ViewController.h"
#import "Zc_ViewController.h"

@interface Main_UITabBarController ()

@end

@implementation Main_UITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self jsonParse];//加载APP开机广告图
     [NSThread sleepForTimeInterval:3];//延时加载
          
    // Do any additional setup after loading the view.
    
    // 1.初始化子控制器
    

    
    Hc_new_ViewController *HC = [[Hc_new_ViewController alloc] init];
    [self addChildVc:HC title:@"行情" toptitle:@"数字行情" image:@"Hc_f" selectedImage:@"Hc"];


    jy_root_ViewController *JY = [[jy_root_ViewController alloc] init];
    [self addChildVc:JY title:@"深度" toptitle:@"TopBar/BTC" image:@"Jy_f" selectedImage:@"Jy"];
    
    Default_root_ViewController *Default = [[Default_root_ViewController alloc] init];
    [self addChildVc:Default title:@"首页" toptitle:@"Top数字货币" image:@"Home_f" selectedImage:@"Home"];
    

    Hy_root_ViewController *HY = [[Hy_root_ViewController alloc] init];
    [self addChildVc:HY title:@"法币" toptitle:@"BTC季度1227" image:@"Hy_f" selectedImage:@"Hy"];

    Zc_ViewController *ZC = [[Zc_ViewController alloc] init];
    [self addChildVc:ZC title:@"资产" toptitle:@"资产" image:@"Zc_f" selectedImage:@"Zc"];


    
    //默认选择第二个控制器 从 0 开始算
    self.selectedIndex = 2;
    
    
    
}
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
           NSMutableArray * Root_Advertise = [array valueForKey:@"Root_Advertise"];//公告信息5条

           NSMutableArray *IDs = [Root_Advertise valueForKeyPath:@"id"];
           NSMutableArray *Titles = [Root_Advertise valueForKeyPath:@"Title"];
           NSMutableArray * Ad_url = [Root_Advertise valueForKey:@"pic_url" ];
           
           //--
           NSArray *array_L = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
           NSString *documents = [array_L lastObject];
           NSString *documnetPath = [documents stringByAppendingPathComponent:@"AD.plist"];
           //准备要存入的字典
           NSDictionary *dic_notice = [NSDictionary dictionaryWithObjectsAndKeys:IDs,@"id",Titles,@"title",Ad_url,@"pic_url",nil ];

          [dic_notice writeToFile:documnetPath atomically:YES];

           
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


/**
 *  添加一个子控制器
 **  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title  toptitle:(NSString *)toptitle image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = toptitle; // 设置navigationBar的文字
    
    childVc.tabBarItem.title = title;//设置tabbar的文字
  
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    //声明显示图片的原始式样 不要渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    Main_UINavigationController *nav = [[Main_UINavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
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
