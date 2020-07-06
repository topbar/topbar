//
//  Account_ViewController.m
//  topbar
//
//  Created by topbar on 2019/11/4.
//  Copyright © 2019 guo feng zou. All rights reserved.
//帐户中心

#import "Account_ViewController.h"
#import "QRcode_ViewController.h"
#import "LimitA _ViewController.h"
#import "Pay_ViewController.h"
#import "Edit_password_ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>//面容解锁用到


@interface Account_ViewController ()<TopbarTimerPickerViewDelegate>

@end

@implementation Account_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self Share];
//            NSArray * paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            NSLog(@"沙盒路径:%@",paths);
}

-(void)Share
{

      
      ///设置窗口大小
      _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
     
      _tableV.delegate=self;
      _tableV.dataSource=self;
      //----隐藏滚动条
      self.tableV.showsVerticalScrollIndicator = NO;
      //---滚动条修改颜色
      //self.tableV.indicatorStyle=UIScrollViewIndicatorStyleBlack;
      [self.view addSubview:_tableV];

      //----右滑手势解决
      self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
      //设置导航控制器的代理(隐藏顶部-nav)
      self.navigationController.delegate = self;
      [self Nav_UI];
      //加載地址选择器
      [self.view addSubview:self.AddPickerView];

     //---打开沙盒用户文件件
     NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsPath = [documentsPathArr lastObject];
     NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
     NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
             
     //---沙盒里用户信息选择时间
     _timeStr = [dic objectForKey:@"timeStr"];
     _AddressStr = [dic objectForKey:@"AddressStr"];
     _Mobi = [dic objectForKey:@"Mobi"];
     _Email = [dic objectForKey:@"Email"];
     _QRcode = [dic objectForKey:@"qrcode"];
     _LimitA =  [dic objectForKey:@"LimitA"];

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
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-45, (89-20)/2+10, 90, 40)];
     [title setText:@"帐户中心"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];
    

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}

//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0 )
          {
              return 5;
          }
       if (section == 1 )
       {
           return 3;
       }
       if (section ==2)
       {
           return 1;
       }
       
       else
       {
           return 1;
           
       }

}


//显示每一行的数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{
    
    static NSString * settingIdentifier=@"topbar";//这个是在没有自定议情况下的类
    
    //以下是当超过全屏时，会调用以下语句
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentifier];//获取一个类
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingIdentifier];

    tableView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];
    cell.textLabel.font = [UIFont italicSystemFontOfSize:16];//设置文本字体与大小
    cell.textLabel.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    cell.backgroundColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//详细箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色



    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
     if (indexPath.section == 0)
    {

        
        
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"手机"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            cell.detailTextLabel.text = _Mobi;
            cell.detailTextLabel.textColor =[UIColor orangeColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];

            
        }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"邮箱"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            cell.detailTextLabel.text = _Email;
            cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            

            
        }
        if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"出生"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            cell.detailTextLabel.text = _timeStr;
            cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
   
            

            
        }
        if (indexPath.row == 3)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"地区"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            cell.detailTextLabel.text = _AddressStr;
            cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            

            
        }
        
        if (indexPath.row == 4)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"谷歌身份证验器"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            cell.detailTextLabel.text = _QRcode;
            cell.detailTextLabel.textColor =[UIColor orangeColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];

 
        }
       
    }
        if (indexPath.section == 1)
       {
           if (indexPath.row == 0)
           {
               
               cell.textLabel.text = [NSString stringWithFormat:@"购买出售限额"];
               UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
               cell.accessoryView = imageView;
               cell.detailTextLabel.text = _LimitA;

               
           }
           if (indexPath.row == 1)
           {
               cell.textLabel.text = [NSString stringWithFormat:@"收款方式管理"];
               UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
               cell.accessoryView = imageView;

               
           }
           if (indexPath.row == 2)
           {
               cell.textLabel.text = [NSString stringWithFormat:@"法币资金密码"];
               UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
               cell.accessoryView = imageView;
               cell.detailTextLabel.text = @"修改";
               cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
               cell.detailTextLabel.font = [UIFont systemFontOfSize:14];

            
           }
          
       }
    
     if (indexPath.section == 2)
    {
//        if (indexPath.row == 0)
//        {
//            cell.textLabel.text = [NSString stringWithFormat:@"手势密码"];
//            UISlider * VC   = [[UISlider alloc]init];
//            VC.frame=CGRectMake(0,0, 60, 20);
//            cell.accessoryView = VC;
//
//
//
//
//        }
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"面容解销"];

            //---打开沙盒用户文件件
            NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [documentsPathArr lastObject];
            NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
            _UISwitch_type = [dic objectForKey:@"UISwitch_type"];
            
            
            UISwitch *Aswitch = [[UISwitch alloc]init];
            if ([_UISwitch_type  isEqualToString:@"1"] ) {
                Aswitch.on =YES;
            } else {
                Aswitch.on =NO;
            }
           
            [Aswitch addTarget:self action:@selector(Authentication) forControlEvents:(UIControlEventValueChanged)];
            cell.accessoryView = Aswitch;

            
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
//    
//    return 44.f;//配合“  _tableV.sectionHeaderHeight = 0;”才生效
//}
////尾部距离
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//
//    return 2.f;//配合“  _tableV.sectionHeaderHeight = 0;”才生效
//}

