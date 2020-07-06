//
//  Pop_rz.m
//  topbar
//
//  Created by guo feng zou on 2020/3/17.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Pop_rz.h"
#import <objc/runtime.h>  //BUTTON多个传值使用
//循环支付方式
#define Start_X          ScreenWidth/30      // 第一个按钮的X坐标
#define Start_Y          85.0f     // 第一个按钮的Y坐标
//#define Width_Space      5.0f      // 2个按钮之间的横间距
#define Height_Space     20.0f     // 竖间距
#define Button_Height   40.0f    // 高
#define Button_Width    ScreenWidth-30.0f    // 宽


@interface Pop_rz()
{
    UIView * popup;
    MBProgressHUD * HUD;//提示器
   
}
@end
@implementation Pop_rz

-(instancetype)initWithFrame:(CGRect)frame{
    
  
   
    if (self == [super initWithFrame:frame]) {
        //[self initview];//任意地方可以取消当前窗口
    }
    return self;
}



-(void)initview{
    
     
    //
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    if ([_type isEqualToString:@"10"]) {
//            [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)]];
       // NSLog(@"不可按");
    } else {
            [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)]];
        //NSLog(@"可按");
    }

    if (popup == nil) {
        popup = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
     
        popup.backgroundColor = [UIColor whiteColor];
        [self addSubview:popup];
        [self KeyBoardHide_Yc];//点击空白处隐藏键盘

 
               
    }
}

-(void)Email_Web
{

    UIScrollView * Gundong  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth, ScreenHeight)];
    //不可滑动ontentSize设置和图片一样的高度就行了
    if ([_type isEqualToString:@"10"]) {
         Gundong.contentSize = CGSizeMake(popup.frame.size.width, popup.frame.size.height);
    } else {
         Gundong.contentSize = CGSizeMake(popup.frame.size.width, popup.frame.size.height+10);
    }
   


    [popup addSubview:Gundong];
    
