//
//  Order_details_ViewController.m
//  topbar
//
//  Created by topbar on 2020/4/15.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Order_details_ViewController.h"
#import "Order_sale_ViewController.h"

@interface Order_details_ViewController ()

@end

@implementation Order_details_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    self.view.backgroundColor  = [UIColor colorWithRed:242.0/255 green:244.0/255 blue:245.0/255 alpha:1];
    UIView * BgmA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/3.4)];//下拉状态栏背景
    BgmA.backgroundColor  = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
    [self.view addSubview:BgmA];
    
    //设置导航控制器的代理(隐藏顶部-nav)
    self.navigationController.delegate = self;
    // Do any additional setup after loading the view.
  
    
      //设置窗口大小
    _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _tableV.backgroundColor=[UIColor whiteColor];
    _tableV.delegate=self;
    _tableV.dataSource=self;
    //隐藏滚动条
    self.tableV.showsVerticalScrollIndicator = NO;
    //滚动条修改颜色
    //self.tableV.indicatorStyle=UIScrollViewIndicatorStyleBlack;
    [self.view addSubview:_tableV];
    //--
    self.headerBackView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,160)style:UITableViewStyleGrouped];
    //self.headerBackView.backgroundColor = [UIColor redColor];
    self.tableV.tableHeaderView = self.headerBackView;
    //---
    [self Nav_UI];
    [self Header];
    [self header_order];

}


