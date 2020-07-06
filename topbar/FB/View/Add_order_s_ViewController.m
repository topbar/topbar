//
//  Add_order_s_ViewController.m
//  topbar
//
//  Created by topbar on 2020/4/14.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Add_order_s_ViewController.h"
#import "Hy_root_ViewController.h"
#import "OrderType_ViewController.h"
@interface Add_order_s_ViewController ()

@end

@implementation Add_order_s_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    //接收上一页传来的数组
    _type = [_type_S lastObject];//firstObject 数组最第一个值
    _car_name = [_car_name_S lastObject];
    _car_num = [_car_num_S lastObject];
    _alipay = [_alipay_S lastObject];
    _weixin = [_weixin_S lastObject];
   
    self.view.backgroundColor  = [UIColor colorWithRed:242.0/255 green:244.0/255 blue:245.0/255 alpha:1];
    UIView * BgmA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/3.4)];//下拉状态栏背景
    BgmA.backgroundColor  = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
    [self.view addSubview:BgmA];
    
    //设置导航控制器的代理(隐藏顶部-nav)
    self.navigationController.delegate = self;
    // Do any additional setup after loading the view.
    [self Nav_UI];
    
      //设置窗口大小
    _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.bounds.size.height-300) style:UITableViewStyleGrouped];
    // tableV.backgroundColor=[UIColor clearColor];
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
    [self Header];
    [self timerBlock];
    [self header_order];
    [self Quit_btn];
    [self Stop_hudong];



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
      [Button_Left addTarget:self action:@selector(Cancel) forControlEvents:UIControlEventTouchUpInside];
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
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: @" 等待收款"];
    //NSTextAttachment可以将要插入的图片作为特殊字符处理
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    //定义图片内容及位置和大小
    attch.image = [UIImage imageNamed:@"Timer"];
    attch.bounds = CGRectMake(0, -4,30, 30);
    //创建带有图片的富文本
    NSAttributedString *stringA = [NSAttributedString attributedStringWithAttachment:attch];
    //将图片放在最后一位
    //[attri appendAttributedString:string];
    //将图片放在第一位
    [attri insertAttributedString:stringA atIndex:0];
    //用label的attributedText属性来使用富文本
    Title.attributedText = attri;

    [Bgm addSubview:Title];
    //----
    UILabel * Meny = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, 70, 400, 40)];
    //NSLog(@"===%ld",(long)currentTime);


    Meny.textColor = [UIColor colorWithRed:255.0/255 green:255.1/255 blue:255.0/255 alpha:1];
    Meny.font=[UIFont systemFontOfSize:14];
    
    int seconds = currentTime % 60;
    int minutes = (currentTime / 60) % 60;
    NSString * time = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];

    //UILable更改部分字体颜色
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您将于%@s内收到买家付款",time]];



    //更改字体
    //[string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] range:NSMakeRange(2, 4)];
    //修改颜色
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(3, 6)];
    Meny.attributedText = string;
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
         NSString *num = _tatol;
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
         _Vol_A .text = [NSString stringWithFormat:@"%@ %@",_vol,_Currency];

    
         [HeadPic addSubview:_Vol_A];
    
         UIButton *Cunta = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/4)+50, 88, 30, 20)];
         [Cunta setImage:[UIImage imageNamed:_Currency] forState:UIControlStateNormal];
         //[CC addTarget:self action:@selector(Action_order) forControlEvents:UIControlEventTouchUpInside];
         [Cunta setTitle:_Currency forState:UIControlStateNormal];
         Cunta.titleLabel.font = [UIFont systemFontOfSize:14];
         Cunta.titleLabel.textAlignment = NSTextAlignmentCenter;
         [Cunta setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
         [Cunta setImageEdgeInsets:UIEdgeInsetsMake(-Cunta.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -Cunta.titleLabel.intrinsicContentSize.width)];
         [Cunta setTitleEdgeInsets:UIEdgeInsetsMake(Cunta.currentImage.size.height + 10, -Cunta.currentImage.size.width-10, 0, 0)];
    
         [HeadPic addSubview:Cunta];

         // [self.view addSubview:HeadPic];
         [self.headerBackView addSubview:HeadPic];
        
        
    }