//    _VEmail = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-80, 40)];
//    _VEmail.backgroundColor = [UIColor whiteColor];
//    //[_VEmail becomeFirstResponder];//呼出键盘
//    _VEmail.placeholder = @"Messages";
//    //_VEmail.layer.cornerRadius = 5.0;//圆角
//    //_VEmail.layer.masksToBounds = NO;
//    //左空格
//    _VEmail.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 60)];
//    _VEmail.leftViewMode = UITextFieldViewModeAlways;
//    [Gundong addSubview:_VEmail];
       
     //  _block(_type);//传递block值到上一级
     
     
    if ([_type isEqualToString:@"1"]) {
       
        
        UIButton *SURE  = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-100, 40)];
        [SURE setTitle:@"10分钟内完成付款" forState:(UIControlStateNormal)];
        //[SURE setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
        [SURE setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SURE.backgroundColor = [UIColor clearColor];
        SURE.tag = 0;
        NSString * KYC1  = @"10分钟内完成付款";
        objc_setAssociatedObject(SURE, "KYC", KYC1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
        [SURE addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:SURE];
        //白线
        UIView * LINE = [[UIView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth-80, 0.5)];
        LINE.backgroundColor  = [UIColor whiteColor];
        [Gundong addSubview:LINE];
        
        
        
        UIButton *SUREA  = [[UIButton alloc]initWithFrame:CGRectMake(10, 60, ScreenWidth-100, 40)];
        [SUREA setTitle:@"15分钟内完成付款" forState:(UIControlStateNormal)];
        [SUREA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SUREA.backgroundColor = [UIColor clearColor];
        SUREA.tag = 1;
        NSString * KYC2  = @"15分钟内完成付款";
        objc_setAssociatedObject(SUREA, "KYC", KYC2, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
        [SUREA addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:SUREA];
        //白线
        UIView * LINEA = [[UIView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth-80, 0.5)];
        LINEA.backgroundColor  = [UIColor whiteColor];
        [Gundong addSubview:LINEA];
        
        
        UIButton *SUREB  = [[UIButton alloc]initWithFrame:CGRectMake(10, 110, ScreenWidth-100, 40)];
        [SUREB setTitle:@"20分钟内完成付款" forState:(UIControlStateNormal)];
        [SUREB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SUREB.backgroundColor = [UIColor clearColor];
        SUREB.tag = 2;
        NSString * KYC3  = @"20分钟内完成付款";
        objc_setAssociatedObject(SUREB, "KYC", KYC3, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON多个传值使用
        [SUREB addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:SUREB];
        //白线
        UIView * LINEB = [[UIView alloc]initWithFrame:CGRectMake(0, 150, ScreenWidth-80, 0.5)];
        LINEB.backgroundColor  = [UIColor whiteColor];
        [Gundong addSubview:LINEB];

    } else if([_type isEqualToString:@"2"]) {
        
        UIButton *SURE  = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-100, 40)];
        [SURE setTitle:@"KYC1" forState:(UIControlStateNormal)];
        //[SURE setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
        [SURE setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SURE.backgroundColor = [UIColor clearColor];
        SURE.tag = 0;
        NSString * KYC1  = @"KYC1";
        objc_setAssociatedObject(SURE, "KYC", KYC1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
        [SURE addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:SURE];
        //白线
        UIView * LINE = [[UIView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth-80, 0.5)];
        LINE.backgroundColor  = [UIColor whiteColor];
        [Gundong addSubview:LINE];
        
        
        
        UIButton *SUREA  = [[UIButton alloc]initWithFrame:CGRectMake(10, 60, ScreenWidth-100, 40)];
        [SUREA setTitle:@"KYC2" forState:(UIControlStateNormal)];
        [SUREA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SUREA.backgroundColor = [UIColor clearColor];
        SUREA.tag = 1;
        NSString * KYC2  = @"KYC2";
        objc_setAssociatedObject(SUREA, "KYC", KYC2, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
        [SUREA addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:SUREA];
        //白线
        UIView * LINEA = [[UIView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth-80, 0.5)];
        LINEA.backgroundColor  = [UIColor whiteColor];
        [Gundong addSubview:LINEA];
        
        
        UIButton *SUREB  = [[UIButton alloc]initWithFrame:CGRectMake(10, 110, ScreenWidth-100, 40)];
        [SUREB setTitle:@"KYC3" forState:(UIControlStateNormal)];
        [SUREB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SUREB.backgroundColor = [UIColor clearColor];
        SUREB.tag = 2;
        NSString * KYC3  = @"KYC3";
        objc_setAssociatedObject(SUREB, "KYC", KYC3, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON多个传值使用
        [SUREB addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:SUREB];
        //白线
        UIView * LINEB = [[UIView alloc]initWithFrame:CGRectMake(0, 150, ScreenWidth-80, 0.5)];
        LINEB.backgroundColor  = [UIColor whiteColor];
        [Gundong addSubview:LINEB];

    }else if([_type isEqualToString:@"3"])
    {
        
        
        UIButton *SURE  = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-100, 40)];
        [SURE setTitle:@"微信" forState:(UIControlStateNormal)];
        //[SURE setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
        [SURE setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SURE.backgroundColor = [UIColor clearColor];
        SURE.tag = 0;
        NSString * KYC1  = @"微信";
        objc_setAssociatedObject(SURE, "KYC", KYC1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
        [SURE addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:SURE];
        //白线
        UIView * LINE = [[UIView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth-80, 0.5)];
        LINE.backgroundColor  = [UIColor whiteColor];
        [Gundong addSubview:LINE];
        
        
        
        UIButton *SUREA  = [[UIButton alloc]initWithFrame:CGRectMake(10, 60, ScreenWidth-100, 40)];
        [SUREA setTitle:@"支付宝" forState:(UIControlStateNormal)];
        [SUREA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SUREA.backgroundColor = [UIColor clearColor];
        SUREA.tag = 1;
        NSString * KYC2  = @"支付宝";
        objc_setAssociatedObject(SUREA, "KYC", KYC2, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
        [SUREA addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:SUREA];
        //白线
        UIView * LINEA = [[UIView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth-80, 0.5)];
        LINEA.backgroundColor  = [UIColor whiteColor];
        [Gundong addSubview:LINEA];
        
        
        UIButton *SUREB  = [[UIButton alloc]initWithFrame:CGRectMake(10, 110, ScreenWidth-100, 40)];
        [SUREB setTitle:@"银行卡" forState:(UIControlStateNormal)];
        [SUREB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SUREB.backgroundColor = [UIColor clearColor];
        SUREB.tag = 2;
        NSString * KYC3  = @"银行卡";
        objc_setAssociatedObject(SUREB, "KYC", KYC3, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON多个传值使用
        [SUREB addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:SUREB];
        //白线
        UIView * LINEB = [[UIView alloc]initWithFrame:CGRectMake(0, 150, ScreenWidth-80, 0.5)];
        LINEB.backgroundColor  = [UIColor whiteColor];
        [Gundong addSubview:LINEB];

    } else if([_type isEqualToString:@"4"])
    {
         UIView *VC =  [[UIView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, ScreenHeight)];
         //VC.backgroundColor  = [UIColor redColor];
         [popup addSubview:VC];
         

         //-------
         UILabel * lablelB= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, 5, 100, 40)];
         lablelB.text =@"安全认证";
         lablelB.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         lablelB.font = [UIFont systemFontOfSize:16];
         [VC addSubview:lablelB];
        
         //-------
         UIButton *Cancel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50,5,40,40)];
         [Cancel setTitle:@"取消" forState:UIControlStateNormal];
         [Cancel setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
         Cancel.titleLabel.font = [UIFont systemFontOfSize: 16];
         //Cancel.backgroundColor = [UIColor orangeColor];
         [Cancel addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
         [VC addSubview:Cancel];
        
         UIView * VCA = [[UIView alloc]initWithFrame:CGRectMake(0, 45+5 ,ScreenWidth, 1)];
         VCA.backgroundColor = RGBA(239, 239, 244, 1);
         [VC addSubview:VCA];
         
         //-------
         UILabel * lablelC= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, 45+5+10, ScreenWidth/2, 40)];
         lablelC.text =@"登陆密码";
         lablelC.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
         lablelC.font = [UIFont systemFontOfSize:14];
         [VC addSubview:lablelC];
         
         //----
         _password = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/30, 45+5+10+40+5, ScreenWidth/2, 40)];
         _password.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         //username.delegate = self;//限制输入字符,配合方法才能使用
        // 添加监听事件,弹出键盘向上推移
         [_password addTarget:self action:@selector(MEAG) forControlEvents:UIControlEventEditingDidBegin];
         //占位符颜色
         NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
         NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请输入登陆密码" attributes:attDic];
         _password.attributedPlaceholder = attPlace;
         _password.secureTextEntry = YES;//显示密码星号*
         [VC addSubview:_password];
        
         //-----密码明暗文显示
         UIButton * show = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50,45+5+10+40+5, 40, 40)];
         //[show setTitle:@"切换" forState:(UIControlStateNormal)];
         [show setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
         [show setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
         show.titleLabel.font = [UIFont systemFontOfSize:15];
         [show setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
         //[show setBackgroundColor:[UIColor redColor]];
         [show addTarget:self action:@selector(pwdTextSwitch:) forControlEvents:UIControlEventTouchUpInside];
         [VC addSubview:show];
        
         UIView * VCB = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/30, 45+5+10+40+5+40+5 ,ScreenWidth-30, 1)];
         VCB.backgroundColor = RGBA(239, 239, 244, 1);
         [VC addSubview:VCB];
        //-------
         UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/30, 45+5+10+40+5+40+5+40, ScreenWidth-30, 40)];
         [Qbutton setTitle:@"确认" forState:UIControlStateNormal];
         [Qbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         Qbutton.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
         [Qbutton addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
         [VC addSubview:Qbutton];

    }
    else if([_type isEqualToString:@"5"])
    {
         UIView *VC =  [[UIView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, ScreenHeight)];
         //VC.backgroundColor  = [UIColor redColor];
         [popup addSubview:VC];
         //NSLog(@"%@=%@=%@=%@=%@",_type_S,_car_name_S,_car_num_S,_alipay_S,_weixin_S);
         

         //-------
         UILabel * lablelB= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, 5, 100, 40)];
         lablelB.text =@"选择支付方式";
         lablelB.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
         lablelB.font = [UIFont systemFontOfSize:16];
         [VC addSubview:lablelB];
        
         //-------
         UIButton *Cancel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50,5,40,40)];
         [Cancel setTitle:@"取消" forState:UIControlStateNormal];
         [Cancel setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
         Cancel.titleLabel.font = [UIFont systemFontOfSize: 16];
         //Cancel.backgroundColor = [UIColor orangeColor];
         [Cancel addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
         [VC addSubview:Cancel];
        
         UIView * VCA = [[UIView alloc]initWithFrame:CGRectMake(0, 45+5 ,ScreenWidth, 1)];
         VCA.backgroundColor = RGBA(239, 239, 244, 1);
         [VC addSubview:VCA];

        for (int i = 0; i<_type_S.count; i++)

           {
                NSInteger index = i % 1;
                NSInteger page = i / 1;


                
                NSString * type = [NSString stringWithFormat:@"%@", _type_S [i]];
                NSString * car_name = [NSString stringWithFormat:@"%@", _car_name_S [i]];
                NSString * car_num = [NSString stringWithFormat:@"%@", _car_num_S [i]];
                NSString * weixin = [NSString stringWithFormat:@"%@", _weixin_S [i]];
                NSString * alipay = [NSString stringWithFormat:@"%@", _alipay_S [i]];
                UIButton *pay = [[UIButton alloc]initWithFrame:CGRectMake(index * (Button_Width ) + Start_X, page  * (Button_Height + Height_Space)+Start_Y, Button_Width, Button_Height)];
                [pay setTitle:type forState:UIControlStateNormal];
                pay.tag = i;//这句话不写等于废了
                [pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                pay.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
                objc_setAssociatedObject(pay, "Type", type, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
                objc_setAssociatedObject(pay, "Car_name", car_name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
                objc_setAssociatedObject(pay, "Car_num", car_num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
                objc_setAssociatedObject(pay, "Weixin", weixin, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
                objc_setAssociatedObject(pay, "Alipay", alipay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//BUTTON多个传值使用
                [pay addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];

                [VC addSubview:pay];
               
               



            }

    }else if([_type isEqualToString:@"6"]) {
        
        UILabel *SURE  = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, ScreenWidth-100, 40)];
        SURE.text = @"确认离开支付";
        SURE.textColor = [UIColor  colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
        SURE.font = [UIFont boldSystemFontOfSize:20];
        [Gundong addSubview:SURE];
       
 
        UILabel *SUREA  = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, ScreenWidth-100, 20)];
        SUREA.text = @"如你已付款，请务必先点击“我已付款成功”";
        SUREA.textColor = [UIColor orangeColor];
        SUREA.font = [UIFont systemFontOfSize:14];
        [Gundong addSubview:SUREA];
        
        
        UILabel *SUREB  = [[UILabel alloc]initWithFrame:CGRectMake(20, 84, ScreenWidth-100, 20)];
        int time = [_currentTime intValue];
        int seconds = time % 60;
        int minutes = (time / 60) % 60;
         NSString * Atime = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
        
        SUREB.text =[NSString stringWithFormat:@"订单将在%@后超时取消",Atime];
        SUREB.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.3];
        SUREB.font = [UIFont systemFontOfSize:14];
        [Gundong addSubview:SUREB];
        
        UILabel *SUREC  = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, ScreenWidth-100, 20)];
        
        //创建富文本
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: @" 我确认还没有付款给对方"];
        //NSTextAttachment可以将要插入的图片作为特殊字符处理
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        //定义图片内容及位置和大小
        attch.image = [UIImage imageNamed:@"V"];
        attch.bounds = CGRectMake(0, -4, 20, 20);
        //创建带有图片的富文本
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        //将图片放在最后一位
        //[attri appendAttributedString:string];
        //将图片放在第一位
        [attri insertAttributedString:string atIndex:0];
        //用label的attributedText属性来使用富文本
        SUREC.attributedText = attri;
        
        //SUREC.text = @"我确认还没有付款给对方";
        SUREC.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
        SUREC.font = [UIFont systemFontOfSize:14];
        [Gundong addSubview:SUREC];
        
       //-------
        UIButton *Cancel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-60+40, 170, 60, 40)];
        [Cancel setTitle:@"取消" forState:UIControlStateNormal];
        [Cancel setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
        Cancel.titleLabel.font = [UIFont systemFontOfSize: 16.0];
        //Cancel.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
        [Cancel addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:Cancel];
        
        UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-60+40+20+40, 170, 80, 40)];
        [Qbutton setTitle:@"确认离开" forState:UIControlStateNormal];
        [Qbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        Qbutton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
        //Qbutton.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
        NSString * KYC  = @"0";
        objc_setAssociatedObject(Qbutton, "KYC", KYC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON多个传值使用
        [Qbutton addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
        [Gundong addSubview:Qbutton];
 

    }else if([_type isEqualToString:@"7"]) {
           
           UILabel *SURE  = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, ScreenWidth-100, 40)];
           SURE.text = @"付款确认";
           SURE.textColor = [UIColor  colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
           SURE.font = [UIFont boldSystemFontOfSize:20];
           [Gundong addSubview:SURE];
          
    
           UILabel *SUREA  = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, ScreenWidth-100, 20)];
           SUREA.text = @"请确认您已向买家付款”";
           SUREA.textColor = [UIColor orangeColor];
           SUREA.font = [UIFont systemFontOfSize:14];
           [Gundong addSubview:SUREA];
           
           
           
           UILabel *SUREC  = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, ScreenWidth-100, 20)];
           
           //创建富文本
           NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: @" 恶意点击将直接冻结帐户"];
           //NSTextAttachment可以将要插入的图片作为特殊字符处理
           NSTextAttachment *attch = [[NSTextAttachment alloc] init];
           //定义图片内容及位置和大小
           attch.image = [UIImage imageNamed:@"V"];
           attch.bounds = CGRectMake(0, -4, 20, 20);
           //创建带有图片的富文本
           NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
           //将图片放在最后一位
           //[attri appendAttributedString:string];
           //将图片放在第一位
           [attri insertAttributedString:string atIndex:0];
           //用label的attributedText属性来使用富文本
           SUREC.attributedText = attri;
           
           //SUREC.text = @"我确认还没有付款给对方";
           SUREC.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
           SUREC.font = [UIFont systemFontOfSize:14];
           [Gundong addSubview:SUREC];
           
          //-------
           UIButton *Cancel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-60+40, 170, 60, 40)];
           [Cancel setTitle:@"取消" forState:UIControlStateNormal];
           [Cancel setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
           Cancel.titleLabel.font = [UIFont systemFontOfSize: 16.0];
           //Cancel.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
           [Cancel addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
           [Gundong addSubview:Cancel];
           
           UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-60+40+20+40, 170, 80, 40)];
           [Qbutton setTitle:@"确认付款" forState:UIControlStateNormal];
           [Qbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
           Qbutton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
           //Qbutton.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
           NSString * KYC  = @"1";
           objc_setAssociatedObject(Qbutton, "KYC", KYC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON多个传值使用
           [Qbutton addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
           [Gundong addSubview:Qbutton];
    

       }
    else if([_type isEqualToString:@"8"]) {
           
           UILabel *SURE  = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, ScreenWidth-100, 40)];
           SURE.text = @"确认离开收款";
           SURE.textColor = [UIColor  colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
           SURE.font = [UIFont boldSystemFontOfSize:20];
           [Gundong addSubview:SURE];
          
    
           UILabel *SUREA  = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, ScreenWidth-100, 20)];
           SUREA.text = @"如你已收到款项，请务必先点击“我已确认收款”";
           SUREA.textColor = [UIColor orangeColor];
           SUREA.font = [UIFont systemFontOfSize:14];
           [Gundong addSubview:SUREA];
           
           
           UILabel *SUREB  = [[UILabel alloc]initWithFrame:CGRectMake(20, 84, ScreenWidth-100, 20)];
           int time = [_currentTime intValue];
           int seconds = time % 60;
           int minutes = (time / 60) % 60;
            NSString * Atime = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
           
           SUREB.text =[NSString stringWithFormat:@"订单将在%@后超时取消",Atime];
           SUREB.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.3];
           SUREB.font = [UIFont systemFontOfSize:14];
           [Gundong addSubview:SUREB];
           
           UILabel *SUREC  = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, ScreenWidth-100, 20)];
           
           //创建富文本
           NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: @" 我确认还没收到买家的付款"];
           //NSTextAttachment可以将要插入的图片作为特殊字符处理
           NSTextAttachment *attch = [[NSTextAttachment alloc] init];
           //定义图片内容及位置和大小
           attch.image = [UIImage imageNamed:@"V"];
           attch.bounds = CGRectMake(0, -4, 20, 20);
           //创建带有图片的富文本
           NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
           //将图片放在最后一位
           //[attri appendAttributedString:string];
           //将图片放在第一位
           [attri insertAttributedString:string atIndex:0];
           //用label的attributedText属性来使用富文本
           SUREC.attributedText = attri;
           
           //SUREC.text = @"我确认还没有付款给对方";
           SUREC.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
           SUREC.font = [UIFont systemFontOfSize:14];
           [Gundong addSubview:SUREC];
           
          //-------
           UIButton *Cancel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-60+40, 170, 60, 40)];
           [Cancel setTitle:@"取消" forState:UIControlStateNormal];
           [Cancel setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
           Cancel.titleLabel.font = [UIFont systemFontOfSize: 16.0];
           //Cancel.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
           [Cancel addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
           [Gundong addSubview:Cancel];
           
           UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-60+40+20+40, 170, 80, 40)];
           [Qbutton setTitle:@"确认离开" forState:UIControlStateNormal];
           [Qbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
           Qbutton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
           //Qbutton.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
           NSString * KYC  = @"0";
           objc_setAssociatedObject(Qbutton, "KYC", KYC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON多个传值使用
           [Qbutton addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
           [Gundong addSubview:Qbutton];
    

       }
    else if([_type isEqualToString:@"9"]) {
           
           UILabel *SURE  = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, ScreenWidth-100, 40)];
           SURE.text = @"收款确认";
           SURE.textColor = [UIColor  colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
           SURE.font = [UIFont boldSystemFontOfSize:20];
           [Gundong addSubview:SURE];
          
    
           UILabel *SUREA  = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, ScreenWidth-100, 20)];
           SUREA.text = @"一蛋确认收款将无法撤销，谨记！";
           SUREA.textColor = [UIColor orangeColor];
           SUREA.font = [UIFont systemFontOfSize:14];
           [Gundong addSubview:SUREA];
           
           
           
           UILabel *SUREC  = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, ScreenWidth-100, 20)];
           
           //创建富文本
           NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: @" 请确认您收到买家付款"];
           //NSTextAttachment可以将要插入的图片作为特殊字符处理
           NSTextAttachment *attch = [[NSTextAttachment alloc] init];
           //定义图片内容及位置和大小
           attch.image = [UIImage imageNamed:@"V"];
           attch.bounds = CGRectMake(0, -4, 20, 20);
           //创建带有图片的富文本
           NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
           //将图片放在最后一位
           //[attri appendAttributedString:string];
           //将图片放在第一位
           [attri insertAttributedString:string atIndex:0];
           //用label的attributedText属性来使用富文本
           SUREC.attributedText = attri;
           
           //SUREC.text = @"我确认还没有付款给对方";
           SUREC.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
           SUREC.font = [UIFont systemFontOfSize:14];
           [Gundong addSubview:SUREC];
           
          //-------
           UIButton *Cancel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-60+40, 170, 60, 40)];
           [Cancel setTitle:@"取消" forState:UIControlStateNormal];
           [Cancel setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
           Cancel.titleLabel.font = [UIFont systemFontOfSize: 16.0];
           //Cancel.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
           [Cancel addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
           [Gundong addSubview:Cancel];
           
           UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-60+40+20+40, 170, 80, 40)];
           [Qbutton setTitle:@"确认收款" forState:UIControlStateNormal];
           [Qbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
           Qbutton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
           //Qbutton.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
           NSString * KYC  = @"1";
           objc_setAssociatedObject(Qbutton, "KYC", KYC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON多个传值使用
           [Qbutton addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
           [Gundong addSubview:Qbutton];
    

       }
    else if([_type isEqualToString:@"10"]) {
          
           
           UIImageView *SURE  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-80, 400)];
           //SURE.image  = [UIImage imageNamed:@"Ad2020"];
           NSString *api_url = [NSString stringWithFormat:@"%@",_AD_URL];
           NSString *urlString =[APIURL stringByAppendingString:api_url];
           NSString *string = urlString;
           NSURL *picURL = [NSURL URLWithString:string];
           [SURE sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"nopic.png"] ];
    
  
           SURE.layer.cornerRadius = 9.0;//圆角
           SURE.layer.masksToBounds = YES;
        
           [Gundong addSubview:SURE];
          
           //---
           
          // UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-80, 300, 80, 40)];
           UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/30, 340, ScreenWidth-110, 40)];
           Qbutton.layer.cornerRadius = 9.0;//圆角
           Qbutton.layer.masksToBounds = NO;
           [Qbutton setTitle:@"立即参与" forState:UIControlStateNormal];
           [Qbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
           Qbutton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
           Qbutton.backgroundColor = [UIColor orangeColor];
           
           objc_setAssociatedObject(Qbutton, "KYC", _AD_id, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON多个传值使用
           [Qbutton addTarget:self action:@selector(btn_chick:) forControlEvents:UIControlEventTouchUpInside];
           [Gundong addSubview:Qbutton];
        
          //-------
           UIButton *Cancel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-80, 400, 80, 80)];
           [Cancel setImage:[UIImage imageNamed:@"Ad_canel"] forState:UIControlStateNormal];
           //Cancel.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
           [Cancel addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
           [Gundong addSubview:Cancel];
    

       }



}