-(void)Nav_UI
{
    //-------自己定义Nav
      UIView * vc =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 89)];
      //vc.backgroundColor  = [UIColor whiteColor];
      [self.view addSubview:vc];
      //-------左返回
      UIButton *Button_Left = [[UIButton alloc]initWithFrame:CGRectMake(10,(89-20)/2+10,40,40)];
      [Button_Left setImage:[UIImage imageNamed:@"app_back_btn_W"] forState:UIControlStateNormal];
      [Button_Left addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
      [vc addSubview:Button_Left];

}
-(void)Header{
    
    UIView * Bgm = [[UIView alloc]initWithFrame:CGRectMake(0, 89, ScreenWidth, 100)];
    Bgm.backgroundColor = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
    [self.view addSubview:Bgm];
 
    UILabel * Title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, 30, 400, 40)];
    Title.textColor= [UIColor whiteColor];
    Title.font=[UIFont systemFontOfSize:30];
    //Title.text = @"请付款";
    //创建富文本
    if ([_type isEqualToString:@"0"]) {
        _attri = [[NSMutableAttributedString alloc] initWithString: @" 已撤销"];
        //NSTextAttachment可以将要插入的图片作为特殊字符处理
        _attch = [[NSTextAttachment alloc] init];
        //定义图片内容及位置和大小
        _attch.image = [UIImage imageNamed:@"canel"];
        _attch.bounds = CGRectMake(0, -4,26, 26);
        
    } else {
        _attri = [[NSMutableAttributedString alloc] initWithString: @" 已成交"];
        //NSTextAttachment可以将要插入的图片作为特殊字符处理
        _attch = [[NSTextAttachment alloc] init];
        //定义图片内容及位置和大小
        _attch.image = [UIImage imageNamed:@"right"];
        _attch.bounds = CGRectMake(0, -4,26, 26);
    }
    

    //创建带有图片的富文本
    NSAttributedString *stringA = [NSAttributedString attributedStringWithAttachment:_attch];
    //将图片放在最后一位
    //[attri appendAttributedString:string];
    //将图片放在第一位
    [_attri insertAttributedString:stringA atIndex:0];
    //用label的attributedText属性来使用富文本
    Title.attributedText = _attri;

    [Bgm addSubview:Title];
    //----
    UILabel * Meny = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, 70, 400, 40)];
    //NSLog(@"===%ld",(long)currentTime);


    Meny.textColor = [UIColor colorWithRed:255.0/255 green:255.1/255 blue:255.0/255 alpha:1];
    Meny.font=[UIFont systemFontOfSize:14];
    if ([_type isEqualToString:@"0"]) {
    Meny.text = @"订单已取消，无法查看支付方式";
    }else{
    Meny.text = @"订单已成功交易";
    }
    //Meny.text = [NSString stringWithFormat:@"还剩%lds，超时自动取消",(long)currentTime];
    [Bgm addSubview:Meny];

    
    //UIImageView * carpic =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/9), 70+15, 15, 15)];
    //UIImageView * carpicA =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/9+15+10), 70+15, 15, 15)];

    UIButton *phone = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/4), 60, 20, 20)];
    [phone setImage:[UIImage imageNamed:@"phone-call"] forState:UIControlStateNormal];
    //[CC addTarget:self action:@selector(Action_order) forControlEvents:UIControlEventTouchUpInside];
    [phone setTitle:@"电话" forState:UIControlStateNormal];
    phone.titleLabel.font = [UIFont systemFontOfSize:14];
    phone.titleLabel.textAlignment = NSTextAlignmentCenter;
    [phone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phone setImageEdgeInsets:UIEdgeInsetsMake(-phone.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -phone.titleLabel.intrinsicContentSize.width)];
    [phone setTitleEdgeInsets:UIEdgeInsetsMake(phone.currentImage.size.height + 20, -phone.currentImage.size.width-20, 0, 0)];
    [Bgm addSubview:phone];
    
    UIButton *Chat = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/4)+50, 62, 20, 20)];
    [Chat setImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
    //[CC addTarget:self action:@selector(Action_order) forControlEvents:UIControlEventTouchUpInside];
    [Chat setTitle:@"联系" forState:UIControlStateNormal];
    Chat.titleLabel.font = [UIFont systemFontOfSize:14];
    Chat.titleLabel.textAlignment = NSTextAlignmentCenter;
    [Chat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Chat setImageEdgeInsets:UIEdgeInsetsMake(-Chat.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -Chat.titleLabel.intrinsicContentSize.width)];
    [Chat setTitleEdgeInsets:UIEdgeInsetsMake(Chat.currentImage.size.height + 10, -Chat.currentImage.size.width-10, 0, 0)];
    [Bgm addSubview:Chat];

}
-(void)header_order
{
    
        //------------------------
        UIView * HeadPic= [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
        HeadPic.layer.cornerRadius = 5.0;//圆角
        HeadPic.layer.masksToBounds = NO;
        HeadPic.backgroundColor = [UIColor whiteColor];
//        // 阴影颜色
//        HeadPic.layer.shadowColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1].CGColor;
//         // 阴影偏移，默认(0, -3)
//        HeadPic.layer.shadowOffset = CGSizeMake(0,2);
//        // 阴影透明度，默认0
//        HeadPic.layer.shadowOpacity = 0.3;
//        // 阴影半径，默认3
//        HeadPic.layer.shadowRadius = 1;
//
//        //底
//        UIView * aa  = [[UIView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth-20, 3)];
//        aa.backgroundColor  = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
//        [HeadPic addSubview:aa];
//        //左
//        UIView * bb = [[UIView alloc]initWithFrame:CGRectMake(0, 4, 1, 96)];
//        bb.backgroundColor  = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
//        [HeadPic addSubview:bb];
//        //右
//        UIView * cc = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-21, 4, 1, 96)];
//        cc.backgroundColor  = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
//        [HeadPic addSubview:cc];
    
    //---------
         _Tatol_A = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, 15, ScreenWidth-40-20, 50)];
         //自定义格式
         NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
         [moneyFormatter setPositiveFormat:@"###,##0.00;"];
         NSString *num = _total;
         //NSLog(@"--第二种转换后的格式是--- %@",[moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]]);
         NSString * pris  = [moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]];
         //Title.text = [NSString stringWithFormat:@"¥%@",pris];
         NSString * PRI =  [NSString stringWithFormat:@"¥ %@",pris];
         
         _Tatol_A.textColor= [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
         _Tatol_A.font=[UIFont boldSystemFontOfSize:30];

         _Tatol_A.text = PRI;


    
         [HeadPic addSubview:_Tatol_A];
    
    //---------
         UILabel * Pro_lable = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, 65, ScreenWidth-40-20, 50)];
         Pro_lable.text = @"单价";
         Pro_lable.font = [UIFont systemFontOfSize:16];
         Pro_lable.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
         [HeadPic addSubview:Pro_lable];
    
         _Pri_A = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14+55, 65, ScreenWidth-40-20, 50)];
         _Pri_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         _Pri_A.font = [UIFont systemFontOfSize:15];
         //自定义格式
         NSNumberFormatter *moneyFormatterA = [[NSNumberFormatter alloc] init];
         [moneyFormatterA setPositiveFormat:@"###,##0.00;"];
         NSString *numA = _pri;
         //NSLog(@"--第二种转换后的格式是--- %@",[moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]]);
         NSString * prisA  = [moneyFormatter stringFromNumber:[NSNumber numberWithDouble:numA.doubleValue]];
         //Title.text = [NSString stringWithFormat:@"¥%@",pris];
         NSString * PRIA =  [NSString stringWithFormat:@"¥ %@",prisA];
         _Pri_A.text = PRIA;

        
         [HeadPic addSubview:_Pri_A];
    //---------
         UILabel * Vol_lable = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, 95, ScreenWidth-40-20, 50)];
         Vol_lable.text = @"数量";
         Vol_lable.font = [UIFont systemFontOfSize:16];
         Vol_lable.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
         [HeadPic addSubview:Vol_lable];
    
         _Vol_A = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14+55, 95, ScreenWidth-40-20, 50)];
         _Vol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         _Vol_A.font = [UIFont systemFontOfSize:15];
         _Vol_A .text = [NSString stringWithFormat:@"%@ %@",_vol,_btc_type];

    
         [HeadPic addSubview:_Vol_A];
    
         UIButton *Cunta = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/4)+50, 88, 30, 20)];
         [Cunta setImage:[UIImage imageNamed:_btc_type] forState:UIControlStateNormal];
         //[CC addTarget:self action:@selector(Action_order) forControlEvents:UIControlEventTouchUpInside];
         [Cunta setTitle:_btc_type forState:UIControlStateNormal];
         Cunta.titleLabel.font = [UIFont systemFontOfSize:14];
         Cunta.titleLabel.textAlignment = NSTextAlignmentCenter;
         [Cunta setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
         [Cunta setImageEdgeInsets:UIEdgeInsetsMake(-Cunta.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -Cunta.titleLabel.intrinsicContentSize.width)];
         [Cunta setTitleEdgeInsets:UIEdgeInsetsMake(Cunta.currentImage.size.height + 10, -Cunta.currentImage.size.width-10, 0, 0)];
    
         [HeadPic addSubview:Cunta];

         // [self.view addSubview:HeadPic];
         [self.headerBackView addSubview:HeadPic];
        
        
    }


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}

