//
//  Add_goumail_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/11.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Add_goumail_ViewController.h"
#import <objc/runtime.h>
#import "Hy_root_ViewController.h"
@interface Add_goumail_ViewController ()<TopbarTimerPickerViewDelegate>

@end

@implementation Add_goumail_ViewController


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
    _tableV.sectionHeaderHeight = 0;
  
    //以下两种方法为UITextField 光标颜色
    //username.tintColor = [UIColor redColor];//指定UITextField
    [[UITextField appearance] setTintColor:[UIColor orangeColor]];//全局
    //点击空白处隐藏键盘
    [self KeyBoardHide_Yc];
    [self Quit_btn];
//       NSArray * pathsa =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//       NSLog(@"沙盒路径:%@",pathsa);

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}

//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0  || section == 1)
       {
        return 2;
       }
    
    else
       {
        return 3;
        
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
             cell.textLabel.text = [NSString stringWithFormat:@"定价方式"];
             Pric_type = [[UITextField alloc]initWithFrame:CGRectMake(130,10,200, 40)];
             Pric_type.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
             //Pric_type.secureTextEntry = YES;//显示密码星号*
             Pric_type.userInteractionEnabled = NO;// Pric_type.enabled = NO; 默认不可修改或辑编内容
             
             //password.placeholder = @" 请输入登陆密码";
             //占位符颜色
             NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
             NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"固定价格" attributes:attDicA];
             Pric_type.attributedPlaceholder = attPlaceA;
             [cell.contentView addSubview: Pric_type];

            
        }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"交易价格"];
            Pric = [[UITextField alloc]initWithFrame:CGRectMake(130,10,200, 40)];
            Pric.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
            Pric.keyboardType = UIKeyboardTypeDecimalPad;//弹出全数字键盘
            //监听价格，使之金额会发生变动
            [Pric addTarget:self action:@selector(Pric_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            
            //password.placeholder = @" 请输入登陆密码";
            Pric.delegate = self;//
            //New_Password.secureTextEntry = YES;//显示密码星号*
            //占位符颜色
            NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
            NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请输入交易价格" attributes:attDicA];
            Pric.attributedPlaceholder = attPlaceA;
            [cell.contentView addSubview: Pric];
   
            
        }
    }
        //-------
        else if (indexPath.section == 1)
        {
         if (indexPath.row == 0)
        {
            if (_titlea == nil) {
                cell.textLabel.text = [NSString stringWithFormat:@"数量(USDT)"];
            } else {
                cell.textLabel.text = [NSString stringWithFormat:@"数量(%@)",_titlea];
            }
            
            Pric_vol = [[UITextField alloc]initWithFrame:CGRectMake(130,10,200, 40)];
            Pric_vol.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
            Pric_vol.delegate = self;//限制输入字符,配合方法才能使用
            Pric_vol.keyboardType = UIKeyboardTypeDecimalPad;//弹出全数字键盘
            //监听数量，使之金额会发生变动
            [Pric_vol addTarget:self action:@selector(Pric_vol_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            //Pric_vol.secureTextEntry = YES;//显示密码星号*
            //password.placeholder = @" 请输入登陆密码";
            //占位符颜色
            NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
            NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请输入购买数量" attributes:attDicA];
            Pric_vol.attributedPlaceholder = attPlaceA;
            [cell.contentView addSubview: Pric_vol];
          
 
        }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"金额(CNY)"];
            Pric_total = [[UITextField alloc]initWithFrame:CGRectMake(130,10,200, 40)];
            Pric_total.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
            Pric_total.userInteractionEnabled = NO;// Pric_type.enabled = NO; 默认不可修改或辑编内容

           // Pric_total.placeholder = _Apri_total;


            
//
//            //占位符颜色
            if (_Apri_total == nil) {
                NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
                NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"0" attributes:attDicA];
                Pric_total.attributedPlaceholder = attPlaceA;
            } else {
                NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
                NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:_Apri_total attributes:attDicA];
                Pric_total.attributedPlaceholder = attPlaceA;
        }

            [cell.contentView addSubview: Pric_total];
        }
             
         }
       //--------
       else  if (indexPath.section == 2)
         {
         if (indexPath.row == 0)
         {
            cell.textLabel.text = [NSString stringWithFormat:@"认证等级"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_D"]];
            cell.accessoryView = imageView;
            Rzdj = [[UITextField alloc]initWithFrame:CGRectMake(130,10,200, 40)];
            Rzdj.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
            Rzdj.userInteractionEnabled = NO;// Pric_type.enabled = NO; 默认不可修改或辑编内容
            //Rzdj.secureTextEntry = YES;//显示密码星号*
            //password.placeholder = @" 请输入登陆密码";
             
            if (_KYC == nil) {
            //占位符颜色
            NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
            NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请选择" attributes:attDicA];
            Rzdj.attributedPlaceholder = attPlaceA;
            [cell.contentView addSubview: Rzdj];
                 
                   
            }
             else
             {
            NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
            NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:_KYC attributes:attDicA];
            Rzdj.attributedPlaceholder = attPlaceA;
            [cell.contentView addSubview: Rzdj];
             }
          }
             
          if (indexPath.row == 1)
          {
             cell.textLabel.text = [NSString stringWithFormat:@"注册时间"];
             UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_D"]];
             cell.accessoryView = imageView;
             Rz_time = [[UITextField alloc]initWithFrame:CGRectMake(130,10,200, 40)];
             Rz_time.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
             //Rz_time.placeholder = _timeStr;
             Rz_time.userInteractionEnabled = NO;//默认不可修改或辑编内容
              
             //占位符颜色
             if (_timeStr == nil) {
             NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
             NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请选择" attributes:attDicA];
                     Rz_time.attributedPlaceholder = attPlaceA;
                 } else {
             NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
             NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:_timeStr attributes:attDicA];
                     Rz_time.attributedPlaceholder = attPlaceA;
             }
             [cell.contentView addSubview: Rz_time];
       
           
            }
            if (indexPath.row == 2)
            {
             cell.textLabel.text = [NSString stringWithFormat:@"交易说明"];
             Rz_con = [[UITextField alloc]initWithFrame:CGRectMake(130,10,200, 40)];
             Rz_con.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
             // 添加监听事件,弹出键盘向上推移
             [Rz_con addTarget:self action:@selector(MEAG) forControlEvents:UIControlEventEditingDidBegin];
             //Rz_con.delegate = self;
             //password.placeholder = @" 请输入登陆密码";
             //占位符颜色
             NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
             NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"下单后极速付款，到帐后请及时放币" attributes:attDicA];
             Rz_con.attributedPlaceholder = attPlaceA;
             [cell.contentView addSubview: Rz_con];
                   
            }
            
                    
          }
               
     
   

        //-----------
        //UITableView去掉自带系统的分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //自定义分割线
        UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 0.5)];
        VC.backgroundColor = RGBA(239, 239, 244, 1);
        [cell.contentView addSubview:VC];

    

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//行间距离（108）
{
    
    return 50;
    
}
//顶部距离
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //NSLog(@"执行");
    return 50.f;//配合“  _tableV.sectionHeaderHeight = 0;”才生效

}