-(void)Quit_btn
{

    #define Topbar_INPUTVIEW_HEIGHT 100.f
//    UIButton *rbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rbtn setFrame:CGRectMake(ScreenWidth-64, ScreenHeight - Topbar_INPUTVIEW_HEIGHT, 50, 50)];
//    [rbtn setImage:[UIImage imageNamed:@"Add_P@2x"] forState:UIControlStateNormal];
//    [rbtn addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:rbtn];
    //
    _Foot_tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,50)style:UITableViewStyleGrouped];
     [_Foot_tableView setFrame:CGRectMake(0, ScreenHeight - Topbar_INPUTVIEW_HEIGHT, ScreenWidth, 50)];
     //_Foot_tableView.backgroundColor = [UIColor whiteColor];
     //self.view=_Foot_tableView;
     [self.view addSubview:_Foot_tableView];
    
    
    UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, ScreenWidth/3, 40)];
    [Qbutton setTitle:@"取消订单" forState:UIControlStateNormal];
    Qbutton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [Qbutton setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
    Qbutton.backgroundColor = [UIColor colorWithRed:247.0/255 green:246.1/255 blue:251.0/255 alpha:1];
    [Qbutton addTarget:self action:@selector(Cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.Foot_tableView addSubview:Qbutton];
    
    UIButton *QbuttonA = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3+40, 10, ScreenWidth/2, 40)];
    [QbuttonA setTitle:@"我已确认收款" forState:UIControlStateNormal];
    QbuttonA.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [QbuttonA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    QbuttonA.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.8];
    [QbuttonA addTarget:self action:@selector(Buton_add) forControlEvents:UIControlEventTouchUpInside];
    [self.Foot_tableView addSubview:QbuttonA];

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
            if ([_type isEqualToString:@"微信"]) {
                cell.textLabel.text = [NSString stringWithFormat:@"请确认本人(*小明)微信以便买家付款"];
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"请确认本人(*小明)支付宝微信以便买家付款"];
            }
           
            cell.textLabel.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
            cell.textLabel.font = [UIFont systemFontOfSize:14];

            
        }
        if (indexPath.row == 1)
        {
     
            if ([_type isEqualToString:@"微信"]) {
                  cell.textLabel.text = [NSString stringWithFormat:@"微信"];
                  cell.imageView.image = [UIImage imageNamed:@"weixin"];
            } else {
                  cell.textLabel.text = [NSString stringWithFormat:@"支付宝"];
                  cell.imageView.image = [UIImage imageNamed:@"alipay"];
            }
          
                cell.textLabel.textColor =   [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
                cell.accessoryView = imageView;
                
         

            
        }
        if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"收款人"];
            
            cell.detailTextLabel.text = _car_name;
            
            

            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 3)
        {
             if ([_type isEqualToString:@"微信"]) {
                 
                   cell.textLabel.text = [NSString stringWithFormat:@"微信"];
                // NSLog(@"%@",_weixin);
                 _qrcode = _weixin;
                 
             }else{
                   cell.textLabel.text = [NSString stringWithFormat:@"支付宝"];
                 // NSLog(@"%@",_alipay);
                 _qrcode = _alipay;
             }
          
            
            cell.detailTextLabel.text = _car_num;
   
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            
        }
          }
        
      else if (indexPath.section == 1)
         {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"买家呢称"];
            
            cell.detailTextLabel.text = _Another;

            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"买家实名"];
            
            cell.detailTextLabel.text = _username;
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"订单号"];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            
            
            int Vol_X = arc4random() % 10000;//成功交易单数，10000是生成千位以内的数
            _order_num =  [NSString stringWithFormat:@"TBC%@%d",str,Vol_X];
            cell.detailTextLabel.text = _order_num;
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy"]];
            cell.accessoryView = imageView;

            
            
        }
        if (indexPath.row == 3)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"出售:在转帐过程中请勿备注BTC、USDT、火币等信息,防止汇款被拦截、银行卡被冻结等问题"];
            cell.textLabel.font = [UIFont systemFontOfSize:14];//设置文本字体与大小
            cell.textLabel.textColor =   [UIColor orangeColor];
            cell.textLabel.numberOfLines = 0;//分行

                 
                 
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

                [self Authentication];
             
            }
            if (indexPath.row == 2)
            {

               
             
            }
            if (indexPath.row == 3)
            {

                [self imagesfull];
               if ([_type isEqualToString:@"微信"]) {
                   
                
                   _qrcode = _weixin;
                
                   }else{
                       
                   _qrcode = _alipay;
             }
            
                
            }

            
            
            break;
        }
            
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
        case 1:
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
//请求卖家支付方式