//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
 
}



//显示每一行的数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{
    
    static NSString * settingIdentifier=@"topbar";//这个是在没有自定议情况下的类
    
    //以下是当超过全屏时，会调用以下语句
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentifier];//获取一个类
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingIdentifier];
    //tableView.backgroundColor = [UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:16];//设置文本字体与大小
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];//设置文本字体与大小
    cell.textLabel.textColor =   [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];;
    cell.backgroundColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//详细箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色



    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
     if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            if ([_pay_type isEqualToString:@"微信"]) {
                cell.textLabel.text = [NSString stringWithFormat:@"请使用本人(*小明)微信向以下帐户自行转帐"];
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"请使用本人(*小明)支付宝向以下帐户自行转帐"];
            }
           
            cell.textLabel.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
            cell.textLabel.font = [UIFont systemFontOfSize:14];

            
        }
        if (indexPath.row == 1)
        {
     
            if ([_pay_type isEqualToString:@"微信"]) {
                  cell.textLabel.text = [NSString stringWithFormat:@"微信"];
                  cell.imageView.image = [UIImage imageNamed:@"weixin"];
            } else {
                  cell.textLabel.text = [NSString stringWithFormat:@"支付宝"];
                  cell.imageView.image = [UIImage imageNamed:@"alipay"];
            }
          

                
         

            
        }
        if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"收款人"];
            
            cell.detailTextLabel.text = _pay_name;
            
            

            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 3)
        {
             if ([_pay_type isEqualToString:@"微信"]) {
                 
                   cell.textLabel.text = [NSString stringWithFormat:@"微信"];

                 
             }else{
                   cell.textLabel.text = [NSString stringWithFormat:@"支付宝"];

             }
          
            
            cell.detailTextLabel.text = _pay_num;
   
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy"]];
            cell.accessoryView = imageView;
            
        }
          }
        
      else if (indexPath.section == 1)
         {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"卖家呢称"];
            
            cell.detailTextLabel.text = _m_anther;

            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"卖家实名"];
            
            cell.detailTextLabel.text = _m_name;
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"订单号"];

            cell.detailTextLabel.text = _order_num;
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy"]];
            cell.accessoryView = imageView;

            
            
        }
        if (indexPath.row == 3)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"下单时间"];
            cell.detailTextLabel.text = _date;


                 
                 
             }
        }
  

    //-----------
        //UITableView去掉自带系统的分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
        
        //自定义分割线

        UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 0.8)];
        VC.backgroundColor = RGBA(239, 239, 244, 1);
        [cell.contentView addSubview:VC];
    
   
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//行间距离（108）
{
    
    return 50;
    
}
////顶部距离
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 3.f;
//}
////尾部距离
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 8.f;
//}


