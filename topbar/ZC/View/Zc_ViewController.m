//
//  Zc_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2019/9/17.
//  Copyright © 2019 guo feng zou. All rights reserved.
//
//资产

#import "Zc_ViewController.h"


#import "Other_web_ViewController.h"
#import "Account_ViewController.h"
#import "Authentication_ViewController.h"
#import "Language_ViewController.h"
#import "OrderType_ViewController.h"
#import "Wallet_ViewController.h"


@interface Zc_ViewController ()

@end

@implementation Zc_ViewController

- (void)viewDidLoad {
      [super viewDidLoad];
     // self.view.backgroundColor = [UIColor whiteColor];


       //监听是否触发home键挂起程序. 当APP离开后会刷新“资产”页面使其不会遮挡顶部导航
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissView)
       name:UIApplicationWillResignActiveNotification object:nil];
    
//    UIApplicationDidEnterBackgroundNotification  //进入后台
//    UIApplicationWillEnterForegroundNotification //回到程序
//    UIApplicationDidBecomeActiveNotification //监听是否重新进入程序程序.

      [self Share];
    
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
           return 2;
       }
    if (section == 1 )
    {
        return 3;
    }
    if (section ==2)
    {
        return 5;
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
    tableView.backgroundColor = [UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1];
    cell.textLabel.font = [UIFont italicSystemFontOfSize:16];//设置文本字体与大小
    cell.textLabel.textColor =   [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    cell.backgroundColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//详细箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色



    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
     if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"新手必读"];
            cell.imageView.image = [UIImage imageNamed:@"Exchange"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;

            
        }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"合约交易"];
            cell.imageView.image = [UIImage imageNamed:@"Rate"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            
        }
          }
        
      else if (indexPath.section == 1)
         {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"问题反馈"];
            cell.imageView.image = [UIImage imageNamed:@"kf"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"帮助中心"];
            cell.imageView.image = [UIImage imageNamed:@"help"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"版本号"];
            cell.imageView.image = [UIImage imageNamed:@"reload"];
            UILabel * text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
            text.text = @"V1.8.8";
            text.font = [UIFont italicSystemFontOfSize:14];
            text.textAlignment  = NSTextAlignmentCenter;
            text.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            cell.accessoryView =text;
            
            
        }
        }
  

    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0  )
        {
            //---取沙盒用户信息
//            NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            NSString *documentsPath = [documentsPathArr lastObject];
//            NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
//            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
//            _Language = [dic objectForKey:@"Language"];

            cell.textLabel.text =  [NSString stringWithFormat:@"默认语言"];
            cell.imageView.image = [UIImage imageNamed:@"language"];
            if ([_type isEqualToString:@"1"]) {
                cell.detailTextLabel.text = _Language;
            } else {
                cell.detailTextLabel.text = @"简体中文";
            }
            
            cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            
        }
        if (indexPath.row == 1)
               {
              cell.textLabel.text = [NSString stringWithFormat:@"币币交易"];
              cell.imageView.image = [UIImage imageNamed:@"feedback"];
              UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
              cell.accessoryView = imageView;
                   
                   
               }
       
         if (indexPath.row == 2)
               {
               cell.textLabel.text = [NSString stringWithFormat:@"关于我们"];
               cell.imageView.image = [UIImage imageNamed:@"about"];
               UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
               cell.accessoryView = imageView;
                   
               }
        if (indexPath.row == 3)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"标记价格"];
            cell.imageView.image = [UIImage imageNamed:@"invite"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 4)
               {
             cell.textLabel.text = [NSString stringWithFormat:@"设置"];
             cell.imageView.image = [UIImage imageNamed:@"settings"];
             UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
             cell.accessoryView = imageView;
                   
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
     _tableV.sectionHeaderHeight = 3.f;
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

               // NSLog(@"点击了汇率概览！");
               
                 Other_web_ViewController *vc =[[Other_web_ViewController alloc]init];
                 vc.news_Title = @"新手必读";
                 vc.news_url = @"https://www.okex.me/support/hc/zh-cn/sections/360000033031-新手必读";
                 [self.navigationController pushViewController:vc animated:YES];
                
            }
            
            if (indexPath.row == 1)
            {

               // NSLog(@"点击了费率详情！");
                
                Other_web_ViewController *vc =[[Other_web_ViewController alloc]init];
                vc.news_Title = @"合约交易";
                vc.news_url = @"https://www.okex.me/support/hc/zh-cn/articles/360038488571-6-合约交易入门";
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
            
            break;
        }
            
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
        case 1:
        {
            
            if (indexPath.row == 0)
            {
          
                
               // NSLog(@"点击了在线客服务！");
                Other_web_ViewController *vc =[[Other_web_ViewController alloc]init];
                vc.news_Title = @"问题反馈";
                vc.news_url = @"https://www.okex.me/account/login";
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }
            if (indexPath.row == 1)
            {
    
               // NSLog(@"点击了帮助中心！");
                Other_web_ViewController *vc =[[Other_web_ViewController alloc]init];
                vc.news_Title = @"帮助中心";
                vc.news_url = @"https://www.okex.me/support-center.html";
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
            if (indexPath.row == 2)
            {
                
               // NSLog(@"点击了版本号！");
       
                
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
                
                
                //NSLog(@"点击了问题反馈！");
                Other_web_ViewController * vc =[[Other_web_ViewController alloc]init];
                vc.news_Title =@"法币交易";
                vc.news_url =@"https://www.okex.me/support/hc/zh-cn/articles/360033846191-关于OKEx法币交易区上线-一键买-卖币-功能的公告";
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            if (indexPath.row == 2)
            {
                
                
               // NSLog(@"点击了关于我们！");
                Abouts_ViewController *vc = [[Abouts_ViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            if (indexPath.row == 3)
            {
                
                
               // NSLog(@"点击了邀请好友！");
                Other_web_ViewController * vc =[[Other_web_ViewController alloc]init];
                vc.news_Title = @"标记价格";
                vc.news_url  = @"https://www.okex.me/support/hc/zh-cn/articles/360037140112-三-标记价格";
                [self.navigationController pushViewController:vc animated:YES];
                
            }
          
            if (indexPath.row == 4)
            {
           //  NSLog(@"点击了设置！");
                if ([_type isEqualToString:@"1"]) {
                    Setting_ViewController * vc =[[Setting_ViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                } else {

                    [self performSelector:@selector(Login:) withObject:self ];


                }

             
                           
            }
           break;
            
        }

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            


        
    }
}

-(void)Share
{
    
//      //右滑手势解决
//      //   self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//      self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//      //给导航条设置一个空的背景图 使其透明化
//      [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//
//       //去除导航条透明后导航条下的黑线
//      [self.navigationController.navigationBar setShadowImage:[UIImage new]];

      
      //设置窗口大小
      _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
      // tableV.backgroundColor=[UIColor clearColor];
      _tableV.delegate=self;
      _tableV.dataSource=self;
      //隐藏滚动条
      self.tableV.showsVerticalScrollIndicator = NO;
      //滚动条修改颜色
      //self.tableV.indicatorStyle=UIScrollViewIndicatorStyleBlack;
      [self.view addSubview:_tableV];
    
      [self.headImage addSubview:self.mengView];
      [self.headerBackView addSubview:self.headImage];
      self.tableV.tableHeaderView = self.headerBackView;
     
      [self Head_btn];
         
      [self navCleanFromAlpha:0];
      [self User_UI];
      [self begin];

      
}

-(void)User_UI
{
    
    
         //取沙盒用户信息
         // NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
         // NSString *na=[user objectForKey:@"username"];
         // _username=na;
    
        //取沙盒用户信息
        NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [documentsPathArr lastObject];
        NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
        _username = [dic objectForKey:@"username"];
        _type = [dic objectForKey:@"type"];
        _pic = [dic objectForKey:@"pic"];
        _Language = [dic objectForKey:@"Language"];
    
        NSString *api_url = [NSString stringWithFormat:@"%@",_pic];
        NSString *urlString =[APIURL stringByAppendingString:api_url];

        //用户头像
        UIImageView *headimageView = [[UIImageView alloc] init];
        headimageView.frame = CGRectMake(ScreenWidth/2-30, 0, 60, 60);
        // NSLog(@"TYPE==%@",_type);
    
    
        if ([_type isEqualToString:@"1"]) {
           //生成图片链接
         NSString *string = urlString;
         NSURL *picURL = [NSURL URLWithString:string];
         //从网络获取照片,如果没有就用系统自带占位照片
        
         [headimageView sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"user@2x.png"] ];
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setting:)];
         [headimageView addGestureRecognizer:tap];
         [self Quit_btn];
        
            
         } else
         {
        headimageView.image = [UIImage imageNamed:@"user@2x.png"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Login:)];
        [headimageView addGestureRecognizer:tap];
        
          }
         
         headimageView.layer.cornerRadius=30;
         headimageView.layer.masksToBounds=YES;
         headimageView.userInteractionEnabled = YES;//默认为NO，需要改为YES，否则会触发不了手势

    
      
  
        [_headerBackView addSubview:headimageView];

     //用户名
         UILabel *namelabel = [[UILabel alloc] init];
         namelabel.frame = CGRectMake(0, 55, ScreenWidth, 30);
         namelabel.backgroundColor = [UIColor clearColor];
         namelabel.textColor =[UIColor whiteColor];
    

    

    
        if ([_type isEqualToString:@"1"]) {
           //namelabel.text = _username;
            
           //创建富文本
           NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: _username];
           //NSTextAttachment可以将要插入的图片作为特殊字符处理
           NSTextAttachment *attch = [[NSTextAttachment alloc] init];
           //定义图片内容及位置和大小
           attch.image = [UIImage imageNamed:@"V"];
           attch.bounds = CGRectMake(0, -4, 25, 25);
           //创建带有图片的富文本
           NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
           //将图片放在最后一位
           //[attri appendAttributedString:string];
           //将图片放在第一位
           [attri insertAttributedString:string atIndex:0];
           //用label的attributedText属性来使用富文本
           namelabel.attributedText = attri;
            
            
          } else {
          namelabel.text = @"登录/注册";
          }

          namelabel.textAlignment = NSTextAlignmentCenter;
          namelabel.font =[UIFont fontWithName:@"Verdana" size:16];
          namelabel.numberOfLines = 0;
          [_headerBackView addSubview:namelabel];
    

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
  //  [header beginRefreshing];
    // 设置header
    self.tableV.mj_header = header;
    

}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
     //结束上拉刷新
    [self.tableV.mj_header endRefreshing];
    
    // 刷除tableV,释放内存
    [self.tableV removeFromSuperview];
    [self.tableV.layer removeFromSuperlayer];
      _tableV=nil;
  
     //重新加载
    [self Share];

  //刷新UITableView
