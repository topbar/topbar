//
//  Login_ViewController.m
//  topbar
//
//  Created by topbar on 2019/10/21.
//  Copyright © 2019 guo feng zou. All rights reserved.
//登陆/注册

#import "Login_ViewController.h"
#import "Zc_ViewController.h"



@interface Login_ViewController ()
@property (nonatomic, assign)NSInteger maxLenght;

@end

@implementation Login_ViewController

- (void)viewDidLoad {
     [super viewDidLoad];



     [self Uivew_Share];
     [self Login_UI];
     [self KeyBoardHide_Yc];

//    //显示沙盒路径
//    NSArray * paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSLog(@"沙盒路径:%@",paths);

}

- (void)Login_loadView {
 
    [self Uivew_Share];
    [self Login_UI];
    [self KeyBoardHide_Yc];
    

}

- (void)Reg_loadView {
   
   [self Uivew_Share];
   [self Reg_UI];
   [self KeyBoardHide_Yc];
    

}
-(void)Login_UI
{
 
    [self Close];
    UILabel * denglu = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10, ScreenWidth/2, 40)];
    denglu.textColor = [UIColor whiteColor];
    denglu.font = [UIFont systemFontOfSize:22];
    denglu.text =@"登录TopBar";
    [self.Share_View addSubview:denglu];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+30, ScreenWidth, 40)];
    label.textColor =[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2];
    label.font =[UIFont systemFontOfSize:14];
    label.text =@"你可以使用TopBar国际站帐号登录";
    [self.Share_View addSubview:label];
    
 
    username = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20, ScreenWidth-120, 40)];
    //username.placeholder = @" 请输入登陆手机号码";
    username.textColor = [UIColor whiteColor];
    username.delegate = self;//限制输入字符,配合方法才能使用
    //占位符颜色
    NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
    NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请输入登录手机号码" attributes:attDic];
    username.attributedPlaceholder = attPlace;
