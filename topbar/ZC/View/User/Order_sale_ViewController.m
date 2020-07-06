//
//  Order_sale_ViewController.m
//  topbar
//
//  Created by topbar on 2020/4/15.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Order_sale_ViewController.h"
#import "Hy_order_ViewController.h"
#import "Hy_order_s_ViewController.h"
@interface Order_sale_ViewController ()

@end

@implementation Order_sale_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];



    [self Sharea];
    
   // [self begin]; 数据由 viewWillAppear加载完成


}
-(void)Sharea
{
         //----右滑手势解决
//   self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//
//            //给导航条设置一个空的背景图 使其透明化
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//
//            //去除导航条透明后导航条下的黑线
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
     
     //设置导航控制器的代理(隐藏顶部-nav)
    self.navigationController.delegate = self;
    
      
      ///设置窗口大小
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, self.view.bounds.size.height-89) style:UITableViewStyleGrouped];
    //_tableView.backgroundColor=[UIColor whiteColor];
     
    _tableView.delegate=self;
    _tableView.dataSource=self;
      //----隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //---滚动条修改颜色
    //self.tableV.indicatorStyle=UIScrollViewIndicatorStyleBlack;
    [self.view addSubview:_tableView];
    
    self.headerBackView= [[UITableView alloc]initWithFrame:CGRectMake(0, 89,self.view.bounds.size.width,240)style:UITableViewStyleGrouped];
    //self.headerBackView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = self.headerBackView;
    [self header_order];
    [self Nav_UI];
    [self begin];
    //以下两种方法为UITextField 光标颜色
    //username.tintColor = [UIColor redColor];//指定UITextField
    [[UITextField appearance] setTintColor:[UIColor orangeColor]];//全局

