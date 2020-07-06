//
//  Hy_order_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/4/7.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Hy_order_ViewController.h"
#import "Add_order_ViewController.h"

@interface Hy_order_ViewController ()


@end

@implementation Hy_order_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self json_pay];//下一页需要的支付数据,预先加载
    self.view.backgroundColor  = [UIColor colorWithRed:242.0/255 green:244.0/255 blue:245.0/255 alpha:1];
    UIView * BgmA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/3.4)];//下拉状态栏背景
    BgmA.backgroundColor  = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
    [self.view addSubview:BgmA];
    
    //设置导航控制器的代理(隐藏顶部-nav)
    self.navigationController.delegate = self;
    // Do any additional setup after loading the view.

    [self Nav_UI];
    [self Header];
    [self timerBlock];
    [self header_order];
    [self header_Megss];
    [self KeyBoardHide_Yc];

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
      [Button_Left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
      [vc addSubview:Button_Left];
      //-----居中的title
      UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-45, (89-20)/2+10, 110, 40)];
      NSString * titles =[NSString stringWithFormat:@"购买%@",_Currency];
      if (_Currency == nil) {
         [title setText:@"购买USDT"];
      } else {
         [title setText:titles];
      }

      title.font = [UIFont systemFontOfSize:20];
      title.textColor =  [UIColor whiteColor];
      [vc addSubview:title];
}
-(void)Header{
    
    UIView * Bgm = [[UIView alloc]initWithFrame:CGRectMake(0, 89, ScreenWidth, 110)];
    Bgm.backgroundColor = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
    [self.view addSubview:Bgm];
 
    UILabel * Title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, 40, 400, 40)];
    //Title.text = _pri;
    
    //自定义格式
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    [moneyFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *num = _pri;
    //NSLog(@"--第二种转换后的格式是--- %@",[moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]]);
    NSString * pris  = [moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]];
    //Title.text = [NSString stringWithFormat:@"¥%@",pris];
    NSString * PRI =  [NSString stringWithFormat:@"¥%@",pris];
    
    Title.textColor= [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:0.4];
    Title.font=[UIFont systemFontOfSize:16];
    
    //创建富文本,两段文字相加
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: PRI];
    NSString * BTC = [NSString stringWithFormat:@"  / %@",_Currency];
    NSAttributedString *third = [[NSAttributedString alloc] initWithString:BTC];
    
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, PRI.length)];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, PRI.length)];
    [attri appendAttributedString:third];
    
    Title.attributedText = attri;

    [Bgm addSubview:Title];
    //----
    UILabel * Meny = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, 70, 400, 40)];
    //NSLog(@"===%ld",(long)currentTime);
    
    
    Meny.textColor = [UIColor colorWithRed:255.0/255 green:255.1/255 blue:255.0/255 alpha:1];
    Meny.font=[UIFont systemFontOfSize:14];
    
    //UILable更改部分字体颜色
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还剩%lds，超时自动取消",(long)currentTime]];
    //更改字体
    //[string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] range:NSMakeRange(2, 4)];
    //修改颜色
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(2, 3)];
    Meny.attributedText = string;
    //Meny.text = [NSString stringWithFormat:@"还剩%lds，超时自动取消",(long)currentTime];
    [Bgm addSubview:Meny];

    
    UIImageView * carpic =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/9), 70+15, 15, 15)];
    UIImageView * carpicA =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/9+15+10), 70+15, 15, 15)];
    //NSLog(@"weixi==%@,alipay==%@",_weixin,_alipay);
    
    if ([_alipay isEqualToString:@"(null)"]) {
           carpic.image = [UIImage imageNamed:@"weixin"];
       } else if([_weixin isEqualToString:@"(null)"]) {
           carpic.image = [UIImage imageNamed:@"alipay"];
       } else{
           carpic.image = [UIImage imageNamed:@"alipay"];
           carpicA.image = [UIImage imageNamed:@"weixin"];
       }

    [Bgm addSubview:carpic];
    [Bgm addSubview:carpicA];
}
-(void)header_order
{
        //------------------------
        UIView * HeadPic= [[UIView alloc]initWithFrame:CGRectMake(20, 210, ScreenWidth-40, 250)];
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
         _Vol_A = [[UITextField alloc]initWithFrame:CGRectMake(10, 15, ScreenWidth-40-20, 50)];
          //vol.backgroundColor = [UIColor orangeColor];
          //vol.borderStyle = UITextBorderStyleRoundedRect;
          _Vol_A.layer.borderColor= [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1].CGColor;
          _Vol_A.layer.borderWidth= 1.0f;
          _Vol_A.layer.cornerRadius = 5.0;
          _Vol_A.layer.masksToBounds = NO;
          _Vol_A.keyboardType = UIKeyboardTypeDecimalPad;//弹出全数字键盘
          _Vol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
          _Vol_A.delegate = self;//
          //UITextFiled 输入的时候，左边留出一定的边距
          UIView * viewLeftA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 5)];
          _Vol_A.leftView = viewLeftA;
          _Vol_A.leftViewMode = UITextFieldViewModeAlways;
          //监听数量，使之金额会发生变动
          [_Vol_A addTarget:self action:@selector(Pric_vol_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
          


          
          //vol.placeholder  = @"请输入想购买的总数量";
          //占位符颜色
          NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
          NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请输入想购买的总数量" attributes:attDicA];
          _Vol_A.attributedPlaceholder = attPlaceA;
    //------------
          UILabel * BTC = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-40-20-95, 15, 60, 20)];
          BTC.text = _Currency;
          BTC.font  = [UIFont systemFontOfSize:16];
          [_Vol_A addSubview:BTC];
    //------------
          if ([_Currency isEqualToString:@"USDT"]) {
              UIView * Line =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-40-20-48, 17.5, 1, 15)];
              Line.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
              [_Vol_A addSubview:Line];
          } else {
              UIView * Line =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-40-20-55, 17.5, 1, 15)];
              Line.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
              
              [_Vol_A addSubview:Line];
          }
          

    //------------
          UIButton * All =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-40-20-55, 15, 60, 20)];
          [All setTitle:@"全部" forState:UIControlStateNormal];
          All.titleLabel.font = [UIFont systemFontOfSize: 16.0];
          [All setTitleColor:[UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1] forState:UIControlStateNormal];
          [All addTarget:self action:@selector(All_Pric_vol_textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
          [_Vol_A addSubview:All];


    
         [HeadPic addSubview:_Vol_A];
    
    
    
    //---------
         _Tatol_A = [[UITextField alloc]initWithFrame:CGRectMake(10, 85, ScreenWidth-40-20, 50)];
          //vol.backgroundColor = [UIColor orangeColor];
          //vol.borderStyle = UITextBorderStyleRoundedRect;
          _Tatol_A.layer.borderColor= [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1].CGColor;
          _Tatol_A.layer.borderWidth= 1.0f;
          _Tatol_A.layer.cornerRadius = 5.0;
          _Tatol_A.layer.masksToBounds = NO;
          _Tatol_A.keyboardType = UIKeyboardTypeDecimalPad;//弹出全数字键盘
          _Tatol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
          _Tatol_A.delegate = self;//
          //UITextFiled 输入的时候，左边留出一定的边距
          UIView * viewLeftB = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 5)];
          _Tatol_A.leftView = viewLeftB;
          _Tatol_A.leftViewMode = UITextFieldViewModeAlways;
          //监听购买金额，使之金额会发生变动
          [_Tatol_A addTarget:self action:@selector(Pric_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
          
    
   
         //vol.placeholder  = @"请输入想购买的总数量";
         //占位符颜色
         NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
         NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请输入想购买的总金额" attributes:attDic];
         _Tatol_A.attributedPlaceholder = attPlace;
    
    
    //------------
          UILabel * BTCA = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-40-20-95, 15, 60, 20)];
          BTCA.text = @"CNY";
          BTCA.font  = [UIFont systemFontOfSize:16];
          [_Tatol_A addSubview:BTCA];
    //------------

          UIView * Line =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-40-20-55, 17.5, 1, 15)];
          Line.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
          [_Tatol_A addSubview:Line];

          

    //------------
          UIButton * AllA =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-40-20-55, 15, 60, 20)];
          [AllA setTitle:@"全部" forState:UIControlStateNormal];
          AllA.titleLabel.font = [UIFont systemFontOfSize: 16.0];
          [AllA setTitleColor:[UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1] forState:UIControlStateNormal];
          //[AllA addTarget:self action:@selector(All_Pric_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
          [AllA addTarget:self action:@selector(All_Pric_textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
          [_Tatol_A addSubview:AllA];

        
         [HeadPic addSubview:_Tatol_A];
    //--------
         UILabel * Lima = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, ScreenWidth-40-20, 40)];
         //Lima.text = @"限额";
         int Num = [_LimitA intValue ];
         NSString *display = [NSNumberFormatter localizedStringFromNumber:@(Num) numberStyle:NSNumberFormatterDecimalStyle];
    
         int NumA = [_tatol intValue ];
         NSString *Adisplay = [NSNumberFormatter localizedStringFromNumber:@(NumA) numberStyle:NSNumberFormatterDecimalStyle];
         NSString * tatols = [NSString stringWithFormat:@"限额 ¥%@-¥%@",display,Adisplay];
         Lima.text = tatols;
    
         Lima.font = [UIFont systemFontOfSize:14];
         Lima.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
         [HeadPic addSubview:Lima];
    //-------------
         UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(10, 190, ScreenWidth-40-20, 40)];
         [Qbutton setTitle:@"购买" forState:UIControlStateNormal];
         [Qbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         Qbutton.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
         [Qbutton addTarget:self action:@selector(Add_goumai) forControlEvents:UIControlEventTouchUpInside];
         [HeadPic addSubview:Qbutton];
    
         [self.view addSubview:HeadPic];
        
        
    }