-(void)btn_chick:(UIButton *)sender{
  

    if ([_password.text isEqualToString:@""]) {
        HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
        HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
        HUD.label.text = @"密码不能为空";
        //HUD.minSize = CGSizeMake(100, 10);
        HUD.offset = CGPointMake(0, -300);
        HUD.contentColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
        HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
        [MBProgressHUD hideHUDForView:self animated:YES];
     return;
    }
   
    //NSString *tagB =  [NSString stringWithFormat: @"%ld", (long)sender.tag];//取buttn的ID
    //NSLog(@"%@",tagB);
    
    if ([_type isEqualToString:@"4"]) {
         [self json];


    } else if([_type isEqualToString:@"5"]) {

        id TYPE = objc_getAssociatedObject(sender, "Type");
        id car_name = objc_getAssociatedObject(sender, "Car_name");
        id car_num = objc_getAssociatedObject(sender, "Car_num");
        id weixin = objc_getAssociatedObject(sender, "Weixin");
        id alipay = objc_getAssociatedObject(sender, "Alipay");
        NSArray * Array =  @[TYPE,car_name,car_num,weixin,alipay];
       
        self.callBcakBlock(Array);//传递数组

            [self dismissView];
    }
      else {
         id KYC = objc_getAssociatedObject(sender, "KYC");//取参
 
            _block(KYC);//传递block值到上一级,只传字符串
          //NSLog(@"%@",KYC);
          
          
            [self dismissView];
    }

   
   
}


