//
//  Another_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/25.
//  Copyright © 2020 guo feng zou. All rights reserved.
// 呢称或商家名称

#import "Another_ViewController.h"
#import <objc/runtime.h>
@interface Another_ViewController ()

@end

@implementation Another_ViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self Sharea];
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
    _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
     
    _tableV.delegate=self;
    _tableV.dataSource=self;
      //----隐藏滚动条
    self.tableV.showsVerticalScrollIndicator = NO;
    //---滚动条修改颜色
    //self.tableV.indicatorStyle=UIScrollViewIndicatorStyleBlack;
    [self.view addSubview:_tableV];
    [self Nav_UI];
    //以下两种方法为UITextField 光标颜色
    //username.tintColor = [UIColor redColor];//指定UITextField
    [[UITextField appearance] setTintColor:[UIColor orangeColor]];//全局
    //点击空白处隐藏键盘
    [self KeyBoardHide_Yc];
    [self Quit_btn];
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
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-45, (89-20)/2+10, 90, 40)];
     [title setText:@"修改呢称"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;

}


//显示每一行的数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{
    
    static NSString * settingIdentifier=@"topbar";//这个是在没有自定议情况下的类
    
    //以下是当超过全屏时，会调用以下语句
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentifier];//获取一个类
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingIdentifier];

    tableView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:16];//设置文本字体与大小
    cell.textLabel.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    cell.backgroundColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//详细箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色


    
    //---------
    
     if (indexPath.section == 0)
    {
       
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"用户呢称"];
            Another = [[UITextField alloc]initWithFrame:CGRectMake(130,10,200, 40)];
            Another.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
            Another.delegate = self;//限制输入字符,配合方法才能使用
            Another.text =_Another_type;

            if (_Another_type == NULL || [_Another_type isEqualToString:@""]) {
                            //占位符颜色
                NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
                NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请输入你的呢称" attributes:attDicA];
                Another.attributedPlaceholder = attPlaceA;
                [cell.contentView addSubview: Another];
            }
            else
            {
                            //占位符颜色
                NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
                NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:_Another_type attributes:attDicA];
                Another.attributedPlaceholder = attPlaceA;
                [cell.contentView addSubview: Another];
            }

 
        }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"短信认证"];
            Code = [[UITextField alloc]initWithFrame:CGRectMake(130,10,200, 40)];
            Code.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
            //password.placeholder = @" 请输入登陆密码";
            //占位符颜色
            NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
            NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请输入短信码" attributes:attDicA];
            Code.attributedPlaceholder = attPlaceA;
            [cell.contentView addSubview: Code];
            
            
            //手机验证码
            Mmeages = [[UIButton alloc]initWithFrame:CGRectMake(0,0,80, 20)];
            //Mmeages.backgroundColor = [UIColor grayColor];
            [Mmeages setTitle:@"获取验证码" forState:(UIControlStateNormal)];
            //Mmeages.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            Mmeages.titleLabel.font = [UIFont systemFontOfSize:14];
            [Mmeages setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:(UIControlStateNormal)];
            [Mmeages addTarget:self action:@selector(getButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = Mmeages;

          
         }
     
       }

        //-----------
        //UITableView去掉自带系统的分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //自定义分割线
        UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 59, self.view.frame.size.width, 0.5)];
        VC.backgroundColor = RGBA(239, 239, 244, 1);
        [cell.contentView addSubview:VC];

    

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//行间距离（108）
{
    
    return 60;
    
}
////顶部距离
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    NSLog(@"执行");
//    return 24.f;//配合“  _tableV.sectionHeaderHeight = 0;”才生效
//
//}

//iOS 11 TableView heightForFooter 设置Header高度无效解决方法
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     //   NSLog(@"执行");
 
     //------TableView顶间距
    _tableV.sectionHeaderHeight = 50;
    return [[UIView alloc]init]; //_tableV.sectionHeaderHeight = 50;”才生效
    
  
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath


{
    
    //取消选中后的蓝色背景
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section)
    {
        case 0:
            
        {
            
            if (indexPath.row == 0)
            {
                
                

            }
            if (indexPath.row == 1)
            {
                

                           
            }


    
            break;
        }

        
    }
}
-(void)Quit_btn
{

    //底部提交按钮
    _Foot_tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,70)style:UITableViewStyleGrouped];
    _Foot_tableView.backgroundColor = [UIColor whiteColor];
    self.tableV.tableFooterView=_Foot_tableView;
    
    
    UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/30, 20, ScreenWidth-25, 40)];
    [Qbutton setTitle:@"提交修改" forState:UIControlStateNormal];
    [Qbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Qbutton.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    [Qbutton addTarget:self action:@selector(Edit_password) forControlEvents:UIControlEventTouchUpInside];
    [self.Foot_tableView addSubview:Qbutton];

}
-(void)Edit_password
{
   

    if ([Another.text isEqualToString:@""] ) {
                
       HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"呢称不能为空！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.tableV animated:YES];
             
       return;
        
    }
    //判断UserName少于6个字符
    if (Another_lengt < 3) {
                   
       HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"呢称不能少于6！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.tableV animated:YES];
                
       return;
           
       }
  
    if ([Code.text isEqualToString:@""] ) {
                
       HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"验证码不能为空！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.tableV animated:YES];
             
       return;
        
    }
    
      //打开沙盒
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [array lastObject];
    NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
    
  
    //用户呢称信息存入沙盒
    NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
    [dic_notice setObject:Another.text forKey:@"Another"];
    //准备要添加存入的字典
    [dic_notice writeToFile:documnetPath atomically:YES];
     

    //----------------------------------------
    //取沙盒用户信息
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    NSString * username = [dic objectForKey:@"username"];

    
    //创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *UserApi=APIURL_USER;
       
    NSURL *url = [NSURL URLWithString:UserApi];
    NSString * Urladd =[NSString stringWithFormat:@"action=edit_Another&username=%@&Another=%@",username,Another.text];
    //NSLog(@"URL==%@",Urladd);
            
       
         
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //设置request
    request.HTTPMethod = @"POST" ;
       
    NSData *data=[Urladd dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    //创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (!error )
             {
                 
               
                 
             NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                   
                //修改状态，返回failure或success
                //1008 修改成功 ，1009 修改失败 ，
                NSString *status = [dict objectForKey:@"status"];
                NSString *code = [dict objectForKey:@"code"];
                if ([status isEqualToString:@"failure"])
                {
                    
                NSLog(@"失败==%@",status);
                NSLog(@"失败代码==%@",code);
                    
//                self->HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
//                //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                self->HUD.label.text = @"修改失败！";
//                self->HUD.minSize = CGSizeMake(100, 10);
//                self-> HUD.contentColor = [UIColor whiteColor];
//                self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
//                [MBProgressHUD hideHUDForView:self.tableV animated:YES];
//                return;
                                 
                                        
                 }
          
                              
                  else {
                 
                       //修改状态，返回failure或success
                       //1008 修改成功 ，1009 修改失败 ，
                 NSString *status = [dict objectForKey:@"status"];
                 //NSString *code = [dict objectForKey:@"code"];
                 if ([status isEqualToString:@"success"])
                 {

                  //NSLog(@"成功==%@",status);
                  //NSLog(@"成功代码==%@",code);
                                     

                            
                  }
                
               
                       }
             }
             else
                 
             {
                 NSLog(@"error is :%@",error.localizedDescription);
               
              
             }
        
             }];
          
         //开始任务

       
         [task resume];
       
         [self CheckNet];

}

-(void)stuaus
{
    
    HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
    //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
    HUD.label.text = @"呢称修改成功！";
    //HUD.minSize = CGSizeMake(100, 10);
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
   
    //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
         [self left]; //事件
    [MBProgressHUD hideHUDForView:self.tableV animated:YES];
        
   
     });
    

       

}

//关闭调用

- (void)left
{
    [self.navigationController popViewControllerAnimated:YES];
 
    
   
}

   //点击空白处隐藏键盘