//  [self.tableV reloadData];
//   dispatch_async(dispatch_get_main_queue(), ^{
//       //刷新完成，执行后续代码
//   });

}



- (void)setting:(id)sender
{
    if ([_type isEqualToString:@"1"]) {
        
        Setting_ViewController *vc = [[Setting_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        //NSLog(@"点击了设置");

    } else {

        [self performSelector:@selector(Login:) withObject:self ];

    }

}
-(void)Action
{
               HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
               //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
               HUD.label.text = @"未与服务器联系！";
               //HUD.minSize = CGSizeMake(100, 10);
               HUD.contentColor = [UIColor whiteColor];
               HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
              
               //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
               dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
               dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                   // Do something...
                    //事件
               [MBProgressHUD hideHUDForView:self.view animated:YES];
                   
              
                });
    
}
-(void)navCleanFromAlpha:(CGFloat)alpha
{
  [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:ZhuTiColorAlpha(alpha)] forBarMetrics:UIBarMetricsDefault];
  self.navigationController.navigationBar.shadowImage = [UIImage new];
}
 
-(UIImage*) createImageWithColor:(UIColor*) color
{
  CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return theImage;
}

-(UIImageView *)headImage
{
  if(!_headImage)
  {
    _headImage= [[UIImageView alloc]initWithFrame: self.headerBackView.bounds];
    _headImage.image = [UIImage imageNamed:@"zc_bannar"];
  }
  return _headImage;
}
 

 
-(UIView *)headerBackView
{
    
  if (!_headerBackView)
  {
    _headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, imageHight)];
    [_headerBackView setBackgroundColor:[UIColor lightGrayColor]];
  }


  return _headerBackView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    //---------------------- 图片拉升 -------------------------
      //图片高度
      CGFloat imageHeight = self.headerBackView.frame.size.height;
      //图片宽度
      CGFloat imageWidth = ScreenWidth;
      //图片上下偏移量
      CGFloat imageOffsetY = scrollView.contentOffset.y;

    //  NSLog(@"图片上下偏移量 imageOffsetY:%f ->",imageOffsetY);

      //上移
      if (imageOffsetY < 0)
      {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;

        self.headImage.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
        self.mengView.frame = self.headImage.bounds;
      }

    CGFloat reOffset = scrollView.contentOffset.y + (ScreenHeight - 64) * 0.2;
    CGFloat alpha = reOffset / ((ScreenHeight - 64) * 0.1);//透明度渐变长度
    if (alpha <= 1)//下拉永不显示导航栏
    {
        alpha = 0;
        UIImage *rightImage = [[UIImage imageNamed:@"setting_icon_k"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
               UIBarButtonItem * rightButton_top  = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStyleDone target:self action:@selector(setting:)];
               self.navigationItem.rightBarButtonItem = rightButton_top;

         self.navigationItem.title = @"";
        



    }
    else//上划前一个导航栏的长度是渐变的
    {
        alpha -= 1;
        UIImage *rightImage = [[UIImage imageNamed:@"setting_ico_k"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem * rightButton_top  = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStyleDone target:self action:@selector(setting:)];
        self.navigationItem.rightBarButtonItem = rightButton_top;
        self.navigationItem.title = @"资产中心";
        
        
        //---
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1]}];
     

    }
    // 设置导航条的背景图片 其透明度随  alpha 值 而改变
    UIImage *image = [self imageWithColor:[UIColor colorWithRed:250.0/255 green:250.1/255 blue:250.0/255 alpha:alpha]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

}

