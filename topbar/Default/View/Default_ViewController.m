//
//  Default_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2019/9/17.
//  Copyright © 2019 guo feng zou. All rights reserved.
//另外一种首页，数据单项刷新，没有菜单左右滑动

#import "Default_ViewController.h"
#import "Account_ViewController.h"

@interface Default_ViewController ()

@end

@implementation Default_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //只执行一次刷新
    [self jsonParse];//如果不添加重新请求（网址）JSON，数据不会随时下拉刷新
 
    [self Share];
}

-(void)Share
{
    

      
      // 设置窗口大小
     _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 89, ScreenWidth, ScreenHeight-60) style:UITableViewStyleGrouped];
     //*改变 UITableViewStyleGrouped 样式的 背景色 */
     //_tableV.backgroundView = [[UIView alloc]init];
     _tableV.backgroundColor = [UIColor whiteColor];
     
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
      // [self HeadLabel];
      [self Nav_UI];
      [self HeadCon];
      [self begin];
 
 

}

// 状态栏字体 白色 重写preferredStatusBarStyle 方法
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // UIStatusBarStyleLightContent 白色
    // UIStatusBarStyleDefault      黑色
    return UIStatusBarStyleLightContent;
}
//-(void)begin
//{
//#pragma mark -上拉、下拉功能显示
//
//
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    header.automaticallyChangeAlpha = YES;
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//    // 马上进入刷新状态
//    // [header beginRefreshing];
//    // 设置header
//    self.tableV.mj_header = header;
//
//
//}
//#pragma mark 下拉刷新数据
//- (void)loadNewData
//{
//
//     //结束上拉刷新
//    [self.tableV.mj_header endRefreshing];
//
//    // 刷除tableV,释放内存
//    [self.tableV removeFromSuperview];
//    [self.tableV.layer removeFromSuperlayer];
//    _tableV=nil;
//
//     //重新加载
//    [self Share];
//
//  //刷新UITableView
//  //  [self.tableV reloadData];
//  //  dispatch_async(dispatch_get_main_queue(), ^{
//  //  //刷新完成，执行后续代码
//  //   });
//
//}
-(void)begin
{
#pragma mark -上拉、下拉功能显示
   

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    //[header beginRefreshing];
    // 设置header
    self.tableV.mj_header = header;
   

}
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    //结束上拉刷新
    [self.tableV.mj_header endRefreshing];

    
    
    [self jsonParse];//如果不添加重新请求（网址）JSON，数据不会随时下拉刷新
    

    
    //第一次下拉时，刷新出3条数据，同时刷新上拉为还有更多字眼出现
     [self.tableV.mj_footer endRefreshing];


    
}

-(void)Nav_UI
{
    
    //-------自己定义Nav
     UIView * vc =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 89)];
      vc.backgroundColor  = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
     //vc.backgroundColor  = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
    
    
     [self.view addSubview:vc];

    //-------左返回
    UIButton *Button_Left = [[UIButton alloc]initWithFrame:CGRectMake(10,(89-20)/2+13,36,36)];
    [Button_Left setImage:[UIImage imageNamed:@"logo_234"] forState:UIControlStateNormal];
    //[Button_Left setImage:[UIImage imageNamed:@"qr-code"] forState:UIControlStateNormal];
    //[Button_Left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:Button_Left];
    
    UILabel * logo_text  = [[UILabel alloc]initWithFrame:CGRectMake(44, (89-20)/2+10,100,40)];
    logo_text.text = @"Topbar";
    logo_text.textColor  = [UIColor whiteColor];
    logo_text.font  =[UIFont boldSystemFontOfSize:30];
    [vc addSubview:logo_text];

     //-----居中的title
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-25+2, (89-20)/2+10, 50, 40)];
     //[title setText:@"合约"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];
     //--右则按钮
     UIButton *DD = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50,(89-20)/2+10,40,40)];
     //[DD setImage:[UIImage imageNamed:@"Mesg"] forState:UIControlStateNormal];
     [DD addTarget:self action:@selector(Authentication) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:DD];

    
}