////脚视图高度
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10.0f;
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

                [self Mobi_Web];
          
                
            }
            if (indexPath.row == 1)
             {

                [self Email_Web];
                           
             }
            if (indexPath.row == 2)
             {

                 [self startTimeClick];
                           
             }
            if (indexPath.row == 3)
             {

                 [self.AddPickerView show];
     
                           
             }
             if (indexPath.row == 4)
             {

                 QRcode_ViewController * vc = [[QRcode_ViewController alloc]init];
                 [self.navigationController pushViewController:vc animated:YES];
            
                                  
              }
              break;
            
           case 1:
                      
             {
                      
             if (indexPath.row == 0)
             {

                LimitA__ViewController * vc = [[LimitA__ViewController alloc]init];
                vc.LimitA_type = _LimitA;
                [self.navigationController pushViewController:vc animated:YES];

                    
                          
             }
             if (indexPath.row == 1)
             {

                 Pay_ViewController * vc = [[Pay_ViewController alloc]init];
                 [self.navigationController pushViewController:vc animated:YES];

                        
                              
              }
            if (indexPath.row == 2)
            {

                Edit_password_ViewController * vc = [[Edit_password_ViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                            

                       
                             
             }
            
      }
            case 2:
                                 
             {
                                 
             if (indexPath.row == 1)
             {
             
             
             }

                            
          }
            
            break;
        }

        
    }
}


//----- 选择时间器
- (void)startTimeClick
{
    [_pickerView remove];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:_timeStr];
    
    _pickerView = [[TopbarTimerPickerView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO toolbarTitle:@"选择时间"];
    [_pickerView setDatePickerDateFormat:@"yyyy-MM-dd"];
    _pickerView.delegate = self;
    [_pickerView show];
  
}

//时间选择后取值
#pragma mark - ShuKeTimerPickerView Delegate
- (void)toobarDonBtnHaveClick:(TopbarTimerPickerView *)pickView resultString:(NSString *)resultString atIndexof:(NSInteger)indexRow
{
    //NSLog(@" ==== delegate => toobarDonBtnHaveClick 【%@】", resultString);
    _timeStr = resultString;
    
    //---打开沙盒用户文件件
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *documnetPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    
    
    NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
    [dic_notice setObject:resultString forKey:@"timeStr"];
               //准备要添加存入的字典
    [dic_notice writeToFile:documnetPath atomically:YES];
    [self Updata_birthday];
    [self DismissViewController];
    

}
- (void)toobarCancelBtn {
   // NSLog(@" ==== delegate => toobarCancelBtn");
}



//地址选择器
- (AddressPickerView *)AddPickerView{
    if (!_AddPickerView) {
        _AddPickerView = [[AddressPickerView alloc]init];
        _AddPickerView.delegate = self;
        [_AddPickerView setTitleHeight:50 pickerViewHeight:165];
        // 关闭默认支持打开上次的结果
        // _AddPickerView.isAutoOpenLast = NO;
    }
    return _AddPickerView;
}