-(void)header_Megss
{
        //------------------------
        UIView * HeadPic= [[UIView alloc]initWithFrame:CGRectMake(20, 470, ScreenWidth-40, 250)];
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

    //--------
         UILabel * Lima = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, ScreenWidth-40-20, 20)];
         Lima.text = @"卖家信息";
         Lima.font = [UIFont systemFontOfSize:14];
         Lima.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
         [HeadPic addSubview:Lima];
    //--------
         UILabel * Lsname = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 100, 40)];
         Lsname.text = @"卖家呢称";
         Lsname.font = [UIFont systemFontOfSize:14];
         Lsname.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
         [HeadPic addSubview:Lsname];
         
         UILabel * Lsname_C = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 40, 100, 40)];
    
         //创建富文本
         NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: _Another];
         //NSTextAttachment可以将要插入的图片作为特殊字符处理
         NSTextAttachment *attch = [[NSTextAttachment alloc] init];
         //定义图片内容及位置和大小
         attch.image = [UIImage imageNamed:@"V"];
         attch.bounds = CGRectMake(2, -4, 20, 20);
         //创建带有图片的富文本
         NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
         //将图片放在最后一位
         [attri appendAttributedString:string];
         //将图片放在第一位
         //[attri insertAttributedString:string atIndex:0];
         //用label的attributedText属性来使用富文本
         Lsname_C.attributedText = attri;
         //Lsname_C.text = _Another;
         Lsname_C.font = [UIFont systemFontOfSize:14];
         Lsname_C.textAlignment = NSTextAlignmentRight;
         Lsname_C.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         [HeadPic addSubview:Lsname_C];
    //--------
         UILabel * Lsname_D = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 100, 40)];
         Lsname_D.text = @"单数完成率";
         Lsname_D.font = [UIFont systemFontOfSize:14];
         Lsname_D.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
         [HeadPic addSubview:Lsname_D];
         
         UILabel * Lsname_B = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 70, 100, 40)];

         int Vol_ID = arc4random() % 10+90;//成功交易率，100是生成百位以内的数
         int Vol_X = arc4random() % 10000;//成功交易单数，10000是生成千位以内的数
         Lsname_B.text = [NSString stringWithFormat:@"%d | %d%@",Vol_X,Vol_ID,@"%"];
         //Lsname_B.text = @"98%";
         Lsname_B.font = [UIFont systemFontOfSize:14];
         Lsname_B.textAlignment = NSTextAlignmentRight;
         Lsname_B.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         [HeadPic addSubview:Lsname_B];
    //--------
         UILabel * Lsname_E = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
         Lsname_E.text = @"认证等级";
         Lsname_E.font = [UIFont systemFontOfSize:14];
         Lsname_E.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
         [HeadPic addSubview:Lsname_E];
         
         UILabel * Lsname_F = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 100, 100, 40)];
         Lsname_F.text = _KYC;
         Lsname_F.font = [UIFont systemFontOfSize:14];
         Lsname_F.textAlignment = NSTextAlignmentRight;
         Lsname_F.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         [HeadPic addSubview:Lsname_F];
    //--------
         UILabel * Lsname_G = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 100, 40)];
         Lsname_G.text = @"放币时效";
         Lsname_G.font = [UIFont systemFontOfSize:14];
         Lsname_G.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
         [HeadPic addSubview:Lsname_G];
         
         UILabel * Lsname_H = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-160, 130, 100, 40)];
         int VolA_ID = arc4random() % 60;//成功交易率，100是生成百位以内的数
         Lsname_H.text = [NSString stringWithFormat:@"%d'",VolA_ID];
         Lsname_H.font = [UIFont systemFontOfSize:14];
         Lsname_H.textAlignment = NSTextAlignmentRight;
         Lsname_H.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         [HeadPic addSubview:Lsname_H];
    //--------
         UIView * lime = [[UIView alloc]initWithFrame:CGRectMake(10, 180, ScreenWidth-40-20, 1)];
         lime.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.1];
         [HeadPic addSubview:lime];
         
         UILabel * Lsname_I = [[UILabel alloc]initWithFrame:CGRectMake(10, 182, 400, 40)];
         NSString * conter = [NSString stringWithFormat:@"请付款、秒放币、付款不要备注 %@",_conter];
         Lsname_I.text = conter;
         Lsname_I.font = [UIFont systemFontOfSize:14];
         Lsname_I.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
         [HeadPic addSubview:Lsname_I];

     

        [self.view addSubview:HeadPic];
        
        
    }