//    //右边图
//    UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    imagev.image = [UIImage imageNamed:@"about"];
//    username.rightView = imagev;
//    username.rightViewMode = UITextFieldViewModeAlways;
//    //左边文件
//    UILabel *paddingLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 25)];
//    paddingLb.text = @"$";
//    paddingLb.textColor = [UIColor redColor];
//    paddingLb.backgroundColor = [UIColor clearColor];
//    username.leftView = paddingLb;
//    username.leftViewMode = UITextFieldViewModeAlways;//必不可少

    
    // username.keyboardType = UIKeyboardTypeASCIICapableNumberPad;//弹出全数字键盘
    //设置边框样式
    //username.borderStyle = UITextBorderStyleRoundedRect;
    UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40 ,ScreenWidth-120, 1)];
    VC.backgroundColor = RGBA(255, 255, 255, 0.4);
    [self.Share_View addSubview:VC];
    [self.Share_View addSubview:username];
    
    
    password = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20, ScreenWidth-200, 40)];
    password.textColor = [UIColor whiteColor];
    password.delegate = self;//限制输入字符,配合方法才能使用
   //password.placeholder = @" 请输入登陆密码";
    //占位符颜色
    NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
    NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请输入登陆密码" attributes:attDicA];
    password.attributedPlaceholder = attPlaceA;
    password.secureTextEntry = YES;//显示密码星号*
    
    //密码明暗文显示
    UIButton * show = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-35.f*2)-(ScreenWidth/7),ScreenHeight/10+40+20+40+20+40+20, 40, 20)];
    //[show setTitle:@"切换" forState:(UIControlStateNormal)];
    [show setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [show setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
    show.titleLabel.font = [UIFont systemFontOfSize:15];
    [show setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    //[show setBackgroundColor:[UIColor redColor]];
    [show addTarget:self action:@selector(pwdTextSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.Share_View addSubview:show];
  
        
    //设置边框样式
    UIView * VCA = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20+40 ,ScreenWidth-120, 1)];
    VCA.backgroundColor = RGBA(255, 255, 255, 0.4);
    [self.Share_View addSubview:VCA];
    [self.Share_View addSubview:password];
    
    
    
    
    
    
    QRcode = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20+40+20, ScreenWidth-200, 40)];
    QRcode.textColor = [UIColor whiteColor];
    QRcode.delegate = self;//限制输入字符,配合方法才能使用
    //password.placeholder = @" 请输入登陆密码";
    //占位符颜色
    NSMutableDictionary *attDicD = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
    NSMutableAttributedString *attPlaceD = [[NSMutableAttributedString alloc] initWithString:@"GOOGLE验证码" attributes:attDicD];
    QRcode.attributedPlaceholder = attPlaceD;
        
          
    //设置边框样式
    UIView * VCD = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20+40+40+20 ,ScreenWidth-120, 1)];
    VCD.backgroundColor = RGBA(255, 255, 255, 0.4);
    [self.Share_View addSubview:VCD];
    [self.Share_View addSubview:QRcode];


   
    UIButton * reg = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-35.f*2)-(ScreenWidth-130), 0, ScreenWidth, 40)];
    // reg.backgroundColor = [UIColor orangeColor];
     [reg setTitle:@"注册新帐号" forState:(UIControlStateNormal)];
     [reg setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
     reg.titleLabel.font = [UIFont systemFontOfSize:15];
     [reg setTag:0];// 0 注册介面切换 ， 1 登陆介面切换
     [reg addTarget:self action:@selector(User_UI_TouchDown:) forControlEvents:UIControlEventTouchUpInside];
     [self.Share_View addSubview:reg];
    
    UIButton * login = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20+40+60+40, ScreenWidth-120, 40)];
     login.backgroundColor = RGBA(255, 255, 255, 0.4);
     login.layer.cornerRadius = 20.0;//2.0是圆角的弧度，根据需求自己更改
     login.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);//设置边框颜色
     login.layer.borderWidth = 1.0f;//
     [login setTitle:@"登录" forState:(UIControlStateNormal)];
   //[login setTitleColor:RGBA(255, 255, 255, 0.4) forState:(UIControlStateNormal)];
     [login setTag:1];// 0 请求注册 ， 1 请求登陆
     [login addTarget:self action:@selector(User_TouchDown:) forControlEvents:UIControlEventTouchUpInside];
     [self.Share_View addSubview:login];
    
    
    UIButton * forge = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-35.f*2)-(ScreenWidth-130), ScreenHeight/10+40+20+40+20+40+20+40+60+40+20+40, ScreenWidth, 40)];
       // reg.backgroundColor = [UIColor orangeColor];
     [forge setTitle:@"忘记密码" forState:(UIControlStateNormal)];
     forge.titleLabel.font = [UIFont systemFontOfSize:15];
     [forge setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
     [forge addTarget:self action:@selector(Close_TouchDown) forControlEvents:UIControlEventTouchUpInside];
     [self.Share_View addSubview:forge];
    
 
}