#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    
   // NSLog(@"点击了取消按钮");
    [self.AddPickerView  hide];
}
//地区选择后取值
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
    
    self.AddressStr = [NSString stringWithFormat:@"%@-%@-%@",province,city,area];

    [self.AddPickerView  hide];
    
    //---打开沙盒用户文件件
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *documnetPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    
    
    NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
    [dic_notice setObject:_AddressStr forKey:@"AddressStr"];
               //准备要添加存入的字典
    [dic_notice writeToFile:documnetPath atomically:YES];
    [self Updata_area];
    [self DismissViewController];
    //NSLog(@"%@",_AddressStr);
}

-(void)Mobi_Web
{
        
    
        //打开沙盒
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [array lastObject];
        NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
     
    
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"手机号码" message:nil preferredStyle:
        UIAlertControllerStyleAlert];
        // 添加输入框 (注意:在UIAlertControllerStyleActionSheet样式下是不能添加下面这行代码的)
        [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField = [[UITextField alloc]init];
            //textField.placeholder = @"请输入手机";
           
        }];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 通过数组拿到textTF的值
            //NSLog(@"ok, %@", [[alertVc textFields] objectAtIndex:0].text);
            self->_Mobi  = [[alertVc textFields] objectAtIndex:0].text;
            //NSLog(@"%@",self->_Mobi);
            
            
            if ([self->_Mobi isEqualToString:@""]) {
                self->HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
                self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
                self->HUD.label.text = @"手机号码不能为空";
                //HUD.minSize = CGSizeMake(100, 10);
                self->HUD.offset = CGPointMake(0, -100);
                self->HUD.contentColor = [UIColor blackColor];
                self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
            [MBProgressHUD hideHUDForView:self.tableV animated:YES];
             
            return;
            }
            
            
            //手机信息存入沙盒
            
            NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
            [dic_notice setObject:self->_Mobi forKey:@"Mobi"];
            //准备要添加存入的字典
            [dic_notice writeToFile:documnetPath atomically:YES];
            [self Updata_tel];
            [self DismissViewController];
            
        }];
        UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
         // 添加行为
        [alertVc addAction:Cancel];
        [alertVc addAction:action];
      
        //alertCtl//-----UIAlertController弹出非常慢,将present的代码放在主线程中执行
       dispatch_async(dispatch_get_main_queue(), ^{
           
      [self presentViewController: alertVc animated: YES completion: nil];
          
    });
}

-(void)Email_Web
{

 
    PopView  = [[PopUP alloc]init];
    //三选其一显示
    [PopView showInView];//遮挡新建的view
    //[PopView coutomshowInView:self.view];
    //[PopView coutomshowInView:[UIApplication sharedApplication].keyWindow];
    
     __block Account_ViewController *blockSelf = self;//创建一个本地变量blockSelf，指向self，然后用结构体语法访问实例变量
     PopView.block = ^(NSString * text)
    {
       
//        NSString *email  =[[NSString alloc]init];
//        email = text;
          self->_Email = text;
            
        // NSLog(@"===%@",email);
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // Do something...
            [blockSelf Updata_email];
        [blockSelf DismissViewController];
            
    });
        
    };
  

}
-(void)Updata_tel
{
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
        NSString * Urladd =[NSString stringWithFormat:@"action=edit_tel&username=%@&tel=%@",username,_Mobi];
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
-(void)Updata_email
{
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
        NSString * Urladd =[NSString stringWithFormat:@"action=edit_email&username=%@&email=%@",username,_Email];
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
-(void)Updata_birthday
{
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
        NSString * Urladd =[NSString stringWithFormat:@"action=edit_birthday&username=%@&birthday=%@",username,_timeStr];
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
                    // NSString *code = [dict objectForKey:@"code"];
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
-(void)Updata_area
{
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
        NSString * Urladd =[NSString stringWithFormat:@"action=edit_area&username=%@&area=%@",username,_AddressStr];
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
-(void)stuaus
{
    
    HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
    //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
    HUD.label.text = @"修改成功！";
    //HUD.minSize = CGSizeMake(100, 10);
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
   
    //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        
    [MBProgressHUD hideHUDForView:self.tableV animated:YES];
        
   
     });

}
- (void)DismissViewController
{
  
     HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
//   HUD.mode = MBProgressHUDModeCustomView;
//   UIImage *image = [[UIImage imageNamed:@"checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//   HUD.customView = [[UIImageView alloc] initWithImage:image];
//   HUD.square = YES;
     HUD.label.text = NSLocalizedString(@"Done", @"HUD done title");
    
     HUD.contentColor = [UIColor whiteColor];
     HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
    

     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
         // Do something...
          // 刷除tableV,释放内存
//          [self.tableV removeFromSuperview];
//          [self.tableV.layer removeFromSuperlayer];
//          //  _tableV=nil;
//          [self Share];
         //一个section刷新
         NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];

         [self->_tableV reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
         
     [MBProgressHUD hideHUDForView:self.tableV animated:YES];
         
    
      });

}

////// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

}
- (void)left:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
   
}
//隐藏navigationBar/TabBar(顶部/底部)之后右滑手势失效解决
//- (void)viewWillAppear:(BOOL)animated{
//
//    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
//    self.tabBarController.tabBar.hidden=YES;//隐藏当前页及PUSH到下一个ViewController时隐藏底部导航
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
//    self.tabBarController.tabBar.hidden=NO;//返回上一级时会调用，传NO过上一级，则显示上一级底部Tab bar
//
//}




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
//-(void)switchAction:(UISwitch *)sender
//{
//    if (sender.on == YES) {
//        NSLog(@"123");
//        [self Authentication];
//    } else {
//        NSLog(@"321");
//    }
//}
-(void)Authentication
{
    
     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
           // Do something...
           //指定一个cell刷新
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
            [self->_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                
        });
    
       //NSLog(@"111");
       // NSLog(@"btn_type===%@",_Btn_type);
        //
  
        APopView  = [[Pop_rz alloc]init];
        APopView.type = @"4"; //传值，到底是认证时间还是认证等级，因为调用同一个窗口。 0 认证等级（默认）  、1 认证时间
        //三选其一显示
        [APopView showInView];//遮挡新建的view
        //[APopView coutomshowInView:self.view];
        //[PopView coutomshowInView:[UIApplication sharedApplication].keyWindow];
        
         __block Account_ViewController *blockSelf = self;//创建一个本地变量blockSelf，指向self，然后用结构体语法访问实例变量
         APopView.block = ^(NSString * text)
        {
           
        // NSString *email  =[[NSString alloc]init];
        // email = text;
            
          //  self->_UISwitch_type = text;
        //NSLog(@"a===%@",text);

        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // Do something...
              
        [blockSelf TouchIDOrFaceID];
                
        });
            
        };
    

    
}

- (void)TouchIDOrFaceID {
    LAContext *context = [[LAContext alloc] init];
    
    if ([self isSupport:context]) {
        //提示语
        NSString *localizedReason = @"指纹登录";
        if (@available(iOS 11.0, *)) {
            if (context.biometryType == LABiometryTypeFaceID){
                localizedReason = @"人脸识别";
            }
        }
        
        //TouchID/FaceID识别
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
              NSLog(@"TouchID/FaceID识别成功");
              //头像文件名外网路径保存在沙盒----开始
              NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
              NSString *documents = [array lastObject];
              NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
              NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
              //NSLog(@"BBB==%@",self->_UISwitch_type);
              if ([self->_UISwitch_type  isEqualToString:@"1"]) {
                    [dic_notice setObject:@"0" forKey:@"UISwitch_type"];
                } else {
                    [dic_notice setObject:@"1" forKey:@"UISwitch_type"];
                }
              
              [dic_notice writeToFile:documnetPath atomically:YES];
              
             
                
                
              dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
              dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // Do something...
                    //指定一个cell刷新
                     NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
                     [self->_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                         
                 });
                
                [self json];//上传服务器
             

                
            }else {
                switch (error.code) {
                    case LAErrorAuthenticationFailed: // -1 连续三次TouchID识别错误
                    {
                        NSLog(@"授权失败");
                    }
                        break;
                    case LAErrorUserCancel: // -2 点击了取消按钮
                    {
                        NSLog(@"用户取消验证");
                    }
                        break;
                    case LAErrorUserFallback: // -3 点击了输入密码按钮
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理");
                        }];
                    }
                        break;
                    case LAErrorSystemCancel: // -4 被系统取消，例如按下Home或者电源键
                    {
                        NSLog(@"取消授权，如其他应用切入，用户自主");
                    }
                        break;
                    case LAErrorPasscodeNotSet: // -5 设备系统未设置密码
                    {
                        NSLog(@"设备系统未设置密码");
                    }
                        break;