-(void)Authentication
{
    
//     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//           // Do something...
//           //指定一个cell刷新
//            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:2];
//            [self->_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//
//        });
//
       //NSLog(@"111");
       // NSLog(@"btn_type===%@",_Btn_type);
        //
  
        APopView  = [[Pop_rz alloc]init];
        APopView.type = @"5"; //传值，到底是认证时间还是认证等级，因为调用同一个窗口。 0 认证等级（默认）  、1 认证时间
        APopView.type_S = _type_S;
        APopView.car_name_S = _car_name_S;
        APopView.car_num_S = _car_num_S;
        APopView.alipay_S = _alipay_S;
        APopView.weixin_S = _weixin_S;
    
        //三选其一显示
        [APopView showInView];//遮挡新建的view
        //[APopView coutomshowInView:self.view];
        //[PopView coutomshowInView:[UIApplication sharedApplication].keyWindow];
        __block Add_order_s_ViewController *blockSelf = self;//创建一个本地变量blockSelf，指向self，然后用结构体语法访问实例变量
        APopView.callBcakBlock = ^(NSArray *NSArray_text) {

             NSString *type = [NSArray_text objectAtIndex:0];
             NSString *car_name = [NSArray_text objectAtIndex:1];
             NSString *car_num = [NSArray_text objectAtIndex:2];
             NSString *weixin = [NSArray_text objectAtIndex:3];
             NSString *alipay = [NSArray_text objectAtIndex:4];
             //NSLog(@"%@=%@=%@",type,car_name,car_num);
             self->_type = type;
             self->_car_name = car_name;
             self->_car_num = car_num;
             self->_weixin = weixin;
             self->_alipay = alipay;
             //NSLog(@"weixin==%@,alipay==%@",weixin,alipay);
            
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                         // Do something...
  
             [blockSelf DismissViewController];

         });

            
        };
    

    
}
//取消时弹窗

-(void)Cancel
{
    
//     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//           // Do something...
//           //指定一个cell刷新
//            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:2];
//            [self->_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//
//        });
//

  
        APopView  = [[Pop_rz alloc]init];
        APopView.type = @"8"; //传值，到底是认证时间还是认证等级，因为调用同一个窗口。 0 认证等级（默认）  、1 认证时间
        APopView.currentTime = [NSString stringWithFormat:@"%ld",(long)currentTime];
        
    
        //三选其一显示
        [APopView showInView];//遮挡新建的view
        //[APopView coutomshowInView:self.view];
        //[PopView coutomshowInView:[UIApplication sharedApplication].keyWindow];
        __block Add_order_s_ViewController *blockSelf = self;//创建一个本地变量blockSelf，指向self，然后用结构体语法访问实例变量
        APopView.block = ^(NSString *text) {


            // NSLog(@"%@",text);
            self->_text_num = [NSString stringWithFormat:@"%@",text];
            
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                         // Do something...

            
             [blockSelf left];


         });

            
        };
    

    
}
//已收款

-(void)Buton_add
{
    
//     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//           // Do something...
//           //指定一个cell刷新
//            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:2];
//            [self->_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//
//        });
//

  
        APopView  = [[Pop_rz alloc]init];
        APopView.type = @"9"; //传值，到底是认证时间还是认证等级，因为调用同一个窗口。 0 认证等级（默认）  、1 认证时间
        //APopView.currentTime = [NSString stringWithFormat:@"%ld",(long)currentTime];
        
    
        //三选其一显示
        [APopView showInView];//遮挡新建的view
        //[APopView coutomshowInView:self.view];
        //[PopView coutomshowInView:[UIApplication sharedApplication].keyWindow];
        __block Add_order_s_ViewController *blockSelf = self;//创建一个本地变量blockSelf，指向self，然后用结构体语法访问实例变量
        APopView.block = ^(NSString *text) {


            // NSLog(@"%@",text);
            self->_text_num = [NSString stringWithFormat:@"%@",text];
            
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                         // Do something...

            
             [blockSelf left];


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
    

     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
         // Do something...
         //[self Addpay];
      NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
      [self->_tableV reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
         
     [MBProgressHUD hideHUDForView:self.tableV animated:YES];
         
    
      });
    
}
- (void)timerBlock {
    //  __block int i = 1;
    currentTime = 181;
    //__weak __typeof(&*self)weakSelf = self;
    timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //++;加时
        
        self->currentTime--;//减时
        [self Header];
        
        //NSLog(@"%ld", (long)self->currentTime);
        
        
        if(self->currentTime <= 0) {
                    
                    [self releaseTimer];
                    [self left ];

                       }

                }];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}