-(void)HeadCon
{
    
    //广告区域
    UIView * HeadLableA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    HeadLableA.backgroundColor = [UIColor whiteColor];
    self.tableV.tableHeaderView = HeadLableA;
    //--
    UIView * Bgm = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    Bgm.backgroundColor = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
    [HeadLableA addSubview:Bgm];
    
    UIImageView * lineT = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2, 30, ScreenWidth/2, 100)];
    lineT.image = [UIImage imageNamed:@"line_topbar"];
    [Bgm addSubview:lineT];
    
    
    
    UILabel * Title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 40, 200, 20)];
    Title.text = @"新手入门";
    Title.textColor= [UIColor whiteColor];
    Title.font=[UIFont systemFontOfSize:30];
    [Bgm addSubview:Title];
    
    UILabel * Meny = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 70, 400, 40)];
    Meny.text = @"快速拥有数字货币，让你的交易快人一步！";
    Meny.textColor = [UIColor colorWithRed:255.0/255 green:255.1/255 blue:255.0/255 alpha:0.5];
    Meny.font=[UIFont systemFontOfSize:16];
    [Bgm addSubview:Meny];

    
    //----
    UIView * baner = [[UIView alloc]initWithFrame:CGRectMake(0, 140, ScreenWidth, 60)];
    baner.backgroundColor = [UIColor whiteColor];
    
        CGFloat UIButtonWidth = ScreenWidth;
        UIButton *AA = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4-(UIButtonWidth/4/2+10),30,20,20)];
        [AA setImage:[UIImage imageNamed:@"user_1"] forState:UIControlStateNormal];
        [AA addTarget:self action:@selector(Account) forControlEvents:UIControlEventTouchUpInside];
        [AA setTitle:@"帐户" forState:UIControlStateNormal];
        AA.titleLabel.font = [UIFont systemFontOfSize:12];
        AA.titleLabel.textAlignment = NSTextAlignmentCenter;
        [AA setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [AA setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [AA setImageEdgeInsets:UIEdgeInsetsMake(-AA.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -AA.titleLabel.intrinsicContentSize.width)];
        [AA setTitleEdgeInsets:UIEdgeInsetsMake(AA.currentImage.size.height + 10, -AA.currentImage.size.width-10, 0, 0)];
        [baner addSubview:AA];
        
        
        UIButton *BB = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4*2-(UIButtonWidth/4/2+10),30,20,20)];
        [BB setImage:[UIImage imageNamed:@"wallet"] forState:UIControlStateNormal];
        [BB setTitle:@"钱包" forState:UIControlStateNormal];
        BB.titleLabel.font = [UIFont systemFontOfSize:12];
        BB.titleLabel.textAlignment = NSTextAlignmentCenter;
        [BB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [BB setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [BB setImageEdgeInsets:UIEdgeInsetsMake(-BB.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -BB.titleLabel.intrinsicContentSize.width)];
        [BB setTitleEdgeInsets:UIEdgeInsetsMake(BB.currentImage.size.height + 10, -BB.currentImage.size.width-10, 0, 0)];
        [baner addSubview:BB];
        
        UIButton *CC = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4*3-(UIButtonWidth/4/2+10),30,20,20)];
        [CC setImage:[UIImage imageNamed:@"increasing"] forState:UIControlStateNormal];
        //[CC addTarget:self action:@selector(Action_order) forControlEvents:UIControlEventTouchUpInside];
        [CC setTitle:@"订单" forState:UIControlStateNormal];
        CC.titleLabel.font = [UIFont systemFontOfSize:12];
        CC.titleLabel.textAlignment = NSTextAlignmentCenter;
        [CC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [CC setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [CC setImageEdgeInsets:UIEdgeInsetsMake(-CC.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -CC.titleLabel.intrinsicContentSize.width)];
        [CC setTitleEdgeInsets:UIEdgeInsetsMake(CC.currentImage.size.height + 10, -CC.currentImage.size.width-10, 0, 0)];
        [baner addSubview:CC];
        
        UIButton *DD = [[UIButton alloc]initWithFrame:CGRectMake(UIButtonWidth/4*4-(UIButtonWidth/4/2+10),30,20,20)];
        [DD setImage:[UIImage imageNamed:@"security"] forState:UIControlStateNormal];
        //[DD addTarget:self action:@selector(Authentication) forControlEvents:UIControlEventTouchUpInside];
        [DD setTitle:@"认证" forState:UIControlStateNormal];
        DD.titleLabel.font = [UIFont systemFontOfSize:12];
        DD.titleLabel.textAlignment = NSTextAlignmentCenter;
        [DD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [DD setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [DD setImageEdgeInsets:UIEdgeInsetsMake(-DD.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -DD.titleLabel.intrinsicContentSize.width)];
        [DD setTitleEdgeInsets:UIEdgeInsetsMake(DD.currentImage.size.height + 10, -DD.currentImage.size.width-10, 0, 0)];
        [baner addSubview:DD];
    
    [HeadLableA addSubview:baner];
    
    
    //自定义分割线
    UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 219, ScreenWidth, 0.5)];
    VC.backgroundColor = RGBA(239, 239, 244, 1);
    //.backgroundColor = [UIColor orangeColor];
    [HeadLableA addSubview:VC];
    //----
    UIView * gonggao = [[UIView alloc]initWithFrame:CGRectMake(0, 220, ScreenWidth, 40)];
    gonggao.backgroundColor = [UIColor whiteColor];
    
    UIButton * MegUi = [[UIButton alloc]initWithFrame:CGRectMake(20,10,20,20)];
    [MegUi setImage:[UIImage imageNamed:@"volume"] forState:UIControlStateNormal];
    [gonggao addSubview:MegUi];
    
    UILabel * gonggao_text = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, ScreenWidth, 40)];
    gonggao_text.text  = @"全球领先的交易所公链OKChain测试网上线";
    gonggao_text.font = [UIFont systemFontOfSize:12];
    gonggao_text.textColor = [UIColor grayColor];
    [gonggao addSubview:gonggao_text];
    
    UIButton * MegUi_R = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-26,10,20,20)];
    [MegUi_R setImage:[UIImage imageNamed:@"app_back_btn_F"] forState:UIControlStateNormal];
    [gonggao addSubview:MegUi_R];
    
    [HeadLableA addSubview:gonggao];
    //----
    UIView * ADbaner = [[UIView alloc]initWithFrame:CGRectMake(10, 260, ScreenWidth-20, 40)];
    ADbaner.layer.cornerRadius = 5.0;//圆角
    ADbaner.layer.masksToBounds = NO;
    ADbaner.backgroundColor = [UIColor blackColor];
    
    UILabel * ban_text = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 40)];
    ban_text.text = @"USDT";
    ban_text.font = [UIFont systemFontOfSize:18];
    ban_text.textColor = [UIColor systemBlueColor];
    [ADbaner addSubview:ban_text];
    
    UILabel * ban_text_1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 400, 40)];
    ban_text_1.text = @"交割合约上线九大币种合约交易";
    ban_text_1.font = [UIFont systemFontOfSize:16];
    ban_text_1.textColor = [UIColor whiteColor];
    [ADbaner addSubview:ban_text_1];
    
    [HeadLableA addSubview:ADbaner];

    //-------涨跌、实时价、最高价、最低价
    UIView * Mume  = [[UIView alloc]initWithFrame:CGRectMake(0, 300, ScreenWidth, 40)];
    Mume.backgroundColor  = [UIColor colorWithRed:248.0/255 green:248.0/255 blue:255.0/255 alpha:1];
    [HeadLableA addSubview:Mume];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 7.5, 120, 30)];
    name.text  = @"币种/流通市值($)";
    name.font= [UIFont systemFontOfSize:14];
    name.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    [Mume addSubview:name];
    