//    NSArray * pathsa =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSLog(@"沙盒路径:%@",pathsa);

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
     [Button_Left addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:Button_Left];
     //-----居中的title
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-45, (89-20)/2+10, 200, 40)];
     //[title setText:_Another];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];


}
-(void)header_order
{
    
        //------------------------
        UIView * HeadPic= [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 240)];
        HeadPic.backgroundColor = [UIColor whiteColor];
    //----
         UIButton *Cunta = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/20, 37, 40, 40)];
        // [Cunta setImage:[UIImage imageNamed:@"Add_P"] forState:UIControlStateNormal];
         //[CC addTarget:self action:@selector(Action_order) forControlEvents:UIControlEventTouchUpInside];
         NSString *originalStr = _Another;
         //下标之间的子字符串：第一个参数为开始下标，第二个参数为长度
         NSString *subStr = [originalStr substringWithRange:NSMakeRange(0, 1)];

         [Cunta setTitle:subStr forState:UIControlStateNormal];
         //设置圆角
         Cunta.layer.cornerRadius = Cunta.frame.size.width / 2;;
         //将多余的部分切掉
         Cunta.layer.masksToBounds = YES;
    
         Cunta.titleLabel.font = [UIFont systemFontOfSize: 16.0];
         [Cunta setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         Cunta.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.8];
         
        
            
         [HeadPic addSubview:Cunta];
    //---------
         UILabel *Tatol_A = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20+50, 25, 200, 40)];
         Tatol_A.textColor= [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
         Tatol_A.font=[UIFont systemFontOfSize:18];
         Tatol_A.text = _Another;
    
         [HeadPic addSubview:Tatol_A];
    
    //-------
        UILabel *Tatol_B = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20+50, 48, 250, 40)];
        Tatol_B.textColor= [UIColor colorWithRed:127.0/255 green:145.1/255 blue:159.0/255 alpha:1];
        Tatol_B.font=[UIFont systemFontOfSize:13];
        //Tatol_B.text = _Another;
      //创建富文本
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: @"加V用户 | 注册时间2020-03-16"];
        //NSTextAttachment可以将要插入的图片作为特殊字符处理
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        //定义图片内容及位置和大小
        attch.image = [UIImage imageNamed:@"shine"];
        attch.bounds = CGRectMake(0, -4,20, 20);
        //创建带有图片的富文本
        NSAttributedString *stringA = [NSAttributedString attributedStringWithAttachment:attch];
        //将图片放在最后一位
        //[attri appendAttributedString:stringA];
        //将图片放在第一位
        [attri insertAttributedString:stringA atIndex:0];
        //用label的attributedText属性来使用富文本
        Tatol_B.attributedText = attri;
    
        [HeadPic addSubview:Tatol_B];
    
    //---------
         UILabel * Pro_lable = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 85, 50, 50)];
         Pro_lable.text = @"总成单";
         Pro_lable.font = [UIFont systemFontOfSize:13];
         Pro_lable.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.3];
         [HeadPic addSubview:Pro_lable];
    
         UILabel * Pri_A = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 82, 60, 50)];
         Pri_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         Pri_A.font = [UIFont systemFontOfSize:15];
         int Vol_X = arc4random() % 10000;//成功交易单数，10000是生成千位以内的数
         Pri_A.text  = [NSString stringWithFormat:@"%d%@",Vol_X,@"次"];
              
         //Pri_A.text = @"3175次";

        
         [HeadPic addSubview:Pri_A];
    //---------
         UILabel * Vol_lable = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 120, 60, 50)];
         Vol_lable.text = @"30日成单";
         Vol_lable.font = [UIFont systemFontOfSize:13];
         Vol_lable.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.3];
         [HeadPic addSubview:Vol_lable];
    
         UILabel * Vol_A = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 117, 60, 50)];
         Vol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         Vol_A.font = [UIFont systemFontOfSize:15];
         int Vol_NUM = arc4random() % 10000;//成功交易单数，10000是生成千位以内的数
         Vol_A.text = [NSString stringWithFormat:@"%d%@",Vol_NUM,@"次"];
         //Vol_A .text = @"3176次";

    
         [HeadPic addSubview:Vol_A];
    //---------
         UILabel * Pro_lableA = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.8, 85, 50, 50)];
         Pro_lableA.text = @"完成率";
         Pro_lableA.font = [UIFont systemFontOfSize:13];
         Pro_lableA.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2];
         [HeadPic addSubview:Pro_lableA];
    
         UILabel * Pri_B = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.45, 82, 100, 50)];
         Pri_B.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         Pri_B.font = [UIFont systemFontOfSize:15];
         //Pri_B.backgroundColor  =  [UIColor orangeColor];
         Pri_B.textAlignment = NSTextAlignmentRight;
         int Vol_Ix = arc4random() % 10+90;//成功交易率，100是生成百位以内的数
         Pri_B.text = [NSString stringWithFormat:@"%d%@",Vol_Ix,@"%"];

        
         [HeadPic addSubview:Pri_B];
    //---------
         UILabel * Vol_lableA = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.8, 120, 60, 50)];
         Vol_lableA.text = @"平均放行";
         Vol_lableA.font = [UIFont systemFontOfSize:13];
         Vol_lableA.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2];
         [HeadPic addSubview:Vol_lableA];
    
         UILabel * Vol_B = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.45, 115, 100, 50)];
         Vol_B.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         Vol_B.font = [UIFont systemFontOfSize:15];
         //Vol_B.backgroundColor  =  [UIColor orangeColor];
         Vol_B.textAlignment = NSTextAlignmentRight;
          int Vol_Ip = arc4random() % 100;//成功交易率，100是生成百位以内的数
         Vol_B .text = [NSString stringWithFormat:@"0.%d%@",Vol_Ip,@"分钟"];

    
         [HeadPic addSubview:Vol_B];
    
    //--------
         UIView * line  = [[UIView alloc]initWithFrame:CGRectMake(0, 115+50+10, ScreenWidth, 1)];
         line.backgroundColor = [UIColor  colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
         [HeadPic addSubview:line];

    //-------
        UILabel *line_B = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 115+50+10+5, 100, 40)];
        line_B.textColor= [UIColor colorWithRed:127.0/255 green:145.1/255 blue:159.0/255 alpha:1];
        line_B.font=[UIFont systemFontOfSize:13];
        //创建富文本
        NSMutableAttributedString *attriB = [[NSMutableAttributedString alloc] initWithString: @"邮箱认证"];
        //NSTextAttachment可以将要插入的图片作为特殊字符处理
        NSTextAttachment *attchB = [[NSTextAttachment alloc] init];
        //定义图片内容及位置和大小
        attchB.image = [UIImage imageNamed:@"V"];
        attchB.bounds = CGRectMake(4, -2,14, 14);
        //创建带有图片的富文本
        NSAttributedString *stringB = [NSAttributedString attributedStringWithAttachment:attchB];
        //将图片放在最后一位
        [attriB appendAttributedString:stringB];
        //将图片放在第一位
        //[attri insertAttributedString:stringB atIndex:0];
        //用label的attributedText属性来使用富文本
        line_B.attributedText = attriB;
    
        [HeadPic addSubview:line_B];
    
    //-------
        UILabel *line_C = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3.5, 115+50+10+5, 100, 40)];
        line_C.textColor= [UIColor colorWithRed:127.0/255 green:145.1/255 blue:159.0/255 alpha:1];
        line_C.font=[UIFont systemFontOfSize:13];
        //创建富文本
        NSMutableAttributedString *attriC = [[NSMutableAttributedString alloc] initWithString: @"手机认证"];
        //NSTextAttachment可以将要插入的图片作为特殊字符处理
        NSTextAttachment *attchC = [[NSTextAttachment alloc] init];
        //定义图片内容及位置和大小
        attchC.image = [UIImage imageNamed:@"V"];
        attchC.bounds = CGRectMake(4, -2,14, 14);
        //创建带有图片的富文本
        NSAttributedString *stringC = [NSAttributedString attributedStringWithAttachment:attchC];
        //将图片放在最后一位
        [attriC appendAttributedString:stringC];
        //将图片放在第一位
        //[attri insertAttributedString:stringB atIndex:0];
        //用label的attributedText属性来使用富文本
        line_C.attributedText = attriC;
    
        [HeadPic addSubview:line_C];
    //-------
        UILabel *line_D = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.9, 115+50+10+5, 100, 40)];
        line_D.textColor= [UIColor colorWithRed:127.0/255 green:145.1/255 blue:159.0/255 alpha:1];
        line_D.font=[UIFont systemFontOfSize:13];
        //创建富文本
        NSMutableAttributedString *attriD = [[NSMutableAttributedString alloc] initWithString: @"身份认证"];
        //NSTextAttachment可以将要插入的图片作为特殊字符处理
        NSTextAttachment *attchD = [[NSTextAttachment alloc] init];
        //定义图片内容及位置和大小
        attchD.image = [UIImage imageNamed:@"V"];
        attchD.bounds = CGRectMake(4, -2,14, 14);
        //创建带有图片的富文本
        NSAttributedString *stringD = [NSAttributedString attributedStringWithAttachment:attchD];
        //将图片放在最后一位
        [attriD appendAttributedString:stringD];
        //将图片放在第一位
        //[attri insertAttributedString:stringB atIndex:0];
        //用label的attributedText属性来使用富文本
        line_D.attributedText = attriD;
    
        [HeadPic addSubview:line_D];
    
    //-------
        UILabel *line_E = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.3, 115+50+10+5, 100, 40)];
        line_E.textColor= [UIColor colorWithRed:127.0/255 green:145.1/255 blue:159.0/255 alpha:1];
        line_E.font=[UIFont systemFontOfSize:13];
        //创建富文本
        NSMutableAttributedString *attriE = [[NSMutableAttributedString alloc] initWithString: @"高级认证"];
        //NSTextAttachment可以将要插入的图片作为特殊字符处理
        NSTextAttachment *attchE = [[NSTextAttachment alloc] init];
        //定义图片内容及位置和大小
        attchE.image = [UIImage imageNamed:@"V"];
        attchE.bounds = CGRectMake(4, -2,14, 14);
        //创建带有图片的富文本
        NSAttributedString *stringE = [NSAttributedString attributedStringWithAttachment:attchE];
        //将图片放在最后一位
        [attriE appendAttributedString:stringE];
        //将图片放在第一位
        //[attri insertAttributedString:stringB atIndex:0];
        //用label的attributedText属性来使用富文本
        line_E.attributedText = attriE;
    
        [HeadPic addSubview:line_E];
    //--------
         UIView * lineA  = [[UIView alloc]initWithFrame:CGRectMake(0, 115+50+10+10+40, ScreenWidth, 10)];
         lineA.backgroundColor = [UIColor  colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.1];
         [HeadPic addSubview:lineA];
    
         // [self.view addSubview:HeadPic];
         [self.headerBackView addSubview:HeadPic];
        
        
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{
    
        //创建session对象
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *UserApi=APIURL_USDT;
           
        NSURL *url = [NSURL URLWithString:UserApi];
        NSString * Urladd =[NSString stringWithFormat:@"action=goumai_list&username=%@&type=0",_username];
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
          
               NSMutableArray * array = [dic objectForKey:@"Megss"];
               //NSLog(@"%@",array);
                 
//                 //if (dic == (NULL))
//                 if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
//                               //主线程
//                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                         self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//                         self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                         self->HUD.label.text = @"数据加载成功";
//                         //self->HUD.minSize = CGSizeMake(100, 10);
//                         self->HUD.offset = CGPointMake(0, -300);
//                         self->HUD.contentColor = [UIColor whiteColor];
//                         self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
//                         self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
//                         [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//
//                         return;
//
//
//                     });
//                 } else {
//                               //主线程
//                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                         self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//                         self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                         self->HUD.label.text = @"数据加载失败";
//                         //self->HUD.minSize = CGSizeMake(100, 10);
//                         self->HUD.offset = CGPointMake(0, -300);
//                         self->HUD.contentColor = [UIColor whiteColor];
//                         self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
//                         self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
//                         [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//
//                         return;
//
//
//                     });
//                 }
                 
                 
                 
                 
                 
                 
                 
                 
                 
               //将数组中的字典数据都转换成模型
               self.dataArr=[Transaction_NS mj_objectArrayWithKeyValuesArray:array];
               //由于NSURLSession处理任务的操作默认都是在子线程中进行的，而像刷新数据设置图片这种操作必须在主线程中进行，因此必须进行线程间的通信，转到主队列，执行UI操作
               //NSLog(@"===%@",array);
               //NSLog(@"%@",self->_dataArr);
               [[NSOperationQueue mainQueue]addOperationWithBlock:^{
               [self.tableView reloadData];
               [self.tableView.mj_header endRefreshing];
             }];
               
               
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


////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParseA{
    
        //创建session对象
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *UserApi=APIURL_USDT;
           
        NSURL *url = [NSURL URLWithString:UserApi];
        NSString * Urladd =[NSString stringWithFormat:@"action=goumai_list&username=%@&type=1",_username];
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
          
               NSMutableArray * array = [dic objectForKey:@"Megss"];
               //NSLog(@"AA==%@",array);
                 
//                 //if (dic == (NULL))
//                 if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
//                               //主线程
//                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                         self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//                         self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                         self->HUD.label.text = @"数据加载成功";
//                         //self->HUD.minSize = CGSizeMake(100, 10);
//                         self->HUD.offset = CGPointMake(0, -300);
//                         self->HUD.contentColor = [UIColor whiteColor];
//                         self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
//                         self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
//                         [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//
//                         return;
//
//
//                     });
//                 } else {
//                               //主线程
//                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                         self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//                         self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                         self->HUD.label.text = @"数据加载失败";
//                         //self->HUD.minSize = CGSizeMake(100, 10);
//                         self->HUD.offset = CGPointMake(0, -300);
//                         self->HUD.contentColor = [UIColor whiteColor];
//                         self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
//                         self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
//                         [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//
//                         return;
//
//
//                     });
//                 }
                 
                 
                 
                 
                 
                 
                 
                 
                 
               //将数组中的字典数据都转换成模型
               self.dataArrA=[Transaction_NS mj_objectArrayWithKeyValuesArray:array];
               //由于NSURLSession处理任务的操作默认都是在子线程中进行的，而像刷新数据设置图片这种操作必须在主线程中进行，因此必须进行线程间的通信，转到主队列，执行UI操作
               //NSLog(@"===%@",array);
               //NSLog(@"%@",self->_dataArr);
               [[NSOperationQueue mainQueue]addOperationWithBlock:^{
               [self.tableView reloadData];
               [self.tableView.mj_header endRefreshing];
             }];
               
               
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




-(void)begin
{
#pragma mark -上拉、下拉功能显示
    
    
    // 下拉1样式有时间///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        [weakSelf loadNewData];
    //    }];
    //    // 马上进入刷新状态
    //    [self.tableView.mj_header beginRefreshing];
    //下拉2样式隐藏时间////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置header
    self.tableView.mj_header = header;
    

    
    
}
#pragma mark 下拉刷新数据
- (void)loadNewData
{

    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        //结束上拉刷新
        [self.tableView.mj_header endRefreshing];
        //currentPage = 1;//初始化
        
        
        [self jsonParse];//如果不添加重新请求（网址）JSON，数据不会随时下拉刷新
        [self jsonParseA];
        

        
        //第一次下拉时，刷新出3条数据，同时刷新上拉为还有更多字眼出现
        [self.tableView.mj_footer endRefreshing];
    

                   });
  
    
}

