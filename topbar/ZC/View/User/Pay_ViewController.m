//
//  Pay_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Pay_ViewController.h"
#import "Add_Pay_ViewController.h"

@interface Pay_ViewController ()

@end

@implementation Pay_ViewController


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
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
     
    _tableView.delegate=self;
    _tableView.dataSource=self;
      //----隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //---滚动条修改颜色
    //self.tableV.indicatorStyle=UIScrollViewIndicatorStyleBlack;
    [self.view addSubview:_tableView];
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
     [title setText:@"收付方式"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];
    
     //-------右添加
     UIButton *Add = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50,(89-20)/2+10,40,40)];
     [Add setImage:[UIImage imageNamed:@"Add"] forState:UIControlStateNormal];
     [Add addTarget:self action:@selector(Authentication) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:Add];

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{
    
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
        NSString * Urladd =[NSString stringWithFormat:@"action=pay_list&username=%@",username];
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
                 
                 
                 //if (dic == (NULL))
                 if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
                               //主线程
                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                         self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
                         self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
                         self->HUD.label.text = @"数据加载成功";
                         //self->HUD.minSize = CGSizeMake(100, 10);
                         self->HUD.offset = CGPointMake(0, -300);
                         self->HUD.contentColor = [UIColor whiteColor];
                         self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
                         self->HUD.minShowTime= 0.5;/*指示器停留的时间/以秒为做单位*/
                         [MBProgressHUD hideHUDForView:self.tableView animated:YES];

                         return;


                     });
                 } else {
                               //主线程
                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                         self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
                         self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
                         self->HUD.label.text = @"你还没有添加收付款方式";
                         //self->HUD.minSize = CGSizeMake(100, 10);
                         self->HUD.offset = CGPointMake(0, -300);
                         self->HUD.contentColor = [UIColor whiteColor];
                         self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
                         self->HUD.minShowTime= 0.5;/*指示器停留的时间/以秒为做单位*/
                         [MBProgressHUD hideHUDForView:self.tableView animated:YES];

                         return;


                     });
                 }
                 
                 
                 
                 
                 
               //将数组中的字典数据都转换成模型
               self.dataArr=[Pay_NS mj_objectArrayWithKeyValuesArray:array];
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
    
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          

                         self->currentPage = 1;//初始化
                         
                         
                         [self jsonParse];//如果不添加重新请求（网址）JSON，数据不会随时下拉刷新
                         

                                  //结束上拉刷新
                         [self.tableView.mj_header endRefreshing];
                         
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
//显示每一行的数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     [tableView tableViewDisplayWitMsg:@"网络不给力哟 ^-^" ifNecessaryForRowCount:self.dataArr.count];
    self.tableView.mj_footer.hidden = (self.dataArr.count == 0);
    return self.dataArr.count;
    
    
    
}
//显示每一行的数据

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{
 

    static NSString *CellIdentifier = @"CustomCell";
    Pay_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    cell = [[Pay_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色
    
    
    
    // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
    Pay_NS *item=self.dataArr[indexPath.row];
    //cell.username.text = @"行远币行";
    //cell.vol.text = item.vol;
    
    
    NSString * vols = item.car_name;
    cell.vol.text = vols;
    
    
    NSString * tatols = item.car_num;
    cell.tatol.text = tatols ;
 
    cell.vol_A.text = @"已激活";


    if ([item.type isEqualToString:@"微信"]) {
         cell.logo.image = [UIImage imageNamed:@"weixin"];
         _qrcode_url = item.weixin;
         //NSLog(@"weixin=%@",_qrcode_url);
     }else{
         cell.logo.image = [UIImage imageNamed:@"alipay"];
         _qrcode_url =item.alipay;
         //NSLog(@"alipay=%@",_qrcode_url);
     }
    cell.username.text = item.type;
    
    
    
    //cell.qr_code.image = [UIImage imageNamed:@"qr-acode"];
    //给二维添加手势,按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(ScreenWidth-(ScreenWidth/9), 75, 20, 20);
    UIImage *image = [UIImage imageNamed:@"qr-acode"];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(imagesfull:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(btn, "qrcode", _qrcode_url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON传值使用
    [cell addSubview:btn];
    
    

    
    //[cell.FirstPics sd_setImageWithURL:[NSURL URLWithString:item.FirstPics]placeholderImage:[UIImage imageNamed:@"nopic.png"]];

    
    //UITableView去掉自带系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //自定义分割线
    //    UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 10)];
    //    VC.backgroundColor = RGBA(245,245,245,1);
    //    [cell.contentView addSubview:VC];
    UIView * VC1 = [[UIView alloc]initWithFrame:CGRectMake(0, 113, self.view.frame.size.width, 1)];
    VC1.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [cell.contentView addSubview:VC1];
    
    
    
    return cell;
    
    
    
    
}
//顶部距离
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 1.f;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {


    //------TableView顶间距
   tableView.sectionHeaderHeight = 10;
   return [[UIView alloc]init];
   
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath//行间距离（108）
{

    return 114;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
        Pay_NS *item=self.dataArr[indexPath.row];
        Add_Pay_ViewController * vc  =[[Add_Pay_ViewController alloc]init];
        vc.pay_name_type = item.type;
        vc.id = item.id;
        //NSLog(@"%@",item.id);
        [self.navigationController pushViewController:vc animated:YES];
  


}
- (void)left
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
   
}

-(void)Authentication
{
       // NSLog(@"btn_type===%@",_Btn_type);
        //
  
        PopView  = [[Pop_rz alloc]init];
        PopView.type = @"3"; //传值，到底是认证时间还是认证等级，因为调用同一个窗口。 0 认证等级（默认）  、1 认证时间
        //三选其一显示
        [PopView showInView];//遮挡新建的view
        //[PopView coutomshowInView:self.view];
        //[PopView coutomshowInView:[UIApplication sharedApplication].keyWindow];
        
         __block Pay_ViewController *blockSelf = self;//创建一个本地变量blockSelf，指向self，然后用结构体语法访问实例变量
         PopView.block = ^(NSString * text)
        {
           
        // NSString *email  =[[NSString alloc]init];
        // email = text;
            
        self->pay_name = text;
        //NSLog(@"a===%@",text);
        //主线程
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // Do something...
              
        [blockSelf DismissViewController];
                
        });
            
        };
    

    
}
- (void)DismissViewController
{
  
     HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
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
         [self Addpay];

         
     [MBProgressHUD hideHUDForView:self.tableView animated:YES];
         
    
      });
    
}
-(void)Addpay
{
    Add_Pay_ViewController * vc  =[[Add_Pay_ViewController alloc]init];
    vc.pay_name_type = pay_name;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    // NSLog(@"2");
    //AudioServicesPlaySystemSound(SOUNDID);//文件类型
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动类型


}
-(void)imagesfull:(UIButton *)sender{
   
    //初始化要显示的图片内容的imageView（这里位置是使用当前屏幕的 宽和高宏定义）
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //图片背景色设置成黑色(必须)
    imageView.backgroundColor = [UIColor blackColor];
    //要显示的图片，即要放大的图片(放大图片的填充方式)
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    //imageView.image = [UIImage imageNamed:@"weixin"];

    id KYC = objc_getAssociatedObject(sender, "qrcode"); //取参
    //NSLog(@"kyc==%@",KYC);

    NSString *api_url = [NSString stringWithFormat:@"%@",KYC];
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


//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//
//    //  NSLog(@"1");
//
//    // 刷除tableV,释放内存
//    [self.tableView removeFromSuperview];
//    [self.tableView.layer removeFromSuperlayer];
//    //  _tableV=nil;
//    [self Sharea];
//    [self begin];
//
//}

//- (void)viewDidAppear:(BOOL)animated{
//     [super viewDidAppear:animated];
//    //接收通知，然后执行刷新
//     NSLog(@"333");
//     //[self HeadCon];//刷新需要登陆才能看的功能
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateIndex:) name:@"updateTransferIndex" object:nil];
//     // NSLog(@"已收到通知，并准备执行");
//
//}
//
//
//- (void)UpdateIndex:(NSNotification *)notification
//{
////     //接收login传过来的成功失败状态代码
////      _code =[notification.userInfo objectForKey:@"code"];
////     [self beginA];
//     //NSLog(@"已执行ZC刷新");
//     // 刷除tableV,释放内存
////     [self.tableV removeFromSuperview];
////     [self.tableV.layer removeFromSuperlayer];
////
////     _tableV=nil;
////     [self Share];
//       [self begin];//刷新
//    NSLog(@"444");
//
//
//}
@end