-(void)Reg_UI
{
  
    [self Close];
        UILabel * denglu = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10, ScreenWidth/2, 40)];
        denglu.textColor = [UIColor whiteColor];
        denglu.font = [UIFont systemFontOfSize:22];
        denglu.text =@"注册TopBar";
        [self.Share_View addSubview:denglu];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+30, ScreenWidth, 40)];
        label.textColor =[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2];
        label.font =[UIFont systemFontOfSize:14];
        label.text =@"你可以使用TopBar国际站帐号登录";
        [self.Share_View addSubview:label];
     
        username = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20, ScreenWidth, 40)];
        //username.placeholder = @" 请输入登陆手机号码";
        username.textColor = [UIColor whiteColor];
        username.delegate = self;//限制输入字符,配合方法才能使用
        //占位符颜色
        NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
        NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请输入注册手机号码" attributes:attDic];
        username.attributedPlaceholder = attPlace;
    
        //设置边框样式
        //username.borderStyle = UITextBorderStyleRoundedRect;
        UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40 ,ScreenWidth-120, 1)];
        VC.backgroundColor = RGBA(255, 255, 255, 0.4);
        [self.Share_View addSubview:VC];
        [self.Share_View addSubview:username];
        
        
        password = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20, ScreenWidth-200, 40)];
        password.textColor = [UIColor whiteColor];
        password.delegate = self;//限制输入字符,配合方法才能使用
       //password.placeholder = @" 请输入登陆密码";
        //占位符颜色
        NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
        NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"密码(不少于6个字符)" attributes:attDicA];
        password.attributedPlaceholder = attPlaceA;
        password.secureTextEntry = YES;//显示密码星号*
    
        //密码明暗文显示
        UIButton * show = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-35.f*2)-(ScreenWidth/7),ScreenHeight/10+40+20+40+20+40+20, 40, 20)];
        //[show setTitle:@"切换" forState:(UIControlStateNormal)];
        [show setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
        [show setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
        show.titleLabel.font = [UIFont systemFontOfSize:15];
        [show setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [show addTarget:self action:@selector(pwdTextSwitch:) forControlEvents:UIControlEventTouchUpInside];
        [self.Share_View addSubview:show];
        
        //设置边框样式
        UIView * VCA = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20+40 ,ScreenWidth-120, 1)];
        VCA.backgroundColor = RGBA(255, 255, 255, 0.4);
        [self.Share_View addSubview:VCA];
        [self.Share_View addSubview:password];
    
    
        code = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20+40+20, ScreenWidth, 40)];
        code.textColor = [UIColor whiteColor];
        //password.placeholder = @" 请输入登陆密码";
         //占位符颜色
        NSMutableDictionary *attDicB = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
        NSMutableAttributedString *attPlaceB = [[NSMutableAttributedString alloc] initWithString:@"短信验证码" attributes:attDicB];
        code.attributedPlaceholder = attPlaceB;
        //设置边框样式
        UIView * VCB = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20+40+40+20 ,ScreenWidth-120, 1)];
        VCB.backgroundColor = RGBA(255, 255, 255, 0.4);
        [self.Share_View addSubview:VCB];
        [self.Share_View addSubview:code];
        
        //手机验证码
        Mmeages = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-35.f*2)-ScreenWidth/3.1, ScreenHeight/10+40+20+40+20+40+20+40+20, 120, 20)];
        [Mmeages setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [Mmeages setTitle:@"已发送验证码" forState:UIControlStateDisabled];//与 "CodeTextSwitch"事件配合使用
        Mmeages.titleLabel.font = [UIFont systemFontOfSize:14];
        [Mmeages setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [Mmeages setTitleColor:[UIColor grayColor] forState:(UIControlStateDisabled)]; //与 "CodeTextSwitch"事件配合使用
        [Mmeages addTarget:self action:@selector(getButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.Share_View addSubview:Mmeages];
    
    
    
  
       
        UIButton * reg = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-35.f*2)-(ScreenWidth-130), 0, ScreenWidth, 40)];
        // reg.backgroundColor = [UIColor orangeColor];
         [reg setTitle:@"已有帐户？" forState:(UIControlStateNormal)];
         [reg setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
         reg.titleLabel.font = [UIFont systemFontOfSize:15];
         [reg setTag:1];// 0 注册介面切换 ， 1 登陆介面切换
         [reg addTarget:self action:@selector(User_UI_TouchDown:) forControlEvents:UIControlEventTouchUpInside];
         [self.Share_View addSubview:reg];
        
        UIButton * login = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20+40+120, ScreenWidth-120, 40)];
         login.backgroundColor = RGBA(255, 255, 255, 0.4);
         login.layer.cornerRadius = 20.0;//2.0是圆角的弧度，根据需求自己更改
         login.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);//设置边框颜色
         login.layer.borderWidth = 1.0f;//
         [login setTitle:@"注册" forState:(UIControlStateNormal)];
       //[login setTitleColor:RGBA(255, 255, 255, 0.4) forState:(UIControlStateNormal)];
         [login setTag:0];// 0 请求注册 ， 1 请求登陆
         [login addTarget:self action:@selector(User_TouchDown:) forControlEvents:UIControlEventTouchUpInside];
         [self.Share_View addSubview:login];
        
        
        UILabel *Terms = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20+40+120+40, ScreenWidth, 40)];
        Terms.textColor =[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.2];
        Terms.font =[UIFont systemFontOfSize:14];
        Terms.text =@"点击注册按钮，即表示您同意";
        [self.Share_View addSubview:Terms];
       
    
        UILabel *Privacy = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/14, ScreenHeight/10+40+20+40+20+40+20+40+120+40+20, ScreenWidth, 40)];
        Privacy.textColor =[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];
        Privacy.font =[UIFont systemFontOfSize:14];
        Privacy.text =@"服务条款 隐私政策与声明";
        [self.Share_View addSubview:Privacy];

   
}