//弹窗显示一
- (void)coutomshowInView:(UIView *)view{
   //   [self Email_Web];
    if (!view){
        return;
    }
    [view addSubview:self];
    
    [popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 316)];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [self->popup setFrame:CGRectMake(0, ScreenHeight - 316, ScreenWidth, 316)];
    } completion:nil];
}

//弹窗显示二
- (void)showInView{
    //NSLog(@"%@",_type)为了取上一页传过来的值生交，只有这里执行 Email_Web.
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:popup];
    [self initview];//按任意地方不可取消本窗口，做了个判断
    [self Email_Web];
    if ([_type isEqualToString:@"4"] || [_type isEqualToString:@"5"]) {
        
           
        //[popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 316)];
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1.0;
            [self->popup setFrame:CGRectMake(0, ScreenHeight - 316, ScreenWidth, 316)];
        } completion:nil];
    
    } else if([_type isEqualToString:@"6"] || [_type isEqualToString:@"7"]|| [_type isEqualToString:@"8"]|| [_type isEqualToString:@"9"]) {
        
          
          // [popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 220)];
           popup.backgroundColor = [UIColor whiteColor];;
           popup.layer.cornerRadius = 9.0;//圆角
           popup.layer.masksToBounds = NO;
           [UIView animateWithDuration:0.3 animations:^{
           self.alpha = 1.0;
           [self->popup setFrame:CGRectMake(20, ScreenHeight/2-50, ScreenWidth-40, 220)];
               } completion:nil];

    }else if([_type isEqualToString:@"10"]) {
        
          
          // [popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 440)];
           popup.backgroundColor = [UIColor clearColor];
           popup.layer.cornerRadius = 9.0;//圆角
           popup.layer.masksToBounds = NO;
           [UIView animateWithDuration:0.3 animations:^{
           self.alpha = 1.0;
           [self->popup setFrame:CGRectMake(40, ScreenHeight/5, ScreenWidth-80, 500)];
               } completion:nil];

    }else{
          // [popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 200)];
           popup.backgroundColor = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:0.7];;
           popup.layer.cornerRadius = 9.0;//圆角
           popup.layer.masksToBounds = NO;
           [UIView animateWithDuration:0.3 animations:^{
           self.alpha = 1.0;
           [self->popup setFrame:CGRectMake(40, ScreenHeight/2-10, ScreenWidth-80, 200)];
               } completion:nil];

    }
   
    
}