-(NSArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(NSArray *)dataArrA{
    if (_dataArrA==nil) {
        _dataArrA=[NSMutableArray array];
    }
    return _dataArrA;
}

//显示每一行的数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [tableView tableViewDisplayWitMsg:@"没有查询到相信息" ifNecessaryForRowCount:self.dataArr.count];
    //return self.dataArr.count;
    return 2;
    
}
//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        self.tableView.mj_footer.hidden = (self.dataArr.count == 0);
        return self.dataArr.count;
        
        
    }
   else  {
       self.tableView.mj_footer.hidden = (self.dataArr.count == 0);
       return self.dataArrA.count;
    }
//    self.tableView.mj_footer.hidden = (self.dataArr.count == 0);
//    return self.dataArr.count;

    
}
//显示每一行的数据

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{
 

    static NSString *CellIdentifier = @"CustomCell";
    Transaction_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    cell = [[Transaction_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色
    
    
    
    if (indexPath.section == 0 ) {
    
    // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
    Transaction_NS *item=self.dataArr[indexPath.row];
    //cell.username.text = @"行远币行";
    //cell.vol.text = item.vol;
    
    
    
    NSString * vols = [NSString stringWithFormat:@"数量 %@ %@",item.vol,item.Currency];
    cell.vol.text = vols;
    
    
    int NumA = [item.tatol intValue ];
    NSString *Adisplay = [NSNumberFormatter localizedStringFromNumber:@(NumA) numberStyle:NSNumberFormatterDecimalStyle];
    NSString * tatols = [NSString stringWithFormat:@"限额 ¥%@-¥%@",item.LimitA,Adisplay];
    cell.tatol.text = tatols ;
    

    
    //固定格式 NSNumberFormatterDecimalStyle可进入帮助文档查看更多
    //NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //formatter.numberStyle = NSNumberFormatterDecimalStyle;
    //NSString *num = item.pri;
    //NSNumber *result111 = [NSNumber numberWithDouble:num.doubleValue];
    //NSString *stringA = [formatter stringFromNumber:result111];
    //NSLog(@"--第一种转换后的格式是--- %@",stringA);
 
    
    //自定义格式
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    [moneyFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *num = item.pri;
    //NSLog(@"--第二种转换后的格式是--- %@",[moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]]);
    NSString * pris  = [moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]];
    cell.pri.text = [NSString stringWithFormat:@"¥%@",pris];
    
    

    int Vol_ID = arc4random() % 10+90;//成功交易率，100是生成百位以内的数
    int Vol_X = arc4random() % 10000;//成功交易单数，10000是生成千位以内的数
    cell.vol_A.text = [NSString stringWithFormat:@"%d | %d%@",Vol_X,Vol_ID,@"%"];
    //cell.vol_A.text = @"4232 | 99%" ;
    cell.pri_A.text = @"单价" ;
    
    if ([item.alipay isEqualToString:@"(null)"]) {
        cell.carpic.image = [UIImage imageNamed:@"weixin"];
    } else if([item.weixin isEqualToString:@"(null)"]) {
        cell.carpic.image = [UIImage imageNamed:@"alipay"];
    } else{
         cell.carpic.image = [UIImage imageNamed:@"alipay"];
         cell.carpicA.image = [UIImage imageNamed:@"weixin"];
    }
    
    //cell.goumai.text = @"购买";
    UILabel * chusou = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/3.8), 105, 85, 30)];
    chusou.backgroundColor = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
    chusou.text = @"购买";
    chusou.textAlignment = NSTextAlignmentCenter;
    chusou.textColor = [UIColor whiteColor];
    chusou.font = [UIFont boldSystemFontOfSize:15];
    [cell.contentView addSubview:chusou];
        
    cell.logo.image = [UIImage imageNamed:item.Currency];
    
    //创建富文本
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: item.Currency];
    //NSTextAttachment可以将要插入的图片作为特殊字符处理
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    //定义图片内容及位置和大小
    attch.image = [UIImage imageNamed:@"shine"];
    attch.bounds = CGRectMake(4, -4, 20, 20);
    //创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    //将图片放在最后一位
    [attri appendAttributedString:string];
    //将图片放在第一位
    //[attri insertAttributedString:string atIndex:0];
    //用label的attributedText属性来使用富文本
    cell.username.attributedText = attri;
    
    //[cell.FirstPics sd_setImageWithURL:[NSURL URLWithString:item.FirstPics]placeholderImage:[UIImage imageNamed:@"nopic.png"]];
    }else{
        
      // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
      Transaction_NS *item=self.dataArrA[indexPath.row];
      //cell.username.text = @"行远币行";
      //cell.vol.text = item.vol;
      
      
      NSString * vols = [NSString stringWithFormat:@"数量 %@ %@",item.vol,item.Currency];
      cell.vol.text = vols;
      
      
      int NumA = [item.tatol intValue ];
      NSString *Adisplay = [NSNumberFormatter localizedStringFromNumber:@(NumA) numberStyle:NSNumberFormatterDecimalStyle];
      NSString * tatols = [NSString stringWithFormat:@"限额 ¥%@-¥%@",item.LimitA,Adisplay];
      cell.tatol.text = tatols ;
      

      
      //固定格式 NSNumberFormatterDecimalStyle可进入帮助文档查看更多
      //NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
      //formatter.numberStyle = NSNumberFormatterDecimalStyle;
      //NSString *num = item.pri;
      //NSNumber *result111 = [NSNumber numberWithDouble:num.doubleValue];
      //NSString *stringA = [formatter stringFromNumber:result111];
      //NSLog(@"--第一种转换后的格式是--- %@",stringA);
   
      
      //自定义格式
      NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
      [moneyFormatter setPositiveFormat:@"###,##0.00;"];
      NSString *num = item.pri;
      //NSLog(@"--第二种转换后的格式是--- %@",[moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]]);
      NSString * pris  = [moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]];
      cell.pri.text = [NSString stringWithFormat:@"¥%@",pris];
      
      

      int Vol_ID = arc4random() % 10+90;//成功交易率，100是生成百位以内的数
      int Vol_X = arc4random() % 10000;//成功交易单数，10000是生成千位以内的数
      cell.vol_A.text = [NSString stringWithFormat:@"%d | %d%@",Vol_X,Vol_ID,@"%"];
      //cell.vol_A.text = @"4232 | 99%" ;
      cell.pri_A.text = @"单价" ;
      
      if ([item.alipay isEqualToString:@"(null)"]) {
          cell.carpic.image = [UIImage imageNamed:@"weixin"];
      } else if([item.weixin isEqualToString:@"(null)"]) {
          cell.carpic.image = [UIImage imageNamed:@"alipay"];
      } else{
           cell.carpic.image = [UIImage imageNamed:@"alipay"];
           cell.carpicA.image = [UIImage imageNamed:@"weixin"];

      }

        UILabel * chusou = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/3.8), 105, 85, 30)];
        chusou.backgroundColor = [UIColor brownColor];
        chusou.text = @"出售";
        chusou.textAlignment = NSTextAlignmentCenter;
        chusou.textColor = [UIColor whiteColor];
        chusou.font = [UIFont boldSystemFontOfSize:15];
        [cell.contentView addSubview:chusou];

       //cell.goumai.text = @"出售";

        
      cell.logo.image = [UIImage imageNamed:item.Currency];
      
      //创建富文本
      NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: item.Currency];
      //NSTextAttachment可以将要插入的图片作为特殊字符处理
      NSTextAttachment *attch = [[NSTextAttachment alloc] init];
      //定义图片内容及位置和大小
      attch.image = [UIImage imageNamed:@"shine"];
      attch.bounds = CGRectMake(4, -4, 20, 20);
      //创建带有图片的富文本
      NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
      //将图片放在最后一位
      [attri appendAttributedString:string];
      //将图片放在第一位
      //[attri insertAttributedString:string atIndex:0];
      //用label的attributedText属性来使用富文本
      cell.username.attributedText = attri;
      
      //[cell.FirstPics sd_setImageWithURL:[NSURL URLWithString:item.FirstPics]placeholderImage:[UIImage imageNamed:@"nopic.png"]];
    }
    
   
    
    
    
    
    //UITableView去掉自带系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //自定义分割线
    //    UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 10)];
    //    VC.backgroundColor = RGBA(245,245,245,1);
    //    [cell.contentView addSubview:VC];
    UIView * VC1 = [[UIView alloc]initWithFrame:CGRectMake(0, 143, self.view.frame.size.width, 1)];
    VC1.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [cell.contentView addSubview:VC1];
    
    
    
    return cell;
    
    
    
    
}
//顶部距离
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}