-(void)User_UI_TouchDown:(UIButton *)sender{

    // 刷除tableV,释放内存
    [self.Share_View removeFromSuperview];
    [self.Share_View.layer removeFromSuperlayer];

    NSString *tagA =  [NSString stringWithFormat: @"%ld", (long)sender.tag];
       
    if ([tagA isEqualToString:@"0"]) {
       
          [self Reg_loadView];

         
    } else {
        
          [self Login_loadView];

        
         
    }

}


-(void)User_TouchDown:(UIButton *)sender{
    

    if ([username.text isEqualToString:@""] ) {
           
           HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
           HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
           HUD.label.text = @"用户名不能为空！";
          // HUD.minSize = CGSizeMake(100, 10);
           HUD.contentColor = [UIColor whiteColor];
           HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
           [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
        
           return;
    
       }

    //判断UserName少于6个字符
    if (Username_lengt < 6) {
                      
           HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
           HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
           HUD.label.text = @"用户名不能少于6";
           HUD.minSize = CGSizeMake(100, 10);
           HUD.contentColor = [UIColor whiteColor];
           HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
           [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
        
          return;
        
      }
           
        
       if ([password.text isEqualToString:@""]) {
           
           HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
           HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
           HUD.label.text = @"密码不能为空！";
           HUD.minSize = CGSizeMake(100, 10);
           HUD.contentColor = [UIColor whiteColor];
           HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
           [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
           
           return;
       }
      if (Password_lengt < 6) {
                    
          HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
          HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
          HUD.label.text = @"密码不能少于6";
          HUD.minSize = CGSizeMake(100, 10);
          HUD.contentColor = [UIColor whiteColor];
          HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
          [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
      
        return;
      
    }
       //判断是注册还是登陆，然后再调用验证码
       NSString *tagB =  [NSString stringWithFormat: @"%ld", (long)sender.tag];
       if ([tagB isEqualToString:@"0"]) {
          if ([code.text isEqualToString:@""]) {
           
           HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
           HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
           HUD.label.text = @"验证码不能为空！";
           HUD.minSize = CGSizeMake(100, 10);
           HUD.contentColor = [UIColor whiteColor];
           HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
           [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
           
           return;
          }
       }
        
           //判断是注册还是登陆，然后再调用GOOGLE验证码
           NSString *tagD =  [NSString stringWithFormat: @"%ld", (long)sender.tag];
           if ([tagD isEqualToString:@"1"]) {
              if ([QRcode.text isEqualToString:@""]) {
               
               HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
               HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
               HUD.label.text = @"GOOGLE验证码不能为空！";
               HUD.minSize = CGSizeMake(100, 10);
               HUD.contentColor = [UIColor whiteColor];
               HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
               [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
               
               return;
              }
               
          //判断UserName少于6个字符
          if (QRcode_lengt < 6) {
                            
                 HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
                 HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
                 HUD.label.text = @"GOOGL验证码6位";
                 HUD.minSize = CGSizeMake(100, 10);
                 HUD.contentColor = [UIColor whiteColor];
                 HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
                 [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
              
                return;
              
            }
              

    }
    
    
   
   
    //创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *UserApi=APIURL_USER;
    
    NSURL *url = [NSURL URLWithString:UserApi];
    
    //根据Button传过来的参数请求不同地址
    NSString *tagA =  [NSString stringWithFormat: @"%ld", (long)sender.tag];
    if ([tagA isEqualToString:@"1"]) {
         _Address=[NSString stringWithFormat:@"action=login&username=%@&password=%@&qrcode=%@",username.text,password.text,QRcode.text];
         
    } else {
         _Address=[NSString stringWithFormat:@"action=reg&username=%@&password=%@",username.text,password.text];
         
    }
   
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //设置request
    request.HTTPMethod = @"POST" ;
    
    NSData *data=[_Address dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@",_Address);
    request.HTTPBody = data;

    //创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       if (!error )
        {
            
          
            
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                              
           //登陆状态，返回failure或success
            //1001 登陆成功 ，1002 登陆失败 ， 1003 注册失败/已存在同名 ，1004 注册成功
            NSString *status = [dict objectForKey:@"status"];
            NSString *code =[dict objectForKey:@"code"];
            self->_statusED=status;//用户返回页面状态判断
            self->_codeED =code;//用户返回页面状态代码判断
          
       
            if ([status isEqualToString:@"failure"]) {
      
            NSLog(@"失败==%@",status);
            NSLog(@"失败代码==%@",code);
      
                          
                         
            } else {
                  
                   //获取数组userlist的内容
                            
                        NSMutableArray *userlist = [dict objectForKey:@"userlist"];
                            
                            for (int i = 0; i<[userlist count]; i++) {
                              //按数组中的索引取出对应的字典
                                NSDictionary * bbslistdic = [userlist objectAtIndex:i];
                                //通过字典中的key取出对应value，并且强制转化为NSString类型
                                self->_Json_name = [bbslistdic objectForKey:@"username"];
                             //   NSString *tel = [bbslistdic objectForKey:@"tel"];
                                self->_Json_pic = [bbslistdic objectForKey:@"pic"];
                             //   NSLog(@"%@",self->_Json_pic);
                                self->_Json_email = [bbslistdic objectForKey:@"email"];
                                self->_Json_tel = [bbslistdic objectForKey:@"tel"];
                                self->_Json_area = [bbslistdic objectForKey:@"area"];
                                self->_Json_birthday = [bbslistdic objectForKey:@"birthday"];
                                self->_Json_qrcode = [bbslistdic objectForKey:@"qrcode"];
                                self->_Json_qrurl = [bbslistdic objectForKey:@"qrurl"];
                                self->_Json_sex = [bbslistdic objectForKey:@"sex"];
                                self->_Json_Another = [bbslistdic objectForKey:@"Another"];
                                self->_Json_LimitA = [bbslistdic objectForKey:@"LimitA"];
                                self->_face_id = [bbslistdic objectForKey:@"face_id"];
                                
//                                self->_Json_alipay = [bbslistdic objectForKey:@"alipay"];
//                                self->_Json_weixin = [bbslistdic objectForKey:@"weixin"];
//                                self->_Json_car_name = [bbslistdic objectForKey:@"car_name"];
//                                self->_Json_car_num = [bbslistdic objectForKey:@"car_num"];
                                


                            } ;
                           //   NSLog(@"%@",userlist);
                      
                           //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////
                            
                    //方法一：JSON请求回来的用户信息存入沙盒,存储字典形式：
                
                       NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                       NSString *documents = [array lastObject];
                       NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
                        //准备要存入的字典
                      NSDictionary *dic_notice = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",self->_Json_name,@"username",@"简体中文",@"Language",@"欧元(ECO)",@"Currency",self->_Json_qrcode,@"qrcode",self->_Json_qrurl,@"QRurl",self->_Json_Another,@"Another",self->_Json_LimitA,@"LimitA",self->_Json_sex,@"Sex",self->_Json_pic,@"pic",self->_Json_tel,@"Mobi",self->_Json_email,@"Email",self->_Json_birthday,@"timeStr",self->_Json_area,@"AddressStr",self->_face_id,@"UISwitch_type",nil ];
                                                  //,self->_Json_Another,@"Another",self->_Json_LimitA,@"LimitA",self->_Json_alipay,@"alipay",self->_Json_weixin,@"weixin",self->_Json_car_name,@"car_name",self->_Json_car_num,@"car_num"
                        //将字典存入指定的本地文件
                      [dic_notice writeToFile:documnetPath atomically:YES];
                            
                     //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////
                     //方式二：JSON请求回来的用户信息存入沙盒
                //     NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                //            [user setObject:self->_Json_name forKey:@"username"];
                //      [user synchronize];
                            
                    //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// ////////////
                
                 NSLog(@"成功==%@",status);
                 NSLog(@"成功代码==%@",code);
                
                            
            }
 
        }
        else
            
        {
            NSLog(@"error is :%@",error.localizedDescription);
          
           
         
        }
        }];
     
    //开始任务

  
    [task resume];
 
 [NSThread sleepForTimeInterval:1];//延时
   //当没有网络时执行
    if (self->_codeED == nil) {

                HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
                //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
                HUD.label.text = @"未连接服务器！";
                HUD.minSize = CGSizeMake(100, 10);
                HUD.contentColor = [UIColor whiteColor];
                HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
                [MBProgressHUD hideHUDForView:self.Share_View animated:YES];

                 return;
        }
    
    [self Code_stuas];

    //[self CheckNet];//判断没有网络
    


}

-(void)Code_stuas
{
    
    //1001 登陆成功 ，1002 登陆失败 ， 1003 注册失败/已存在同名 ，1004 注册成功
      if ([self->_codeED isEqualToString:@"1001"]) {
          
               HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
               //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
               HUD.label.text = @"成功登陆！";
               //HUD.minSize = CGSizeMake(100, 10);
               HUD.contentColor = [UIColor whiteColor];
               HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
              
               //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
               dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
               dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                   // Do something...
                   [self pay];
                   [self DismissViewController]; //事件
               [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
                   
              
                });
      }
    if ([self->_codeED isEqualToString:@"1002"]) {
        
             HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
             //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
             HUD.label.text = @"户名/密码出错！";
             //HUD.minSize = CGSizeMake(100, 10);
             HUD.contentColor = [UIColor whiteColor];
             HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
            
             //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 // Do something...
                //  [self DismissViewController]; //事件
             [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
                 
            
              });
    }
    if ([self->_codeED isEqualToString:@"1003"]) {
        
             HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
             //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
             HUD.label.text = @"用户名已注册！";
             //HUD.minSize = CGSizeMake(100, 10);
             HUD.contentColor = [UIColor whiteColor];
             HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
            
             //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 // Do something...
                 //[self DismissViewController]; //事件
             [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
                 
            
              });
    }
    if ([self->_codeED isEqualToString:@"1004"]) {
        
             HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
             //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
             HUD.label.text = @"成功注册！";
             //HUD.minSize = CGSizeMake(100, 10);
             HUD.contentColor = [UIColor whiteColor];
             HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
            
             //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 // Do something...
                  [self DismissViewController]; //事件
             [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
                 
            
              });
    }
    
    if ([self->_codeED isEqualToString:@"2001"]) {
        
             HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
             //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
             HUD.label.text = @"GOOGLE验证码错误！";
             //HUD.minSize = CGSizeMake(100, 10);
             HUD.contentColor = [UIColor whiteColor];
             HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
            
             //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 // Do something...
                // [self DismissViewController]; //事件
             [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
                 
            
              });
    }
    
}
-(void)pay
{
    //---打开沙盒用户文件件
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    
    //---沙盒里用户信息
 
    NSString * username = [dic objectForKey:@"username"];//帐户名称
    //NSString * type = [dic objectForKey:@"type"];//登陆状态。1成功登陆，0为失败
    //NSLog(@"%@=%@",username,type);

           //创建session对象
           NSURLSession *session = [NSURLSession sharedSession];
           NSString *UserApi=APIURL_USER;
              
           NSURL *url = [NSURL URLWithString:UserApi];
           NSString * Urladd =[NSString stringWithFormat:@"action=pay_success&username=%@",username];
           
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
                   NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                   NSMutableArray * array = [dic objectForKey:@"Megss"];
                        //array不为空时
                        if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0) {
                            
                            //获取支付宝支付方式
                             NSArray * type_A  = [array valueForKey:@"alipay"];
                             NSString * alipay = [type_A valueForKey:@"alipay"];
                             NSString * A_car_name = [type_A valueForKey:@"car_name"];
                             NSString * A_car_num = [type_A valueForKey:@"car_num"];
                             //获取微信支付方式
                             NSArray * type_W  = [array valueForKey:@"weixin"];
                             NSString * weixin = [type_W valueForKey:@"weixin"];
                             NSString * W_car_name = [type_W valueForKey:@"car_name"];
                             NSString * W_car_num = [type_W valueForKey:@"car_num"];

                               //   NSLog(@"===%@",array);
                            //头像文件名外网路径保存在沙盒
                             NSArray *array_L = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                             NSString *documents = [array_L lastObject];
                             NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
                             NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
                             
                                  if (type_A) {
                                      [dic_notice setObject:alipay forKey:@"alipay"];
                                      [dic_notice setObject:A_car_name forKey:@"A_car_name"];
                                      [dic_notice setObject:A_car_num forKey:@"A_car_num"];
                                  }

                                  if (type_W) {
                                    
                                      [dic_notice setObject:weixin forKey:@"weixin"];
                                      [dic_notice setObject:W_car_name forKey:@"W_car_name"];
                                      [dic_notice setObject:W_car_num forKey:@"W_car_num"];

                                  }
                            //准备要添加存入的字典
                            [dic_notice writeToFile:documnetPath atomically:YES];
                     
                        }else{
                            //NSLog(@"空值");
                            
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

    

-(void)DismissViewController
{
   

  //[self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];

            
// 执行效果同上
       [self dismissViewControllerAnimated:YES completion:^{
            //发送刷新通知，并传JSON返回成功失败状态
           // [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTransferIndex" object:self userInfo:@{@"code":self->_codeED}];
            //通知需要登陆才可以看到的页面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTransferIndex" object:self userInfo:nil];
           
          }];

}

//，限制username最长为11个字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if (textField == username) {
    if (textField.text.length > 10 && string.length > 0) return NO;
        
        //获取username输入的长度，
        NSString * useranme_lengt = [username.text stringByReplacingCharactersInRange:range withString:string];
        Username_lengt = [[NSString stringWithFormat:@"%lu",(unsigned long)useranme_lengt.length] intValue];
        
    }
    
    if  (textField == password) {
    if (textField.text.length > 10 && string.length > 0) return NO;
        //获取password输入的长度，
        NSString * password_lengt = [password.text stringByReplacingCharactersInRange:range withString:string];
        Password_lengt = [[NSString stringWithFormat:@"%lu",(unsigned long)password_lengt.length] intValue];
        
    }
    
    if  (textField == QRcode) {
    if (textField.text.length > 10 && string.length > 0) return NO;
        //获取google验证输入的长度，
        NSString * qrcode_lengt = [QRcode.text stringByReplacingCharactersInRange:range withString:string];
        QRcode_lengt = [[NSString stringWithFormat:@"%lu",(unsigned long)qrcode_lengt.length] intValue];
        
    }

        
    //监听username输入事件
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



-(void)Close
{
    UIButton * close = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (ScreenWidth/10), 40)];
    // close.backgroundColor = [UIColor orangeColor];
    // [close setTitle:@"关闭" forState:(UIControlStateNormal)];
    [close setImage:[UIImage imageNamed:@"cross-out"] forState:(UIControlStateNormal)];
    [close addTarget:self action:@selector(Close_TouchDown) forControlEvents:UIControlEventTouchUpInside];
    
    [self.Share_View addSubview:close];
}

