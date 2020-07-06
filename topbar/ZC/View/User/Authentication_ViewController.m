//
//  Authentication_ViewController.m
//  topbar
//
//  Created by topbar on 2019/11/4.
//  Copyright © 2019 guo feng zou. All rights reserved.
//身份认证

#import "Authentication_ViewController.h"

@interface Authentication_ViewController ()

@end

@implementation Authentication_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor whiteColor];
    //----右滑手势解决
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    //设置导航控制器的代理(隐藏顶部-nav)
    self.navigationController.delegate = self;
    [self Nav_UI];
    [self Share_UI];
    [self KeyBoardHide_Yc];
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
     [title setText:@"身份认证"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];

}

-(void)Share_UI
{
    //以下两种方法为UITextField 光标颜色
    //username.tintColor = [UIColor redColor];//指定UITextField
     [[UITextField appearance] setTintColor:[UIColor orangeColor]];//全局
    
    UIView *VC =  [[UIView alloc]initWithFrame:CGRectMake(10, 89, ScreenWidth, ScreenHeight)];
    [self.view addSubview:VC];
   // VC.backgroundColor  = [UIColor redColor];
    UILabel * lablelA= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20, ScreenWidth/2, 40)];
    lablelA.text =@"国家地区";
    lablelA.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    lablelA.font = [UIFont systemFontOfSize:12];
    [VC addSubview:lablelA];
    //-------
    UILabel * lablelB= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40, ScreenWidth/2, 40)];
    lablelB.text =@"美利坚共和国";
    lablelB.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    lablelB.font = [UIFont systemFontOfSize:20];
    [VC addSubview:lablelB];
    
    //-------
    UILabel * lablelC= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40, ScreenWidth/2, 40)];
    lablelC.text =@"名";
    lablelC.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    lablelC.font = [UIFont systemFontOfSize:12];
    [VC addSubview:lablelC];
    
    //----
    username = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40, ScreenWidth/2, 40)];
    username.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    //username.delegate = self;//限制输入字符,配合方法才能使用
    //占位符颜色
    NSMutableDictionary *attDic = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
    NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:@"请输入您的名字" attributes:attDic];
    username.attributedPlaceholder = attPlace;
    [VC addSubview:username];
    UIView * VCA = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40 ,ScreenWidth-50, 1)];
    VCA.backgroundColor = RGBA(239, 239, 244, 1);
    [VC addSubview:VCA];
    //-------
     UILabel * lableldD= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20, ScreenWidth/2, 40)];
    lableldD.text =@"姓";
    lableldD.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    lableldD.font = [UIFont systemFontOfSize:12];
    [VC addSubview:lableldD];
     
     //----
    Lastname = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40, ScreenWidth/2, 40)];
    Lastname.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    //Lastname.delegate = self;//限制输入字符,配合方法才能使用
     //占位符颜色
    NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
    NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请输入您的姓氏" attributes:attDicA];
    Lastname.attributedPlaceholder = attPlaceA;
    [VC addSubview:Lastname];
    UIView * VCB = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40 ,ScreenWidth-50, 1)];
    VCB.backgroundColor = RGBA(239, 239, 244, 1);
    [VC addSubview:VCB];
    
    //------
    UILabel * lableldE= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20, ScreenWidth/2, 40)];
    lableldE.text =@"证件号码";
    lableldE.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    lableldE.font = [UIFont systemFontOfSize:12];
    [VC addSubview:lableldE];
    
    //----
    code = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20+40, ScreenWidth/2, 40)];
    code.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    //CODE.delegate = self;//限制输入字符,配合方法才能使用
    //占位符颜色
    NSMutableDictionary *attDicB = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
    NSMutableAttributedString *attPlaceB = [[NSMutableAttributedString alloc] initWithString:@"请输入您的证件号码" attributes:attDicB];
    code.attributedPlaceholder = attPlaceB;
    [VC addSubview:code];
    UIView * VCC = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20+40+40 ,ScreenWidth-50, 1)];
    VCC.backgroundColor = RGBA(239, 239, 244, 1);
    [VC addSubview:VCC];
    //---
    UILabel * lableldF= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20+40+40, ScreenWidth/2, 40)];
    lableldF.text =@"身份证、护照 、驾照或其他合法证件号码";
    lableldF.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2];
    lableldF.font = [UIFont systemFontOfSize:12];
    [VC addSubview:lableldF];
    
    
    UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20+40+40+150, ScreenWidth-50, 40)];
    [Qbutton setTitle:@"提交" forState:UIControlStateNormal];
    [Qbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Qbutton.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
    [Qbutton addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
    [VC addSubview:Qbutton];
    
    

    
    
}
////// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

}
- (void)left
{
    [self.navigationController popViewControllerAnimated:YES];
   
}
-(void)Action
{
    
    if ([username.text isEqualToString:@""] ) {
                   
          HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
          HUD.label.text = @"名不能为空！";
          // HUD.minSize = CGSizeMake(100, 10);
          HUD.contentColor = [UIColor whiteColor];
          HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
          HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
          [MBProgressHUD hideHUDForView:self.view animated:YES];
                
          return;
           
       }
       
       if ([Lastname.text isEqualToString:@""] ) {
                   
          HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
          HUD.label.text = @"姓不能为空！";
          // HUD.minSize = CGSizeMake(100, 10);
          HUD.contentColor = [UIColor whiteColor];
          HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
          HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
          [MBProgressHUD hideHUDForView:self.view animated:YES];
                
          return;
           
       }
    if ([code.text isEqualToString:@""] ) {
                
       HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
       HUD.label.text = @"证件号码不能为空！";
       // HUD.minSize = CGSizeMake(100, 10);
       HUD.contentColor = [UIColor whiteColor];
       HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
       HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
       [MBProgressHUD hideHUDForView:self.view animated:YES];
             
       return;
        
    }
    

   [self CheckNet];
    
}
-(void)CheckNet
{
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 1.f;//请求时间
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=1&type=1"];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
   
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
           
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          // NSLog(@"请求成功%@", responseObject);
          self->HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          self->HUD.label.text = @"提交成功";
          self->HUD.contentColor = [UIColor whiteColor];
          self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
          
             
             
          dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
          dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
              
          [self left];//返回事件
          [MBProgressHUD hideHUDForView:self.view animated:YES];
                   
               });
                      
          return;

             
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //  NSLog(@"请求失败");
           self->HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
           //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
           self->HUD.label.text = @"未连接服务器";
           self->HUD.minSize = CGSizeMake(100, 10);
           self->HUD.contentColor = [UIColor whiteColor];
           self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
           self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
           [MBProgressHUD hideHUDForView:self.view animated:YES];
            
           return;
        }];
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
   //点击空白处隐藏键盘
-(void)KeyBoardHide_Yc
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [username resignFirstResponder];
    [Lastname resignFirstResponder];
    [code resignFirstResponder];
 
}
@end