/// 使用颜色填充图片
- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
   
    return theImage;
    
}
-(void)Login:(UITapGestureRecognizer*)sender{
    //具体事件
   
    Login_ViewController *toVC = [Login_ViewController alloc];
    
    Login_PresentationController *presentationC = [[Login_PresentationController alloc] initWithPresentedViewController:toVC presentingViewController:self];
    
    toVC.transitioningDelegate = presentationC ;  // 指定自定义modal动画的代理
    
    [self presentViewController:toVC animated:YES completion:nil];
    [self dismissView];//清除顶部黑边
  
}



-(void)Head_btn
{

    //顶部
    UIView * HeadPic_bac= [[UIView alloc]initWithFrame:CGRectMake(0, 122, ScreenWidth, 81)];
    HeadPic_bac.backgroundColor = [UIColor whiteColor];
    [self.headerBackView addSubview:HeadPic_bac];
    
    //------------------------
    UIView * HeadPic= [[UIView alloc]initWithFrame:CGRectMake(10, 100, ScreenWidth-20, 100)];
    HeadPic.layer.cornerRadius = 5.0;//圆角
    HeadPic.layer.masksToBounds = NO;
    HeadPic.backgroundColor = [UIColor whiteColor];
//    // 阴影颜色
//    HeadPic.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//     // 阴影偏移，默认(0, -3)
//    HeadPic.layer.shadowOffset = CGSizeMake(0,2);
//    // 阴影透明度，默认0
//    HeadPic.layer.shadowOpacity = 0.3;
//    // 阴影半径，默认3
//    HeadPic.layer.shadowRadius = 1;
    
    //底
    UIView * aa  = [[UIView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth-20, 3)];
    aa.backgroundColor  = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    [HeadPic addSubview:aa];
    //左
    UIView * bb = [[UIView alloc]initWithFrame:CGRectMake(0, 4, 1, 96)];
    bb.backgroundColor  = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    [HeadPic addSubview:bb];
    //右
    UIView * cc = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-21, 4, 1, 96)];
    cc.backgroundColor  = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    [HeadPic addSubview:cc];

    
    
    //---------------------------
    
    //图片高度
   // CGFloat UIButtonHeight = HeadPic.frame.size.height;
     //图片宽度
    CGFloat UIButtonWidth = HeadPic.frame.size.width;
    
    UIButton *AA = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4-(UIButtonWidth/4/2+20),30,40,40)];
    [AA setImage:[UIImage imageNamed:@"HH"] forState:UIControlStateNormal];
    [AA addTarget:self action:@selector(Account) forControlEvents:UIControlEventTouchUpInside];
    [AA setTitle:@"帐户" forState:UIControlStateNormal];
    AA.titleLabel.font = [UIFont systemFontOfSize:14];
    AA.titleLabel.textAlignment = NSTextAlignmentCenter;
    [AA setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5] forState:UIControlStateNormal];
    [AA setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [AA setImageEdgeInsets:UIEdgeInsetsMake(-AA.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -AA.titleLabel.intrinsicContentSize.width)];
    [AA setTitleEdgeInsets:UIEdgeInsetsMake(AA.currentImage.size.height + 10, -AA.currentImage.size.width-10, 0, 0)];
    [HeadPic addSubview:AA];
    
    
    UIButton *BB = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4*2-(UIButtonWidth/4/2+20),30,40,40)];
    [BB setImage:[UIImage imageNamed:@"GG"] forState:UIControlStateNormal];
    //Button阴影