- (void)timerBlock {
    //  __block int i = 1;
    currentTime = 50;
    //__weak __typeof(&*self)weakSelf = self;
    timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //++;加时
        
        self->currentTime--;//减时
        [self Header];
        
        //NSLog(@"%ld", (long)self->currentTime);
        
        
        if(self->currentTime <= 0) {
                    
                    [self releaseTimer];
                    [self performSelector:@selector(left:) withObject:self ];

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
//---监听计算
- (void)Pric_vol_textFieldDidChange:(UITextField *) TextField{
    //  UITextField * Vol_A;
    // UITextField * Tatol_A;
    //NSLog(@"%@",Pric.text);
    double total = [_Vol_A.text doubleValue] * [_pri doubleValue];
    //NSLog(@"==%.2f",total);
    _Tatol_A.text =[NSString stringWithFormat:@"%.2f",total];

}
//监听计算
- (void)Pric_textFieldDidChange:(UITextField *) TextField{
    
    //NSLog(@"%@",Pric_vol.text);
    double total = [_Tatol_A.text doubleValue] / [_pri doubleValue];
    //NSLog(@"==%.2f",total);
    _Vol_A.text =[NSString stringWithFormat:@"%.6f",total];

}
//---全部按钮监听计算
- (void)All_Pric_vol_textFieldDidChange:(UITextField *) TextField{
    
    //NSLog(@"%@",Pric_vol.text);
    //double totalU = [_vol doubleValue];
    //double total = [_vol doubleValue] * [_pri doubleValue];
    
    _Tatol_A.text =[NSString stringWithFormat:@"%.2f",[_tatol doubleValue]];
    _Vol_A.text =[NSString stringWithFormat:@"%.6f",[_vol doubleValue]];
    [_Vol_A becomeFirstResponder];

    //选中边框颜色
    _Vol_A.borderStyle = UITextBorderStyleNone;
    _Vol_A.layer.borderColor= [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1].CGColor;
    _Vol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    //移除其他边框颜色
    _Tatol_A.borderStyle = UITextBorderStyleNone;
    _Tatol_A.layer.borderColor= [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1].CGColor;
    _Tatol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2];
    //NSLog(@"==%.2f",total);
    //NSLog(@"==%.2f",totalU);

}
//---全部按钮监听计算
- (void)All_Pric_textFieldDidChange:(UITextField *) TextField{
    
    //NSLog(@"%@",Pric_vol.text);
    //double totalU = [_tatol doubleValue];
    //double total = [_tatol doubleValue] / [_pri doubleValue];
    
    _Vol_A.text =[NSString stringWithFormat:@"%.6f",[_vol doubleValue]];
    _Tatol_A.text =[NSString stringWithFormat:@"%.2f",[_tatol doubleValue]];
    [_Tatol_A becomeFirstResponder];
    //选中边框颜色
    _Tatol_A.borderStyle = UITextBorderStyleNone;
    _Tatol_A.layer.borderColor= [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1].CGColor;
    _Tatol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    //移除其他边框颜色
    _Vol_A.borderStyle = UITextBorderStyleNone;
    _Vol_A.layer.borderColor= [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1].CGColor;
    _Vol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2];
    //NSLog(@"==%.2f",total);
    //NSLog(@"==%.2f",totalU);

}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _Vol_A) {
            //选中边框颜色
        _Vol_A.borderStyle = UITextBorderStyleNone;
        _Vol_A.layer.borderColor= [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1].CGColor;
        _Vol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
        //移除其他边框颜色
        _Tatol_A.borderStyle = UITextBorderStyleNone;
        _Tatol_A.layer.borderColor= [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1].CGColor;
        _Tatol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2];
        
    } else if (textField == _Tatol_A){
        
            //选中边框颜色
        _Tatol_A.borderStyle = UITextBorderStyleNone;
        _Tatol_A.layer.borderColor= [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1].CGColor;
        _Tatol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
        //移除其他边框颜色
        _Vol_A.borderStyle = UITextBorderStyleNone;
        _Vol_A.layer.borderColor= [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1].CGColor;
        _Vol_A.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2];
    }
   

}
- (void)left:(id)sender
{
    [self releaseTimer];

    [self.navigationController popViewControllerAnimated:YES];

   
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // UIStatusBarStyleLightContent 白色
    // UIStatusBarStyleDefault      黑色

   return UIStatusBarStyleLightContent;

    
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
    [_Vol_A resignFirstResponder];
    [_Tatol_A resignFirstResponder];

   
 
}
-(void)Add_goumai
{
    //-------
      if ([_Vol_A.text isEqualToString:@""] ) {

         HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
         HUD.label.text = @"总数量不能为空！";
         // HUD.minSize = CGSizeMake(100, 10);
         HUD.offset = CGPointMake(0, -100);
         HUD.contentColor = [UIColor whiteColor];
         HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
         HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
         [MBProgressHUD hideHUDForView:self.view animated:YES];

         return;

      }
      if ( [_Tatol_A.text isEqualToString:@""]) {

         HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
         HUD.label.text = @"总金额不能为空！";
         // HUD.minSize = CGSizeMake(100, 10);
         HUD.offset = CGPointMake(0, -100);
         HUD.contentColor = [UIColor whiteColor];
         HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
         HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
         [MBProgressHUD hideHUDForView:self.view animated:YES];

         return;

      }
    
    Add_order_ViewController *vc = [[Add_order_ViewController alloc]init];
    [self releaseTimer];//停止当前计时器
    vc.tatol = _Tatol_A.text;
    vc.pri = _pri;
    vc.vol = _Vol_A.text;
    vc.Currency = _Currency;//币种
    vc.Another = _Another;//呢称
    vc.username  = _username;//用户名
    
    vc.type_S = self->_type_S ;//firstObject 数组最第一个值
    vc.car_name_S = self->_car_name_S ;
    vc.car_num_S = self->_car_num_S ;
    vc.alipay_S = self->_alipay_S ;
    vc.weixin_S = self->_weixin_S ;
    vc.black_A =_black_A;
 


    
    [self.navigationController pushViewController:vc animated:YES];
    
}
//请求卖家支付方式
-(void)json_pay
{

    
        //创建session对象
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *UserApi=APIURL_USER;
           
        NSURL *url = [NSURL URLWithString:UserApi];
        NSString * Urladd =[NSString stringWithFormat:@"action=pay_list&username=%@",_username];
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
                              

                            
                              
                          NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                            // NSString *string = [array componentsJoinedByString:@","];,为分隔符 [arr firstObject];
                          NSDictionary * array = [dict objectForKey:@"Megss"];
                            self->_type_S = [array valueForKey:@"type" ]  ;
                            self->_car_name_S = [array valueForKey:@"car_name"] ;
                            self->_car_num_S = [array valueForKey:@"car_num"];
                            self->_alipay_S = [array valueForKey:@"alipay"] ;
                            self->_weixin_S = [array valueForKey:@"weixin"] ;
                            // NSArray * weixin = [[array valueForKey:@"weixin"] componentsJoinedByString:@","];
                            // NSLog(@"username==%@==%@==%@",[type firstObject],self->_car_name,self->_car_num);
//                            self->_type = [self->_type_S lastObject];//firstObject 数组最第一个值
//                            self->_car_name = [ self->_car_name_S lastObject];
//                            self->_car_num = [self->_car_num_S lastObject];
//                            self->_alipay = [self->_alipay_S lastObject];
//                            self->_weixin = [self->_weixin_S lastObject];
                            // NSLog(@"==%@",array);
                             //修改状态，返回failure或success
                             //1008 修改成功 ，1009 修改失败 ，

                             NSString *status = [dict objectForKey:@"status"];
                             NSString *code = [dict objectForKey:@"code"];
                             if ([status isEqualToString:@"failure"])
                             {
                                 
                             NSLog(@"失败==%@",status);
                             NSLog(@"失败代码==%@",code);
                                 
                                              
                                                     
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

@end