//iOS 11 TableView heightForFooter 设置Header高度无效解决方法
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     //   NSLog(@"执行");
 

    
    
       UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
       //headerView.backgroundColor = RGBA(152,152,252,1);
       
       UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.view.bounds.size.width, 40)];
       
       tipLabel.numberOfLines = 0;
       tipLabel.textAlignment = NSTextAlignmentLeft;
       tipLabel.font = [UIFont systemFontOfSize:16];//设置文本字体与大小
       tipLabel.textColor = [UIColor grayColor];
    
       [headerView addSubview:tipLabel];
       
    
       //线条
//       UILabel *tipLabela = [[UILabel alloc] initWithFrame:CGRectMake(0, 50-1, self.view.bounds.size.width, 1)];
//       tipLabela.backgroundColor  = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];;
//       [headerView addSubview:tipLabela];
       //tipLabel.text = [NSString stringWithFormat:@"section footer %d", section+1];
       
       
       
       
       if (section == 0) {
           tipLabel.text = @"价格";

       }
       
       if (section == 1) {
           tipLabel.text = @"交易数量";

           
      
       }
       if (section == 2) {
           
           
         tipLabel.text = @"对手限制";
           
           
             }
      
 
       
       return headerView;
    
     //------TableView顶间距
     // _tableV.sectionHeaderHeight = 50;
     //  return [[UIView alloc]init]; //_tableV.sectionHeaderHeight = 50;”才生效
    
  
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath


{
    
    //取消选中后的蓝色背景
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section)
    {
        case 2:
            
        {
            
            if (indexPath.row == 0)
            {
                [self Authentication];
      
            }
            if (indexPath.row == 1)
            {
                [self startTimeClick];

                           
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
    [Qbutton setTitle:@"发布委托单" forState:UIControlStateNormal];
    [Qbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Qbutton.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    [Qbutton addTarget:self action:@selector(Add_goumai) forControlEvents:UIControlEventTouchUpInside];
    [self.Foot_tableView addSubview:Qbutton];

}
-(void)Add_goumai
{

    
    if ([Pric.text isEqualToString:@""] ) {

       HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"交易价格不能为空！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.tableV animated:YES];

       return;

    }

    if ([Pric_vol.text isEqualToString:@""] ) {

       HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"交易数量不能为空！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.tableV animated:YES];

       return;

    }
    
    if (_KYC == nil ) {

       HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"请选择认证方式！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.tableV animated:YES];

       return;

    }
    
    if (_timeStr == nil ) {

       HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"请选择时间！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.tableV animated:YES];

       return;

    }

    
  

    
    //取沙盒用户信息
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    NSString * username = [dic objectForKey:@"username"];
    NSString * Another = [dic objectForKey:@"Another"];//商家名称
    NSString * LimitA = [dic objectForKey:@"LimitA"];//限额
    NSString * alipay = [dic objectForKey:@"alipay"];//支付宝
    NSString * weixin = [dic objectForKey:@"weixin"];//微信
    //获取上一级传过来的货币类型，如：usdt 、btc 、eth
    if (_titlea == nil) {
        _titlea = @"USDT";
    }
    
    //-------
    if (Another == NULL || [Another isEqualToString:@""]) {

       HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"请设置呢称或商家名称！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.tableV animated:YES];

       return;

    }
    if (LimitA == NULL || [LimitA isEqualToString:@""] ) {

       HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"请设置限额！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.tableV animated:YES];

       return;

    }
    if (alipay == nil && weixin == nil ) {

       HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"请设置收付款！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.tableV animated:YES];

       return;

    }
    
    
 
    //创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *UserApi=APIURL_USER;
       
    NSURL *url = [NSURL URLWithString:UserApi];
    NSString * Urladd =[NSString stringWithFormat:@"action=transaction&username=%@&type=1&dj_type=%@&Currency=%@&pri=%@&vol=%@&tatol=%@&reg_time=%@&rzdj=%@&conter=%@&Another=%@&LimitA=%@&alipay=%@&weixin=%@",username,@"固定价格",_titlea,Pric.text,Pric_vol.text,_Apri_total,_timeStr,_KYC,Rz_con.text,Another,LimitA,alipay,weixin];  //tpe=1 是我要购买， type=0 是我要出售
    
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
                // NSLog(@"%@",dict);
                                   
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
    HUD.label.text = @"委托发布成功！";
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
//
 
    
   
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
return NO;
}

   //点击空白处隐藏键盘
-(void)KeyBoardHide_Yc
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    //[Pric_type resignFirstResponder];
    [Pric resignFirstResponder];
    [Pric_vol resignFirstResponder];
    //[Pric_total resignFirstResponder];
    //[Rzdj resignFirstResponder];
    //[Rz_time resignFirstResponder];
    [Rz_con resignFirstResponder];
   
 
}
//---Pric价格监听计算
- (void)Pric_textFieldDidChange:(UITextField *) TextField{
    
    //NSLog(@"%@",Pric.text);
    double total = [Pric.text doubleValue] * [Pric_vol.text doubleValue];
    //NSLog(@"==%.2f",total);
    _Apri_total =[NSString stringWithFormat:@"%.2f",total];
    //指定一个cell刷新
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
    [_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

}
//---Pric_vol数量监听计算
- (void)Pric_vol_textFieldDidChange:(UITextField *) TextField{
    
    //NSLog(@"%@",Pric_vol.text);
    double total = [Pric_vol.text doubleValue] * [Pric.text doubleValue];
    //NSLog(@"==%.2f",total);
    _Apri_total =[NSString stringWithFormat:@"%.2f",total];
    //指定一个cell刷新
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
    [_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

}
//，限制密码最长为11个字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    //价格*数量，计算出来结果
//    NSString *New_Pric_vol = [Pric_vol.text stringByReplacingCharactersInRange:range withString:string];
//    double total = [Pric.text doubleValue] * [New_Pric_vol doubleValue];
//    //NSLog(@"pric=%@",Pric.text);
//    //NSLog(@"pric_vol=%@",New_Pric_vol);
//    //NSLog(@"==%.2f",total);
//    _Apri_total =[NSString stringWithFormat:@"%.2f",total];
//    //NSLog(@"aaaa=%@",_Apri_total);
//
//    //指定一个cell刷新
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
//    [_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

    //指定一个section刷新
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//    [_tableV reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

    //_Apri_total = [Pric_total.text stringByReplacingCharactersInRange:range withString:string];
        
//        NSLog(@"改变之前的内容:%@", textField.text);
//        //新的内容=用string去替换text上range范围的内容
//        NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
//
//        NSLog(@"即将显示的内容:%@", newStr);
    

       
    
    
     //------------
    if (textField == Pric_vol) {
        if (textField.text.length > 10 && string.length > 0) return NO;
  

    //获取New_Password输入的长度，
    NSString * pric_vol_lengt = [Pric_vol.text stringByReplacingCharactersInRange:range withString:string];
    Pric_vol_lengt = [[NSString stringWithFormat:@"%lu",(unsigned long)pric_vol_lengt.length] intValue];
      }
    
    
    
    //-----------
    if (textField == Pric) {
        if (textField.text.length > 10 && string.length > 0) return NO;
  

    //获取New_Password输入的长度，
    NSString * pric_lengt = [Pric.text stringByReplacingCharactersInRange:range withString:string];
    Pric_lengt = [[NSString stringWithFormat:@"%lu",(unsigned long)pric_lengt.length] intValue];

    }
    
    
    
    
    return YES;

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
//时间选择后/事件/取值
- (void)toobarDonBtnHaveClick:(TopbarTimerPickerView *)pickView resultString:(NSString *)resultString atIndexof:(NSInteger)indexRow
{
    //NSLog(@" ==== delegate => toobarDonBtnHaveClick 【%@】", resultString);
    _timeStr = resultString;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:2];
    [_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    

}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    //取消通知，使期他UITextField不向上移动通知
     [[NSNotificationCenter defaultCenter] removeObserver:self];
   

}

-(void)MEAG
{
    // 监听键盘上移通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


#pragma mark 键盘处理
- (void)keyboardWillChangeFrame:(NSNotification *)note{

        // 取出键盘最终的frame
        CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        // 取出键盘弹出需要花费的时间
        double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        // 修改transform
        [UIView animateWithDuration:duration animations:^{
            CGFloat ty = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
            self.view.transform = CGAffineTransformMakeTranslation(0, - ty);
        }];


}
-(void)Authentication
{
        PopView  = [[Pop_rz alloc]init];
        PopView.type = @"2"; //传值，到底是认证时间还是认证等级，因为调用同一个窗口。 0 认证等级（默认）  、1 认证时间
        //三选其一显示
        [PopView showInView];//遮挡新建的view
        //[PopView coutomshowInView:self.view];
        //[PopView coutomshowInView:[UIApplication sharedApplication].keyWindow];
        
         __block Add_goumail_ViewController *blockSelf = self;//创建一个本地变量blockSelf，指向self，然后用结构体语法访问实例变量
         PopView.block = ^(NSString * text)
        {
           
        // NSString *email  =[[NSString alloc]init];
        // email = text;
            self->_KYC = text;
                
            //NSLog(@"===%@",text);

            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // Do something...
              
            [blockSelf DismissViewController];
                
        });
            
        };
    
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

         
     [MBProgressHUD hideHUDForView:self.tableV animated:YES];
         
    
      });
    
     //刷新cell
     NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
     [self->_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

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

// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

}
@end