//关闭调用
-(void)Close_TouchDown
{
   [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];

}


//公用Uivew高宽
-(void)Uivew_Share
{
    
         // 左右留35
          // 上下留100
         CGFloat w = ScreenWidth - 35.f * 2;
         CGFloat h = ScreenHeight - 100.f * 2;
             
          _Share_View =[[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
        // self.Share_View.backgroundColor  = [UIColor redColor];
         
         
       //_Share_View背景渐变
         CAGradientLayer *gradientLayer = [CAGradientLayer layer];
         gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:52.0/255 green:110.0/255 blue:158.0/255 alpha:0.95].CGColor, (__bridge id)[UIColor colorWithRed:36.0/255 green:103.0/255 blue:162.0/255 alpha:1].CGColor, ];//这里颜色渐变
         gradientLayer.locations = @[@0.1, @0.7];//颜色位置 0086EB
         // startPoint&endPoint 颜色渐变的方向
         gradientLayer.startPoint = CGPointMake(0, 0);
       //  gradientLayer.endPoint = CGPointMake(1.0, 0);//(1.0,0)代表水平方向渐变
         gradientLayer.endPoint = CGPointMake(0,1.0);//(0,1.0)代表竖直方向渐变
         gradientLayer.frame = CGRectMake(0, 0, w, h);//渐变区域的大小，一般同view
         gradientLayer.cornerRadius = 15;//背景圆角
         [self.Share_View.layer addSublayer:gradientLayer];
         [self.view addSubview:_Share_View];
    
        //以下两种方法为UITextField 光标颜色
        //username.tintColor = [UIColor redColor];//指定UITextField
         [[UITextField appearance] setTintColor:[UIColor whiteColor]];//全局
    
}

   //点击空白处隐藏键盘