-(void)KeyBoardHide_Yc
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{

    [Another resignFirstResponder];
    [Code resignFirstResponder];
 
}
//，限制username最长为11个字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //
   
    if (textField == Another) {
    if (textField.text.length > 10 && string.length > 0) return NO;
    }

    //获取New_Password输入的长度，
    NSString * user_lengt = [Another.text stringByReplacingCharactersInRange:range withString:string];
    Another_lengt = [[NSString stringWithFormat:@"%lu",(unsigned long)user_lengt.length] intValue];
   
    
    
        
    ////监听username输入事件
    //    if (username.text.length <6)
    //
    //        {
    //         HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
    //         HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
    //         HUD.label.text = @"不能少于6个字符！";
    //         HUD.minSize = CGSizeMake(180, 10);
    //         HUD.contentColor = [UIColor whiteColor];
    //         HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
    //        [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
    //
    //
    // }
    
    return YES;

}
#pragma mark - 获取验证码
- (IBAction)getButtonClick:(UIButton *)sender
{
        //取沙盒用户信息
        NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [documentsPathArr lastObject];
        NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
        type = [dic objectForKey:@"type"];

    
   
     if ([type isEqualToString:@"0"]) {
         HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
         //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
         HUD.label.text = @"你还没有登陆";
         HUD.minSize = CGSizeMake(100, 10);
         HUD.contentColor = [UIColor whiteColor];
         HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
         HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
         [MBProgressHUD hideHUDForView:self.tableV animated:YES];
          
         return;
     }else{
         
         //请求外网手机发送验证码
         //NSLog(@"22");
     }


          //正常状态下的背景颜色
          //UIColor *mainColor = [UIColor redColor];
          //倒计时状态下背景的颜色
          //UIColor *countColor = [UIColor lightGrayColor];
         //倒计时状态下字体颜色
         UIColor *titlecolor = [UIColor lightGrayColor];
         //倒计时完成后字体的颜色
         UIColor *titlecolorED = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         [self setTheCountdownButton:sender startWithTime:10 title:@"获取验证码"countDownTitle:@"s"mainColor:nil countColor:nil titlecolor:titlecolor titlecolorED:titlecolorED];
     }

     

      #pragma mark - button倒计时
     - (void)setTheCountdownButton:(UIButton *)button startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color titlecolor:(UIColor *)titlecolor titlecolorED:(UIColor *)titlecolorED {
          //倒计时时间
          __block NSInteger timeOut = timeLine;
         dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
         dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
         //每秒执行一次
         dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
         dispatch_source_set_event_handler(_timer, ^{

             //倒计时结束，关闭
             if (timeOut == 0) {
                 dispatch_source_cancel(_timer);
                 dispatch_async(dispatch_get_main_queue(), ^{
                     button.backgroundColor = mColor;
                     [button setTitle:title forState:UIControlStateNormal];
                     [button setTitleColor:titlecolorED forState:UIControlStateNormal];
                     button.userInteractionEnabled =YES;
                  });
             } else {
                 int seconds = timeOut % 60;
                  NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
                  dispatch_async(dispatch_get_main_queue(), ^{
                     button.backgroundColor = color;
                     [button setTitleColor:titlecolor forState:UIControlStateNormal];
                     [button setTitle:[NSString stringWithFormat:@"请销候(%@%@)",timeStr,subTitle]forState:UIControlStateNormal];
                     button.userInteractionEnabled =NO;
                 });
                 
                 timeOut--;
              }
         });
         
         dispatch_resume(_timer);
         
     }
-(void)CheckNet
{
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 0.5;//请求时间
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=1&type=1"];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
   
      [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
           
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             // NSLog(@"请求成功%@", responseObject);
             [self stuaus];//有网络执行弹窗
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //  NSLog(@"请求失败");
          
               self->HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
               //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
               self->HUD.label.text = @"网络未连接服务器";
               self->HUD.minSize = CGSizeMake(100, 10);
               self->HUD.contentColor = [UIColor whiteColor];
               self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
               self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
               [MBProgressHUD hideHUDForView:self.tableV animated:YES];
                
               return;
 

        }];
}


@end