//    UILabel * higt_low = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3,7.5, 80, 30)];
//    higt_low.text  = @"高/低价($)";
//    higt_low.font= [UIFont systemFontOfSize:14];
//    higt_low.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
//    [Mume addSubview:higt_low];
    
    UILabel * new = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.2,7.5, 80, 30)];
    new.text  = @"全球指数($)";
    new.font= [UIFont systemFontOfSize:14];
    new.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    [Mume addSubview:new];
    
    UILabel * Upsdowns = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.25, 7.5, 80, 30)];
    Upsdowns.text  = @"24H涨跌";
    Upsdowns.font= [UIFont systemFontOfSize:14];
    Upsdowns.textColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    [Mume addSubview:Upsdowns];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{
 //    NSLog(@"%@",_type);
 //     NSLog(@"%@",_titlea);
    NSString *api_url = [NSString stringWithFormat:@"public/v1/ticker?limit=10&convert=cny"];
  

    NSString *Get_Url_String =[APIURL_HC_Global stringByAppendingString:api_url];
    //NSString *Get_Url_String=@"http://192.168.14.104/website/admin/zbapi.php";
    //NSLog(@"%@",Get_Url_String);
    
    // 1、构造URL资源地址
    NSURL *url = [NSURL URLWithString:Get_Url_String];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    // 3、配置Request请求
    request.HTTPMethod = @"GET";
    // 设置请求超时
    request.timeoutInterval = 10.0;
    
    
    //创建会话（这里使用了一个全局会话）并且启动任务
    // 构造NSURLSessionConfiguration
    NSURLSession *session=[NSURLSession sharedSession];
    //从会话创建任务
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable  data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                    
                                    {
                                        if (!error )
                                        {
                                            
                                            // JSON数据格式解析
                                            
                                            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                            
                                           // NSMutableArray * array = [dic objectForKey:@"news"];
                                            self.dataArr=[Global_News_NS mj_objectArrayWithKeyValuesArray:dic];
                                            
                                            // NSLog(@"===%@",dic);
                                            // NSLog(@"%@",self->_dataArr);
                                         
                           
                                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                             [self.tableV reloadData];
                                                
                                                // 拿到当前的下拉刷新控件，结束刷新状态
                                             [self.tableV.mj_header endRefreshing];
                                            }];
                                            
                                            
                                            
                                            // 判断是否解析成功
                                            if (error)
                                            {
                                                NSLog(@"解析失败%@",error.localizedDescription);
                                                
                                            }else
                                            {
                                                
                                                
                                                
                                                
                                                // NSLog(@"解析成功%@",teamtitles);
                                            }
                                        }
                                        else
                                            
                                        {
                                            NSLog(@"error is :%@",error.localizedDescription);
                                        }
                                    }];
    
    
    
    
    [dataTask resume];//恢复线程，启动任务
   
    
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
    
    self.tableV.mj_footer.hidden = (self.dataArr.count == 0);
    return self.dataArr.count;
   
    
    
    
}
//显示每一行的数据

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{
    
    
    
    
    static NSString *CellIdentifier = @"CustomCell";
    Global_News_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //启动重用机制
      if (cell == nil) {
    cell = [[Global_News_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
      }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

 //@property (nonatomic,retain)  UILabel * symbol;   //货币名称
 //@property (nonatomic,retain)  UILabel * logo; //
 //@property (nonatomic,retain)  UILabel * market_cap_usd;   //流通市值（单位：美元）
 //@property (nonatomic,retain)  UILabel * price_usd;  //实时价/最新成交价/美金价
 //@property (nonatomic,retain)  UILabel * price_btc;  //实时价/BTC价格
 //@property (nonatomic,retain)  UILabel * percent_change_24h; //24小时涨跌幅

    
    // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
    Global_News_NS *item=self.dataArr[indexPath.row];
    
    cell.symbol.text = item.symbol;
    [cell.logo_png sd_setImageWithURL:[NSURL URLWithString:item.logo_png]placeholderImage:[UIImage imageNamed:@"nopic.png"]];
    cell.price_usd.text = item.price_usd;
    //cell.price_cny.text = item.price_cny;
    CGFloat AintString = (CGFloat) ([item.price_cny floatValue]);
    cell.price_cny.text = [NSString stringWithFormat:@"%@%.2f",@"¥",AintString];
     
    CGFloat intString = (CGFloat) ([item.percent_change_24h floatValue]);
    if (intString > 0.0001) {
        cell.percent_change_24h.text = [NSString stringWithFormat:@"%@%.2f%@",@"+",intString,@"%"];
        cell.percent_change_24h.textColor  = [UIColor redColor];
        //NSLog(@"%@",[NSString stringWithFormat:@"%@%.2f%@",@"+",intString,@"%"]);
    } else {
        cell.percent_change_24h.text = [NSString stringWithFormat:@"%.2f%@",intString,@"%"];;
        cell.percent_change_24h.textColor = [UIColor colorWithRed:77.0/255 green:179.0/255 blue:118.0/255 alpha:1];
    }
    
    CGFloat tFloat = (CGFloat)([item.market_cap_usd floatValue])/100000000;
    cell.market_cap_usd.text = [NSString stringWithFormat:@"%.2f%@",tFloat,@"亿"];
    


    
    //UITableView去掉自带系统的分割线
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //自定义分割线
    UIView * VC1 = [[UIView alloc]initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, 1)];
    VC1.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [cell.contentView addSubview:VC1];
    
   
    return cell;
     
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//行间距离（108）
{
    
    return 80;
    
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
    _tableV.sectionHeaderHeight = 40;
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

              // NSLog(@"隐私政策");
          
                
            }
            if (indexPath.row == 1)
             {

              //   NSLog(@"去评分");
                           
             }
            if (indexPath.row == 2)
             {

             //   NSLog(@"版本");
                           
             }
            
     
           
            
            
            break;
        }

        
    }
}

-(void)Account
{
    Account_ViewController * vc =[[Account_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)Authentication
{
//        PopView  = [[Pop_ups alloc]init];
//        //三选其一显示
//        [PopView showInView];//遮挡新建的view
//        //[PopView coutomshowInView:self.view];
//        //[PopView coutomshowInView:[UIApplication sharedApplication].keyWindow];
//
//         __block Hy_ViewController *blockSelf = self;//创建一个本地变量blockSelf，指向self，然后用结构体语法访问实例变量
//         PopView.block = ^(NSString * text)
//        {
//
//        // NSString *email  =[[NSString alloc]init];
//        // email = text;
//              self->_Email = text;
//
//            NSLog(@"===%@",text);
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
//            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                    // Do something...
//
//            [blockSelf DismissViewController];
//
//        });
//
//        };
    
}


////// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

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



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    //NSLog(@"2");
    //AudioServicesPlaySystemSound(SOUNDID);//文件类型
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动类型


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

      // NSLog(@"1");
      // 刷除tableV,释放内存
       [self.tableV removeFromSuperview];
       [self.tableV.layer removeFromSuperlayer];
       _tableV=nil;
    [self Share];



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



@end