-(void)KeyBoardHide_Yc
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
      [username resignFirstResponder];
      [password resignFirstResponder];
      [code resignFirstResponder];
      [QRcode resignFirstResponder];
 
}
//密码文暗显示
- (IBAction)pwdTextSwitch:(UIButton *)sender {
     
    
    // 前提:在xib中设置按钮的默认与选中状态的背景图
    // 切换按钮的状态
    sender.selected = !sender.selected;
    
    if (sender.selected) { // 按下去了就是明文
        
        NSString *tempPwdStr = password.text;
        password.text = @""; // 这句代码可以防止切换的时候光标偏移
        password.secureTextEntry = NO;
        password.text = tempPwdStr;

        
        
    } else { // 暗文
        
        NSString *tempPwdStr = password.text;
        password.text = @"";
        password.secureTextEntry = YES;
        password.text = tempPwdStr;

        
    }
}
//手机验证码发送
- (IBAction)CodeTextSwitch:(UIButton *)sender {
  
    
     
    if ([username.text isEqualToString:@""]) {
        HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
        HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
        HUD.label.text = @"手机号码不能为空";
        HUD.minSize = CGSizeMake(100, 10);
        HUD.contentColor = [UIColor whiteColor];
        HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
        [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
           //NSLog(@"1111");
        
        
           return;
      
        
    } else {
          //事件
          //NSLog(@"2222");
        
    }
    // Mmeages.selected = !Mmeages.isSelected;// 配合Mmeages按钮状态使用  [Mmeages setTitle:@"已发送验证码" forState:UIControlStateSelected];
       Mmeages.enabled = !Mmeages.isEnabled;  //  配合Mmeages按钮状态使用  [Mmeages setTitle:@"已发送验证码" forState:UIControlStateDisabled];
    

}
- (void)dealloc
{
   // NSLog(@"%@ --> dealloc",[self class]);
}
#pragma mark - 获取验证码
- (IBAction)getButtonClick:(UIButton *)sender
{
    if ([username.text isEqualToString:@""]) {
        HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
        HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
        HUD.label.text = @"手机号码不能为空";
        HUD.minSize = CGSizeMake(100, 10);
        HUD.contentColor = [UIColor whiteColor];
        HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
        [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
         
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
    UIColor *titlecolorED = [UIColor whiteColor];
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
    manager.requestSerializer.timeoutInterval = 1;//请求时间
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=1&type=1"];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
   
      [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
           
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             // NSLog(@"请求成功%@", responseObject);
             [self Code_stuas];//有网络执行弹窗
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //  NSLog(@"请求失败");
          
               self->HUD = [MBProgressHUD showHUDAddedTo:self.Share_View animated:YES];
               //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
               self->HUD.label.text = @"网络未连接服务器";
               self->HUD.minSize = CGSizeMake(100, 10);
               self->HUD.contentColor = [UIColor whiteColor];
               self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
               self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
               [MBProgressHUD hideHUDForView:self.Share_View animated:YES];
                
               return;
 

        }];
}
@end