//                    case LAErrorTouchIDNotAvailable: // -6 设备未设置TouchID
//                    {
//                        NSLog(@"设备未设置TouchID");
//                    }
//                        break;
//                    case LAErrorTouchIDNotEnrolled: // -7 用户未录入TouchID
//                    {
//                        NSLog(@"用户未录入指纹");
//                    }
//                        break;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
//                    case LAErrorTouchIDLockout: // -8 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
//                    {
//                        NSLog(@"Touch ID被锁，需要用户输入密码解锁");
//                    }
//                        break;
                        
                    case LAErrorAppCancel: // -9 如突然来了电话，电话应用进入前台，APP被挂起啦");
                    {
                        NSLog(@"用户不能控制情况下APP被挂起");
                    }
                        break;
                        
                    case LAErrorInvalidContext: // -10 LAContext传递给这个调用之前已经失效
                    {
                        NSLog(@"LAContext传递给这个调用之前已经失效");
                    }
                        break;
#else
                        
#endif
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
            }
        }];
    }
}

//是否支持
- (BOOL)isSupport:(LAContext *)context {
    if([UIDevice currentDevice].systemVersion.doubleValue >= 8.0){
        //能否使用TouchID/FaceID识别
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
            return YES;
        }else {
            NSLog(@"请确保(5S以上机型),TouchID未打开");
            return NO;
        }
    }else {
        NSLog(@"此设备不支持TouchID/FaceID识别");
        return NO;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

     //NSLog(@"1");
      self.navigationController.navigationBarHidden= YES;//半返回状态，然后恢位，解决喇叭不响应事件



}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//
//    NSLog(@"2");
//
//
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:YES];
//
//    NSLog(@"3");
//
//
//
//}
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:YES];
//
//    NSLog(@"4");
//
//
//}
-(void)json{
              //---打开沙盒用户文件件
            NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [documentsPathArr lastObject];
            NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
       
              //---沙盒里用户信息
    
            NSString * username = [dic objectForKey:@"username"];//帐户名称
            NSString * face_id = [dic objectForKey:@"UISwitch_type"];
    

            //创建session对象
            NSURLSession *session = [NSURLSession sharedSession];
            NSString *UserApi=APIURL_USER;
               
            NSURL *url = [NSURL URLWithString:UserApi];
            NSString * Urladd =[NSString stringWithFormat:@"action=face_id&username=%@&face_id=%@",username,face_id];
            
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

                    // JSON数据格式解析
                    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                          //登陆状态，返回failure或success
                          //1001 登陆成功 ，1002 登陆失败 ， 1003 注册失败/已存在同名 ，1004 注册成功
                          NSString *status = [dict objectForKey:@"status"];
                          NSString *code =[dict objectForKey:@"code"];
                          //NSLog(@"==%@",dict);
                        

                          if ([status isEqualToString:@"failure"]) {
                              
                              NSLog(@"失败==%@",status);
                              NSLog(@"失败代码==%@",code);
                              

    
                                        
                                       
                          } else {
                             // NSLog(@"成功==%@",status);
                             // NSLog(@"成功代码==%@",code);
                              

                          }


                                         
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
                  
                 //开始任务

               
                 [task resume];
               

        }
    
//上一页返回刷新限额
-(void)LimitA_S
{
    

       
           //指定一个cell刷新
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
            [self->_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

 
}
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:YES];
//
//    //NSLog(@"3");
//    // 刷除tableV,释放内存
//    [self.tableV removeFromSuperview];
//    [self.tableV.layer removeFromSuperlayer];
//    //  _tableV=nil;
//    [self Share];
//
//
//}
@end