//iOS 11 TableView heightForFooter 设置Header高度无效解决方法
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     //------TableView顶间距
     _tableV.sectionHeaderHeight = 1.f;
     return [[UIView alloc]init];

}
//iOS 11 TableView heightForFooter 设置footer高度无效解决方法
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    //------TableView尾间距
     _tableV.sectionFooterHeight = 8.f;
     return [[UIView alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath


{
    
    //取消选中后的蓝色背景
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
            if (indexPath.row == 2)
            {

               
             
            }
            if (indexPath.row == 3)
            {

//
                
            }

            
            
            break;
        }
            
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
        case 1:
        {
            
            if (indexPath.row == 0)
            {
                //NSLog(@"111");
                Order_sale_ViewController * vc =[[Order_sale_ViewController alloc]init];
                vc.username = _m_name;
                vc.Another = _m_anther;
                [self.navigationController pushViewController:vc animated:YES];
                
              
            }
            if (indexPath.row == 1)
            {
              
    
              
                
            }
            
            if (indexPath.row == 2)
            {
                
               
       
                
            }

               break;

        }
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
        case 2:
        {
            
            if (indexPath.row == 0)
            {
                
                
               // NSLog(@"点击了语言设置！");

                
            }
            if (indexPath.row == 1)
            {
                
                
               
                
            }
            if (indexPath.row == 2)
            {
                
                
             
            }
            if (indexPath.row == 3)
            {
                
                
              
                
            }
          
            if (indexPath.row == 4)
            {
          
             
                           
            }
           break;
            
        }

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            


        
    }
}



- (void)left
{
   
    [self.navigationController popViewControllerAnimated:YES];

}





- (UIStatusBarStyle)preferredStatusBarStyle
{
    // UIStatusBarStyleLightContent 白色
    // UIStatusBarStyleDefault      黑色
    
    if ([_stus_type isEqualToString:@"0"]) {
         //NSLog(@"我是白色==%@",_stus_type);
        return UIStatusBarStyleDefault;
       
    } else {
        //NSLog(@"我是黑色==%@",_stus_type);
        return UIStatusBarStyleLightContent;
        
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
     [self setNeedsStatusBarAppearanceUpdate];




}

//隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

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