-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath//行间距离（108）
{
    
    // 一般cell的高度都需要根据内容来自适应高度，高度的变化就在此处根据indexPath来更改
    //    if(indexPath.row == 0)
    //    {
    //        return 100;
    //
    //    }
    return 144;
}
//iOS 11 TableView heightForFooter 设置Header高度无效解决方法
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     //   NSLog(@"执行");
 

    
    
       UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
       headerView.backgroundColor = [UIColor whiteColor];
       
       UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.view.bounds.size.width, 40)];
       
       tipLabel.numberOfLines = 0;
       tipLabel.textAlignment = NSTextAlignmentLeft;
       tipLabel.font = [UIFont systemFontOfSize:16];//设置文本字体与大小
       tipLabel.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    
       [headerView addSubview:tipLabel];
       
    
       //线条
       UILabel *tipLabela = [[UILabel alloc] initWithFrame:CGRectMake(0, 40+2, self.view.bounds.size.width, 1)];
       tipLabela.backgroundColor  = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];;
       [headerView addSubview:tipLabela];
       //tipLabel.text = [NSString stringWithFormat:@"section footer %d", section+1];
       
       
       
       
       if (section == 0) {
           tipLabel.text = @"在线出售";

       }
       
       if (section == 1) {
           tipLabel.text = @"在线购买";

           
      
       }

      
 
       
       return headerView;

    
     //------TableView顶间距
     // _tableV.sectionHeaderHeight = 50;
     //  return [[UIView alloc]init]; //_tableV.sectionHeaderHeight = 50;”才生效
    
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath


{
    //取沙盒用户信息
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    NSString  * type = [dic objectForKey:@"type"];
    if ([type isEqualToString:@"1"]) {

    
     if (indexPath.section == 0 )  {
        
         Hy_order_ViewController * vc = [[Hy_order_ViewController alloc]init];
         Transaction_NS *item=self.dataArr[indexPath.row];
        
         vc.Currency = item.Currency;//传币种
         vc.pri = item.pri;//传单价
         vc.tatol = item.tatol;//总金额
         vc.LimitA = item.LimitA;//限额
         vc.vol  = item.vol;//数量
         vc.alipay = item.alipay;
         vc.weixin  = item.weixin;
         vc.username = item.username;//
         vc.Another = item.Another;//买家/卖家名称
         vc.KYC = item.rzdj;//认证等级
         vc.conter = item.conter;//备注
         vc.black_A = _balck_A;
         
        

         [self.navigationController pushViewController:vc animated:YES];
    }
     else{
          Hy_order_s_ViewController * vc = [[Hy_order_s_ViewController alloc]init];
          Transaction_NS *item=self.dataArrA[indexPath.row];
         
          vc.Currency = item.Currency;//传币种
          vc.pri = item.pri;//传单价
          vc.tatol = item.tatol;//总金额
          vc.LimitA = item.LimitA;//限额
          vc.vol  = item.vol;//数量
          vc.alipay = item.alipay;
          vc.weixin  = item.weixin;
          vc.username = item.username;//
          vc.Another = item.Another;//买家/卖家名称
          vc.KYC = item.rzdj;//认证等级
          vc.conter = item.conter;//备注
          vc.black_A = _balck_A;
         

          [self.navigationController pushViewController:vc animated:YES];
         
     }
    }else{
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
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    // NSLog(@"2");
    //AudioServicesPlaySystemSound(SOUNDID);//文件类型
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动类型


}
//隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

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
- (void)left
{
    [self.navigationController popViewControllerAnimated:YES];
    
 
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

      //NSLog(@"1");
      //反回时顶部加一张白色背景图
      // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BgmBC"] forBarMetrics:UIBarMetricsDefault];
       // self.navigationController.navigationBarHidden= YES;
      self.navigationController.delegate = self;
   

}
@end
