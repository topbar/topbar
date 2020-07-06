//
//  AppDelegate.m
//  topbar
//
//  Created by guo feng zou on 2019/9/16.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "AppDelegate.h"
#import "Main_UITabBarController.h"
//启动画面有秒数的，不是首页弹窗
#import "ZLAdvertView.h"
#import "ZLAdvertViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        // //显示沙盒路径
//                NSArray * pathsa =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                NSLog(@"沙盒路径:%@",pathsa);

    [self jsonParse];//加载APP开机广告图
    //方法一：调用Main_TableViewController创建根视图
    // 1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    // 2.设置窗口的根控制器
    Main_UITabBarController *main = [[Main_UITabBarController alloc]init];
    self.window.rootViewController = main;



    // 3.显示窗口
    [self.window makeKeyAndVisible];
   
  //  [self root];
    //[self jsonParse];//加载APP开机广告图,放在Main_UITabBarController.m
    // 设置启动页广告
    [self setupAdvert];
    

    
    return YES;
}


//方法二：直接系AppDelegate创建根视图
-(void)root
{
    
    //1.创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    //a.初始化一个tabBar控制器
    UITabBarController *tb=[[UITabBarController alloc]init];
    //设置控制器为Window的根控制器
    self.window.rootViewController=tb;
    
    //b.创建子控制器
    UIViewController *c1=[[UIViewController alloc]init];
    c1.view.backgroundColor=[UIColor grayColor];
    c1.tabBarItem.title=@"首页";
    c1.tabBarItem.image=[UIImage imageNamed:@"main_ico_n"];
    c1.tabBarItem.badgeValue=@"12";
    
    UIViewController *c2=[[UIViewController alloc]init];
    c2.view.backgroundColor=[UIColor brownColor];
    c2.tabBarItem.title=@"游戏";
    c2.tabBarItem.image=[UIImage imageNamed:@"game_ico_n"];
    
    UIViewController *c3=[[UIViewController alloc]init];
    c3.view.backgroundColor=[UIColor orangeColor];
    c3.tabBarItem.title=@"聊天";
    c3.tabBarItem.image=[UIImage imageNamed:@"talk_ico_n"];
    
    UIViewController *c4=[[UIViewController alloc]init];
    c4.view.backgroundColor=[UIColor magentaColor];
    c4.tabBarItem.title=@"设置";
    c4.tabBarItem.image=[UIImage imageNamed:@"user_ico_n"];
    
    
    //c.添加子控制器到ITabBarController中
    //c.1第一种方式
    //    [tb addChildViewController:c1];
    //    [tb addChildViewController:c2];
    
    //c.2第二种方式
    tb.viewControllers=@[c1,c2,c3,c4];
    
    
    //2.设置Window为主窗口并显示出来
    [self.window makeKeyAndVisible];
    
    
    
}


/**
 *  设置启动页广告
 */
- (void)setupAdvert {
    
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
    
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (isExist) { // 图片存在
        
        ZLAdvertView *advertView = [[ZLAdvertView alloc] initWithFrame:self.window.bounds];
        advertView.filePath = filePath;
        [advertView show];
    }
    
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [self getAdvertisingImage];
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}




/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage {

    
    // TODO 请求广告接口
    // 这里原本应该采用广告接口，现在用一些固定的网络图片url代替

    if (_Root_Advertise != nil && ![_Root_Advertise isKindOfClass:[NSNull class]] && _Root_Advertise.count != 0) {
        NSArray *array = _Root_Advertise[arc4random() % _Root_Advertise.count];

        
           
           NSString *imageUrla = [array valueForKey:@"pic_url"];
           _linkUrl = [array valueForKey:@"id"];
           
           NSString *imageUrl = [APIURL stringByAppendingString:imageUrla];;

           NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
           NSString *imageName = stringArr.lastObject;
       
           //NSLog(@"%@",imageName);
           //NSLog(@"%@",_linkUrl);

           // 拼接沙盒路径
           NSString *filePath = [self getFilePathWithImageName:imageName];
           BOOL isExist = [self isFileExistWithFilePath:filePath];
           if (!isExist){ // 如果该图片不存在，则删除老图片，下载新图片
               
               [self downloadAdImageWithUrl:imageUrl imageName:imageName];
           }
    }else
    {
       // NSLog(@"后台没有设置显示开关");

    }
   
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName {
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];

        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称

        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            //NSLog(@"保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
            
             //将id或连接地址写入沙盒
             NSArray *array_L = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             NSString *documents = [array_L lastObject];
                       NSString *documnetPath = [documents stringByAppendingPathComponent:@"AD.plist"];
             //准备要存入的字典
             NSDictionary *dic_notice = [NSDictionary dictionaryWithObjectsAndKeys:self->_linkUrl,@"id",nil ];
            
             [dic_notice writeToFile:documnetPath atomically:YES];

            
        }else{
            NSLog(@"保存失败");
        }
    
       
                 });

}

/**
 *  删除旧图片
 */
- (void)deleteOldImage {
    
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName {
    
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
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
             self->_Root_Advertise = [array valueForKey:@"Root_Advertise"];//公告信息5条

             self->_IDs = [self->_Root_Advertise valueForKeyPath:@"id"];
             self->_Ad_url = [self->_Root_Advertise valueForKey:@"pic_url" ];
             //NSLog(@"%@",self->_Ad_url);


           
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
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