//    BB.layer.shadowColor = [UIColor blackColor].CGColor;
//    BB.layer.shadowOffset = CGSizeMake(5, 5);
//    BB.layer.shadowRadius = 5;
//    BB.layer.shadowOpacity = 0.5;
    [BB addTarget:self action:@selector(Action_wallet) forControlEvents:UIControlEventTouchUpInside];
    [BB setTitle:@"钱包" forState:UIControlStateNormal];
    BB.titleLabel.font = [UIFont systemFontOfSize:14];
    BB.titleLabel.textAlignment = NSTextAlignmentCenter;
    [BB setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5] forState:UIControlStateNormal];
    [BB setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [BB setImageEdgeInsets:UIEdgeInsetsMake(-BB.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -BB.titleLabel.intrinsicContentSize.width)];
    [BB setTitleEdgeInsets:UIEdgeInsetsMake(BB.currentImage.size.height + 10, -BB.currentImage.size.width-10, 0, 0)];
    [HeadPic addSubview:BB];
    
    UIButton *CC = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4*3-(UIButtonWidth/4/2+20),30,40,40)];
    [CC setImage:[UIImage imageNamed:@"JJ"] forState:UIControlStateNormal];
    [CC addTarget:self action:@selector(Action_order) forControlEvents:UIControlEventTouchUpInside];
    [CC setTitle:@"订单" forState:UIControlStateNormal];
    CC.titleLabel.font = [UIFont systemFontOfSize:14];
    CC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [CC setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5] forState:UIControlStateNormal];
    [CC setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [CC setImageEdgeInsets:UIEdgeInsetsMake(-CC.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -CC.titleLabel.intrinsicContentSize.width)];
    [CC setTitleEdgeInsets:UIEdgeInsetsMake(CC.currentImage.size.height + 10, -CC.currentImage.size.width-10, 0, 0)];
    [HeadPic addSubview:CC];
    
    UIButton *DD = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4*4-(UIButtonWidth/4/2+20),30,40,40)];
    [DD setImage:[UIImage imageNamed:@"II"] forState:UIControlStateNormal];
    [DD addTarget:self action:@selector(Authentication) forControlEvents:UIControlEventTouchUpInside];
    [DD setTitle:@"认证" forState:UIControlStateNormal];
    DD.titleLabel.font = [UIFont systemFontOfSize:14];
    DD.titleLabel.textAlignment = NSTextAlignmentCenter;
    [DD setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5] forState:UIControlStateNormal];
    [DD setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [DD setImageEdgeInsets:UIEdgeInsetsMake(-DD.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -DD.titleLabel.intrinsicContentSize.width)];
    [DD setTitleEdgeInsets:UIEdgeInsetsMake(DD.currentImage.size.height + 10, -DD.currentImage.size.width-10, 0, 0)];
    [HeadPic addSubview:DD];
    

    [self.headerBackView addSubview:HeadPic];
    
    
}
-(void)Action_wallet
{
    if ([_type isEqualToString:@"1"]) {
        _stus_type = @"0";//电池栏状态,当同一页面需要调用二个以上不同黑白状态栏使用传值
        Wallet_ViewController * vc = [[Wallet_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {

        [self performSelector:@selector(Login:) withObject:self ];


    }

}
-(void)Action_order
{
    
    if ([_type isEqualToString:@"1"]) {
        OrderType_ViewController *vc  = [[OrderType_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    } else {

        [self performSelector:@selector(Login:) withObject:self ];

    }

}
-(void)Account
{
    
    if ([_type isEqualToString:@"1"]) {
        Account_ViewController * vc =[[Account_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    } else {

        [self performSelector:@selector(Login:) withObject:self ];

    }

    
}
-(void)Authentication
{
    
    if ([_type isEqualToString:@"1"]) {
        Authentication_ViewController *vc = [[Authentication_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    } else {

        [self performSelector:@selector(Login:) withObject:self ];

    }


}
-(void)Quit_btn
{

    //底部退出
    _Foot_tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,70)style:UITableViewStyleGrouped];
    _Foot_tableView.backgroundColor = [UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1];
    self.tableV.tableFooterView=_Foot_tableView;
    
    
    UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
    [Qbutton setTitle:@"安全退出" forState:UIControlStateNormal];
    [Qbutton setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
    Qbutton.backgroundColor = [UIColor whiteColor];
    [Qbutton addTarget:self action:@selector(QUIT) forControlEvents:UIControlEventTouchUpInside];
    [self.Foot_tableView addSubview:Qbutton];

}
-(void)QUIT
{

      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出当前帐号？" preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // 操作事件
         }];
    
       UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // 获取沙盒位置（文件）
       NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
       NSString *documents = [array lastObject];
       NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
       //准备要存入的字典
       NSDictionary *dic_notice = [NSDictionary dictionaryWithObjectsAndKeys:self->_username,@"username",@"0",@"type",nil//登陆时写入1，退出时写入0
                                                                           ];
       //将字典存入指定的本地文件
       [dic_notice writeToFile:documnetPath atomically:YES];
 
        //清除cookies
        NSHTTPCookie *cookie;
        
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        
        for (cookie in [storage cookies])
            
        {
            
            [storage deleteCookie:cookie];
            
        }
        //刷新页面
        [self Quit_staus];
        //通知需要登陆才可以看到的页面
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTransferIndex" object:self userInfo:nil];
        }];
    
        
 
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
   
 
}
-(void)Quit_staus
{
    
     HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
     //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
     HUD.label.text = @"安全退出！";
     //HUD.minSize = CGSizeMake(100, 10);
     HUD.contentColor = [UIColor whiteColor];
     HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
    
     //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            //事件
            //刷新整个UITableView
            // 刷除tableV,释放内存
//            [self.tableV removeFromSuperview];
//            [self.tableV.layer removeFromSuperlayer];
//
//            //_tableV=nil;
//            [self Share];
            [self dismissView];
     [MBProgressHUD hideHUDForView:self.tableV animated:YES];
         
    
      });
}
- (void)dismissView{
     // 刷除tableV,释放内存
     [self.tableV removeFromSuperview];
     [self.tableV.layer removeFromSuperlayer];
    // NSLog(@"d");
     _tableV=nil;
     [self Share];
    
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // UIStatusBarStyleLightContent 白色
    // UIStatusBarStyleDefault      黑色
    if ([_stus_type isEqualToString:@"0"]) {
         return UIStatusBarStyleLightContent;
    } else {
         return UIStatusBarStyleDefault;//初始化，默认电池栏为白色
    }
 
}
- (void)viewDidAppear:(BOOL)animated{
     [super viewDidAppear:animated];
    // NSLog(@"1");
    if ([_stus_type isEqualToString:@"0"]) {
       
        
        _stus_type = @"0";//反回后，强制度刷新(UIStatusBarStyle)preferredStatusBarStyle
        [self setNeedsStatusBarAppearanceUpdate];//强制刷新电池栏
      
    }
    _stus_type = @"1";//反回后，强制度刷新(UIStatusBarStyle)preferredStatusBarStyle
    [self setNeedsStatusBarAppearanceUpdate];
   
    //接收通知，然后执行刷新
    //NSLog(@"555");
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateIndex:) name:@"updateTransferIndex" object:nil];
     // NSLog(@"已收到通知，并准备执行");

}


- (void)UpdateIndex:(NSNotification *)notification
{
//     //接收login传过来的成功失败状态代码
//      _code =[notification.userInfo objectForKey:@"code"];
//     [self beginA];
     //NSLog(@"已执行ZC刷新");
     // 刷除tableV,释放内存
     [self.tableV removeFromSuperview];
     [self.tableV.layer removeFromSuperlayer];

     _tableV=nil;
     [self Share];
    
   // [self dell];


}
- (void)dell{

    //删除观察者,十常重要，如果不删徐会出现大量重复数据，会死机

    [[NSNotificationCenter defaultCenter] removeObserver:self ];
     //NSLog(@"删了！！！！");
}

//解决顶部黑屏问题
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    // 刷除tableV,释放内存
   // NSLog(@"3");

    [self.tableV removeFromSuperview];
    [self.tableV.layer removeFromSuperlayer];
   
    _tableV=nil;
    [self Share];
    self.navigationController.navigationBarHidden= NO;//从其他内页返回时，显示导航
    
    

     UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleHeavy];
     [impactLight impactOccurred];
     //多种震动效果
     // UIImpactFeedbackStyleLight,
     //UIImpactFeedbackStyleMedium,
     //UIImpactFeedbackStyleHeavy
    
    // AudioServicesPlaySystemSound(SOUNDID);//文件类型
     //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动类型
     //AudioServicesPlaySystemSound(1519);
     //AudioServicesPlaySystemSound(1520);

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    //NSLog(@"2");
    //AudioServicesPlaySystemSound(SOUNDID);//文件类型
    //(kSystemSoundID_Vibrate);//震动类型


}


//计价方式返回用到调用

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];

    //NSLog(@"4");
    if ([_stus_type isEqualToString:@"0"]) {
        _stus_type = @"0";
        //NSLog(@"0");
        [self setNeedsStatusBarAppearanceUpdate];
     
    }

}
@end