- (void)dismissView{

    if ([_type isEqualToString:@"4"]  || [_type isEqualToString:@"5"]) {
        
        //[popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 316)];
           [UIView animateWithDuration:0.0f
                            animations:^{
                                self.alpha = 0.0;
                                
                                [self->popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 316)];
                            }
                            completion:^(BOOL finished){
                                [self removeFromSuperview];
                                [self->popup removeFromSuperview];
                                
                            }];
        
    }
    else if([_type isEqualToString:@"6"] || [_type isEqualToString:@"7"]|| [_type isEqualToString:@"8"]|| [_type isEqualToString:@"9"]){
   // [popup setFrame:CGRectMake(20, ScreenHeight/2-50, ScreenWidth-40, 220)];
       [UIView animateWithDuration:0.4f
                        animations:^{
                            self.alpha = 0.0;
                            
                            [self->popup setFrame:CGRectMake(20, ScreenHeight, ScreenWidth-40, 220)];
                        }
                        completion:^(BOOL finished){
                            [self removeFromSuperview];
                            [self->popup removeFromSuperview];
                            
                        }];
     
          
    }
    else if([_type isEqualToString:@"10"]){
    //[popup setFrame:CGRectMake(40, ScreenHeight/2-50, ScreenWidth-80, 420)];
       [UIView animateWithDuration:0.4f
                        animations:^{
                            self.alpha = 0.0;
                            
                            [self->popup setFrame:CGRectMake(40, ScreenHeight, ScreenWidth-80, 500)];
                        }
                        completion:^(BOOL finished){
                            [self removeFromSuperview];
                            [self->popup removeFromSuperview];
                            
                        }];
     
          
    }else
       {
    //[popup setFrame:CGRectMake(40, ScreenHeight/2-10, ScreenWidth-80, 200)];
       [UIView animateWithDuration:0.4f
                        animations:^{
                            self.alpha = 0.0;
                            
                            [self->popup setFrame:CGRectMake(40, ScreenHeight, ScreenWidth-80, 200)];
                        }
                        completion:^(BOOL finished){
                            [self removeFromSuperview];
                            [self->popup removeFromSuperview];
                            
                        }];
     
          
    }
}