//释放计时器
- (void)releaseTimer
{
    if (timer)
    {
        if ([timer isValid])
        {
            [timer invalidate];
            timer = nil;
        }
    }
}
- (void)left
{
    [self releaseTimer];
    // [self.navigationController popViewControllerAnimated:YES];
    // 返回根目录第一种方式，不推荐
    // [self.navigationController popToRootViewControllerAnimated:YES];
    //返回根目录第二种方式，推荐
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[Hy_root_ViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
    
    
     //返回根目录第三种方式，传参数
    if ([_black_A isEqualToString:@"0"]) {
       // NSLog(@"00000");
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
    } else {//

       // NSLog(@"111111");
                for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[OrderType_ViewController class]]) {
                    OrderType_ViewController *vc =(OrderType_ViewController *)controller;
                    [self.navigationController popToViewController:vc animated:YES];
        //            直接调用MyViewController里面的加载数据的方法即isRefreshData
                   // [vc nav_new];//POP回去刷新页面
        //            若是需要传值的直接属性
                   // vc.name = @"你好！帅哥";
                }

            }
    }

    [self Add_order];
}
-(void)Add_order
{
    
        //取沙盒用户信息
        NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [documentsPathArr lastObject];
        NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
        NSString * username_s = [dic objectForKey:@"username"];
    
        //创建session对象
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *UserApi=APIURL_USER;

        NSURL *url = [NSURL URLWithString:UserApi];
        NSString * Urladd =[NSString stringWithFormat:@"action=order&username=%@&pri=%@&vol=%@&total=%@&btc_type=%@&pay_type=%@&pay_name=%@&pay_num=%@&m_anther=%@&m_name=%@&order_num=%@&type=%@&buy_sale_type=1",username_s,_pri,_vol,_tatol,_Currency,_type,_car_name,_car_num,_Another,_username,_order_num,_text_num];  //tpe=0 取消订单， type=1 我已付款（下单成功） buy_sale_type=0购买 buy_sale_type=1出售
        
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
           
      

 
    
}
-(void)imagesfull{
   
    //初始化要显示的图片内容的imageView（这里位置是使用当前屏幕的 宽和高宏定义）
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, ScreenHeight-200)];
    //图片背景色设置成黑色(必须)
    imageView.backgroundColor = [UIColor blackColor];
    //要显示的图片，即要放大的图片(放大图片的填充方式)
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    //imageView.image = [UIImage imageNamed:@"weixin"];

    //id KYC = objc_getAssociatedObject(sender, "qrcode"); //取参
    //NSLog(@"kyc==%@",KYC);

    NSString *api_url = [NSString stringWithFormat:@"%@",_qrcode];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
    NSURL *picURL = [NSURL URLWithString:urlString];
    [imageView sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"qr-acode"] ];
    //NSLog(@"qrcode==%@",picURL);
    
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    [self shakeToShow:imageView];

    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView:)];
    [imageView addGestureRecognizer:tapGesture];
}

//放大过程中出现的缓慢动画
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

//添加点击手势（即点击图片后退出全屏）
- (void)closeView:(UITapGestureRecognizer *)tap {
    
    [tap.view removeFromSuperview];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    // UIStatusBarStyleLightContent 白色
    // UIStatusBarStyleDefault      黑色
    return UIStatusBarStyleLightContent;
}

//隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

}
-(void)Stop_hudong
{
    
    //禁用返回手势
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;

    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];

    [self.view addGestureRecognizer:pan];
    
}

@end