//密码文暗显示
- (IBAction)pwdTextSwitch:(UIButton *)sender {
     
    
    // 前提:在xib中设置按钮的默认与选中状态的背景图
    // 切换按钮的状态
    sender.selected = !sender.selected;
    
    if (sender.selected) { // 按下去了就是明文
        
        NSString *tempPwdStr = _password.text;
        _password.text = @""; // 这句代码可以防止切换的时候光标偏移
        _password.secureTextEntry = NO;
        _password.text = tempPwdStr;

        
        
    } else { // 暗文
        
        NSString *tempPwdStr = _password.text;
        _password.text = @"";
        _password.secureTextEntry = YES;
        _password.text = tempPwdStr;

        
    }
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
            self->popup.transform = CGAffineTransformMakeTranslation(0, - ty);
        }];


}
   //点击空白处隐藏键盘
-(void)KeyBoardHide_Yc
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [popup addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_password resignFirstResponder];
    
 
   
 
}
-(void)json
{
           //---打开沙盒用户文件件
           NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
           NSString *documentsPath = [documentsPathArr lastObject];
           NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
           NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    
           //---沙盒里用户信息
 
           NSString * username = [dic objectForKey:@"username"];//帐户名称


           //创建session对象
           NSURLSession *session = [NSURLSession sharedSession];
           NSString *UserApi=APIURL_USER;
              
           NSURL *url = [NSURL URLWithString:UserApi];
           NSString * Urladd =[NSString stringWithFormat:@"action=password_face&username=%@&password=%@",username,_password.text];
           
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
                         //NSString *code =[dict objectForKey:@"code"];
                         //NSLog(@"==%@",dict);
                       

                         if ([status isEqualToString:@"failure"]) {
                             
                             //NSLog(@"失败==%@",status);
                             //NSLog(@"失败代码==%@",code);
                             
                             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
                             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                         // Do something...
                                   
                                      self->HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
                                      self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
                                      self->HUD.label.text = @"密码不正确，请重新输入";
                                      //HUD.minSize = CGSizeMake(100, 10);
                                      self->HUD.offset = CGPointMake(0, -300);
                                      self->HUD.contentColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
                                      self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
                                      [MBProgressHUD hideHUDForView:self animated:YES];
                                      return;
                                           
                                     
                             });
   
                                       
                                      
                         } else {
                             //NSLog(@"成功==%@",status);
                             //NSLog(@"成功代码==%@",code);
                             
                             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
                            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                           
                                       [self dismissView];
                              });
                                     
                             self->_block(@"FACE ID");//传递block值到上一级,这里是任意值，只是返回使得面容ID能执行
                           
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

@end
