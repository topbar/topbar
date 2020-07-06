//
//  Hy_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2019/9/17.
//  Copyright © 2019 guo feng zou. All rights reserved.
//
//合约

#import "Hy_ViewController.h"

@interface Hy_ViewController ()

@end

@implementation Hy_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self Share];
}

-(void)Share
{
    

      
      // 设置窗口大小
      _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, self.view.bounds.size.height-89) style:UITableViewStyleGrouped];
     
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
-(void)begin
{
#pragma mark -上拉、下拉功能显示
   

    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    // [header beginRefreshing];
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
  //  dispatch_async(dispatch_get_main_queue(), ^{
  //  //刷新完成，执行后续代码
  //   });

}

-(void)Nav_UI
{
    
    //-------自己定义Nav
     UIView * vc =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 89)];
     vc.backgroundColor  = [UIColor orangeColor];
     [self.view addSubview:vc];

    //-------左返回
    UIButton *Button_Left = [[UIButton alloc]initWithFrame:CGRectMake(10,(89-20)/2+10,40,40)];
    [Button_Left setImage:[UIImage imageNamed:@"qr-code"] forState:UIControlStateNormal];
    //[Button_Left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:Button_Left];

     //-----居中的title
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-25+2, (89-20)/2+10, 50, 40)];
     [title setText:@"合约"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];
     //--右则按钮
     UIButton *DD = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50,(89-20)/2+10,40,40)];
     [DD setImage:[UIImage imageNamed:@"Mesg"] forState:UIControlStateNormal];
     [DD addTarget:self action:@selector(Authentication) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:DD];

    
}

-(void)HeadCon
{
    
    //余额区域
    UIView * HeadLableA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    HeadLableA.backgroundColor = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
    self.tableV.tableHeaderView = HeadLableA;
    UILabel * Title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 20, 200, 20)];
    Title.text = @"总帐户资产折合(BTC)";
    Title.textColor= [UIColor colorWithRed:255.0/255 green:255.1/255 blue:255.0/255 alpha:0.5];
    Title.font=[UIFont systemFontOfSize:14];
    [HeadLableA addSubview:Title];
    
    UILabel * Meny = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 40, 200, 40)];
    Meny.text = @"0.00000000";
    Meny.textColor = [UIColor whiteColor];
    Meny.font=[UIFont boldSystemFontOfSize:30];
    [HeadLableA addSubview:Meny];
    
    UILabel * MenyA = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/2.2), 40, 200, 40)];
    MenyA.text = @"≈ 0.00 USD";
    MenyA.textColor = [UIColor colorWithRed:255.0/255 green:255.1/255 blue:255.0/255 alpha:0.5];
    MenyA.font=[UIFont systemFontOfSize:14];
    [HeadLableA addSubview:MenyA];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 return 10;
           
   

}


//显示每一行的数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{
    
    static NSString * settingIdentifier=@"topbar";//这个是在没有自定议情况下的类
    
    //以下是当超过全屏时，会调用以下语句
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentifier];//获取一个类
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingIdentifier];

    tableView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];
    cell.textLabel.font = [UIFont italicSystemFontOfSize:16];//设置文本字体与大小
    cell.textLabel.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    cell.backgroundColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//详细箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色



    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
     if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
            [title setText:@"USDT"];
            title.textColor = [UIColor colorWithRed:38/255 green:129.1/255 blue:212.0/255 alpha:1];
            title.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:title];
            
            UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
            imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
            [cell.contentView addSubview:imageView];
            
            UILabel * aa = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 30, 40, 20)];
            [aa setText:@"可用"];
            aa.font = [UIFont systemFontOfSize:12];
            aa.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:aa];
                   
            UILabel * bb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 100, 20)];
            [bb setText:@"0.00122551"];
            bb.font = [UIFont systemFontOfSize:14];
            bb.textColor = [UIColor blackColor];
            [cell.contentView addSubview:bb];
            
            UILabel * cc = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 30, 40, 20)];
            [cc setText:@"冻结"];
            cc.font = [UIFont systemFontOfSize:12];
            cc.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:cc];
                   
            UILabel * dd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 50, 100, 20)];
            [dd setText:@"0.00000000"];
            dd.font = [UIFont systemFontOfSize:14];
            dd.textColor = [UIColor blackColor];
            [cell.contentView addSubview:dd];
            
            UILabel * ee = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 30, 70, 20)];
            [ee setText:@"折合(USD)"];
            ee.font = [UIFont systemFontOfSize:12];
            ee.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:ee];
            
            UILabel * ff = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/8), 50, 100, 20)];
            [ff setText:@"0.00"];
            ff.font = [UIFont boldSystemFontOfSize:14];
            ff.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
            [cell.contentView addSubview:ff];
            

            
        }
        if (indexPath.row == 1)
        {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
            [title setText:@"HUSD"];
            title.textColor = [UIColor colorWithRed:38/255 green:129.1/255 blue:212.0/255 alpha:1];
            title.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:title];
            
            UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
            imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
            [cell.contentView addSubview:imageView];
            
            UILabel * aa = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 30, 40, 20)];
            [aa setText:@"可用"];
            aa.font = [UIFont systemFontOfSize:12];
            aa.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:aa];
                   
            UILabel * bb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 100, 20)];
            [bb setText:@"0.00122551"];
            bb.font = [UIFont systemFontOfSize:14];
            bb.textColor = [UIColor blackColor];
            [cell.contentView addSubview:bb];
            
            UILabel * cc = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 30, 40, 20)];
            [cc setText:@"冻结"];
            cc.font = [UIFont systemFontOfSize:12];
            cc.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:cc];
                   
            UILabel * dd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 50, 100, 20)];
            [dd setText:@"0.00000000"];
            dd.font = [UIFont systemFontOfSize:14];
            dd.textColor = [UIColor blackColor];
            [cell.contentView addSubview:dd];
            
            UILabel * ee = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 30, 70, 20)];
            [ee setText:@"折合(USD)"];
            ee.font = [UIFont systemFontOfSize:12];
            ee.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:ee];
            
            UILabel * ff = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/8), 50, 100, 20)];
            [ff setText:@"0.00"];
            ff.font = [UIFont boldSystemFontOfSize:14];
            ff.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
            [cell.contentView addSubview:ff];
            

            
        }
        if (indexPath.row == 2)
        {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
            [title setText:@"BTC"];
            title.textColor = [UIColor colorWithRed:38/255 green:129.1/255 blue:212.0/255 alpha:1];
            title.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:title];
            
            UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
            imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
            [cell.contentView addSubview:imageView];
            
            UILabel * aa = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 30, 40, 20)];
            [aa setText:@"可用"];
            aa.font = [UIFont systemFontOfSize:12];
            aa.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:aa];
                   
            UILabel * bb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 100, 20)];
            [bb setText:@"0.00122551"];
            bb.font = [UIFont systemFontOfSize:14];
            bb.textColor = [UIColor blackColor];
            [cell.contentView addSubview:bb];
            
            UILabel * cc = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 30, 40, 20)];
            [cc setText:@"冻结"];
            cc.font = [UIFont systemFontOfSize:12];
            cc.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:cc];
                   
            UILabel * dd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 50, 100, 20)];
            [dd setText:@"0.00000000"];
            dd.font = [UIFont systemFontOfSize:14];
            dd.textColor = [UIColor blackColor];
            [cell.contentView addSubview:dd];
            
            UILabel * ee = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 30, 70, 20)];
            [ee setText:@"折合(USD)"];
            ee.font = [UIFont systemFontOfSize:12];
            ee.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:ee];
            
            UILabel * ff = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/8), 50, 100, 20)];
            [ff setText:@"0.00"];
            ff.font = [UIFont boldSystemFontOfSize:14];
            ff.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
            [cell.contentView addSubview:ff];
            

            
        }
  
       if (indexPath.row == 3)
       {
           UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
           [title setText:@"ETH"];
           title.textColor = [UIColor colorWithRed:38/255 green:129.1/255 blue:212.0/255 alpha:1];
           title.font = [UIFont boldSystemFontOfSize:14];
           [cell.contentView addSubview:title];
           
           UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
           imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
           [cell.contentView addSubview:imageView];
           
           UILabel * aa = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 30, 40, 20)];
           [aa setText:@"可用"];
           aa.font = [UIFont systemFontOfSize:12];
           aa.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
           [cell.contentView addSubview:aa];
                  
           UILabel * bb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 100, 20)];
           [bb setText:@"0.00122551"];
           bb.font = [UIFont systemFontOfSize:14];
           bb.textColor = [UIColor blackColor];
           [cell.contentView addSubview:bb];
           
           UILabel * cc = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 30, 40, 20)];
           [cc setText:@"冻结"];
           cc.font = [UIFont systemFontOfSize:12];
           cc.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
           [cell.contentView addSubview:cc];
                  
           UILabel * dd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 50, 100, 20)];
           [dd setText:@"0.00000000"];
           dd.font = [UIFont systemFontOfSize:14];
           dd.textColor = [UIColor blackColor];
           [cell.contentView addSubview:dd];
           
           UILabel * ee = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 30, 70, 20)];
           [ee setText:@"折合(USD)"];
           ee.font = [UIFont systemFontOfSize:12];
           ee.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
           [cell.contentView addSubview:ee];
           
           UILabel * ff = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/8), 50, 100, 20)];
           [ff setText:@"0.00"];
           ff.font = [UIFont boldSystemFontOfSize:14];
           ff.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
           [cell.contentView addSubview:ff];
           

           
       }
        if (indexPath.row == 4)
        {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
            [title setText:@"HT"];
            title.textColor = [UIColor colorWithRed:38/255 green:129.1/255 blue:212.0/255 alpha:1];
            title.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:title];
            
            UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
            imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
            [cell.contentView addSubview:imageView];
            
            UILabel * aa = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 30, 40, 20)];
            [aa setText:@"可用"];
            aa.font = [UIFont systemFontOfSize:12];
            aa.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:aa];
                   
            UILabel * bb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 100, 20)];
            [bb setText:@"0.00122551"];
            bb.font = [UIFont systemFontOfSize:14];
            bb.textColor = [UIColor blackColor];
            [cell.contentView addSubview:bb];
            
            UILabel * cc = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 30, 40, 20)];
            [cc setText:@"冻结"];
            cc.font = [UIFont systemFontOfSize:12];
            cc.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:cc];
                   
            UILabel * dd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 50, 100, 20)];
            [dd setText:@"0.00000000"];
            dd.font = [UIFont systemFontOfSize:14];
            dd.textColor = [UIColor blackColor];
            [cell.contentView addSubview:dd];
            
            UILabel * ee = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 30, 70, 20)];
            [ee setText:@"折合(USD)"];
            ee.font = [UIFont systemFontOfSize:12];
            ee.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:ee];
            
            UILabel * ff = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/8), 50, 100, 20)];
            [ff setText:@"0.00"];
            ff.font = [UIFont boldSystemFontOfSize:14];
            ff.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
            [cell.contentView addSubview:ff];
            

            
        }
        if (indexPath.row == 5)
        {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
            [title setText:@"TRX"];
            title.textColor = [UIColor colorWithRed:38/255 green:129.1/255 blue:212.0/255 alpha:1];
            title.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:title];
            
            UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
            imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
            [cell.contentView addSubview:imageView];
            
            UILabel * aa = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 30, 40, 20)];
            [aa setText:@"可用"];
            aa.font = [UIFont systemFontOfSize:12];
            aa.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:aa];
                   
            UILabel * bb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 100, 20)];
            [bb setText:@"0.00122551"];
            bb.font = [UIFont systemFontOfSize:14];
            bb.textColor = [UIColor blackColor];
            [cell.contentView addSubview:bb];
            
            UILabel * cc = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 30, 40, 20)];
            [cc setText:@"冻结"];
            cc.font = [UIFont systemFontOfSize:12];
            cc.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:cc];
                   
            UILabel * dd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 50, 100, 20)];
            [dd setText:@"0.00000000"];
            dd.font = [UIFont systemFontOfSize:14];
            dd.textColor = [UIColor blackColor];
            [cell.contentView addSubview:dd];
            
            UILabel * ee = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 30, 70, 20)];
            [ee setText:@"折合(USD)"];
            ee.font = [UIFont systemFontOfSize:12];
            ee.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:ee];
            
            UILabel * ff = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/8), 50, 100, 20)];
            [ff setText:@"0.00"];
            ff.font = [UIFont boldSystemFontOfSize:14];
            ff.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
            [cell.contentView addSubview:ff];
            

            
        }
        if (indexPath.row == 6)
        {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
            [title setText:@"GUSD"];
            title.textColor = [UIColor colorWithRed:38/255 green:129.1/255 blue:212.0/255 alpha:1];
            title.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:title];
            
            UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
            imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
            [cell.contentView addSubview:imageView];
            
            UILabel * aa = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 30, 40, 20)];
            [aa setText:@"可用"];
            aa.font = [UIFont systemFontOfSize:12];
            aa.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:aa];
                   
            UILabel * bb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 100, 20)];
            [bb setText:@"0.00122551"];
            bb.font = [UIFont systemFontOfSize:14];
            bb.textColor = [UIColor blackColor];
            [cell.contentView addSubview:bb];
            
            UILabel * cc = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 30, 40, 20)];
            [cc setText:@"冻结"];
            cc.font = [UIFont systemFontOfSize:12];
            cc.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:cc];
                   
            UILabel * dd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 50, 100, 20)];
            [dd setText:@"0.00000000"];
            dd.font = [UIFont systemFontOfSize:14];
            dd.textColor = [UIColor blackColor];
            [cell.contentView addSubview:dd];
            
            UILabel * ee = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 30, 70, 20)];
            [ee setText:@"折合(USD)"];
            ee.font = [UIFont systemFontOfSize:12];
            ee.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:ee];
            
            UILabel * ff = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/8), 50, 100, 20)];
            [ff setText:@"0.00"];
            ff.font = [UIFont boldSystemFontOfSize:14];
            ff.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
            [cell.contentView addSubview:ff];
            

            
        }
        if (indexPath.row == 7)
        {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
            [title setText:@"TUSD"];
            title.textColor = [UIColor blackColor];
            title.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:title];
            
            UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
            imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
            [cell.contentView addSubview:imageView];
            
            UILabel * aa = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 30, 40, 20)];
            [aa setText:@"可用"];
            aa.font = [UIFont systemFontOfSize:12];
            aa.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:aa];
                   
            UILabel * bb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 100, 20)];
            [bb setText:@"0.00122551"];
            bb.font = [UIFont systemFontOfSize:14];
            bb.textColor = [UIColor blackColor];
            [cell.contentView addSubview:bb];
            
            UILabel * cc = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 30, 40, 20)];
            [cc setText:@"冻结"];
            cc.font = [UIFont systemFontOfSize:12];
            cc.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:cc];
                   
            UILabel * dd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 50, 100, 20)];
            [dd setText:@"0.00000000"];
            dd.font = [UIFont systemFontOfSize:14];
            dd.textColor = [UIColor blackColor];
            [cell.contentView addSubview:dd];
            
            UILabel * ee = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 30, 70, 20)];
            [ee setText:@"折合(USD)"];
            ee.font = [UIFont systemFontOfSize:12];
            ee.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:ee];
            
            UILabel * ff = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/8), 50, 100, 20)];
            [ff setText:@"0.00"];
            ff.font = [UIFont boldSystemFontOfSize:14];
            ff.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
            [cell.contentView addSubview:ff];
            

            
        }
        if (indexPath.row == 8)
        {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
            [title setText:@"USDC"];
            title.textColor = [UIColor blackColor];
            title.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:title];
            
            UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
            imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
            [cell.contentView addSubview:imageView];
            
            UILabel * aa = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 30, 40, 20)];
            [aa setText:@"可用"];
            aa.font = [UIFont systemFontOfSize:12];
            aa.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:aa];
                   
            UILabel * bb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 100, 20)];
            [bb setText:@"0.00122551"];
            bb.font = [UIFont systemFontOfSize:14];
            bb.textColor = [UIColor blackColor];
            [cell.contentView addSubview:bb];
            
            UILabel * cc = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 30, 40, 20)];
            [cc setText:@"冻结"];
            cc.font = [UIFont systemFontOfSize:12];
            cc.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:cc];
                   
            UILabel * dd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 50, 100, 20)];
            [dd setText:@"0.00000000"];
            dd.font = [UIFont systemFontOfSize:14];
            dd.textColor = [UIColor blackColor];
            [cell.contentView addSubview:dd];
            
            UILabel * ee = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 30, 70, 20)];
            [ee setText:@"折合(USD)"];
            ee.font = [UIFont systemFontOfSize:12];
            ee.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:ee];
            
            UILabel * ff = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/8), 50, 100, 20)];
            [ff setText:@"0.00"];
            ff.font = [UIFont boldSystemFontOfSize:14];
            ff.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
            [cell.contentView addSubview:ff];
            

            
        }
        if (indexPath.row == 9)
        {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
            [title setText:@"BCH"];
            title.textColor = [UIColor blackColor];
            title.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:title];
            
            UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
            imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
            [cell.contentView addSubview:imageView];
            
            UILabel * aa = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 30, 40, 20)];
            [aa setText:@"可用"];
            aa.font = [UIFont systemFontOfSize:12];
            aa.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:aa];
                   
            UILabel * bb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 100, 20)];
            [bb setText:@"0.00122551"];
            bb.font = [UIFont systemFontOfSize:14];
            bb.textColor = [UIColor blackColor];
            [cell.contentView addSubview:bb];
            
            UILabel * cc = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 30, 40, 20)];
            [cc setText:@"冻结"];
            cc.font = [UIFont systemFontOfSize:12];
            cc.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:cc];
                   
            UILabel * dd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 50, 100, 20)];
            [dd setText:@"0.00000000"];
            dd.font = [UIFont systemFontOfSize:14];
            dd.textColor = [UIColor blackColor];
            [cell.contentView addSubview:dd];
            
            UILabel * ee = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 30, 70, 20)];
            [ee setText:@"折合(USD)"];
            ee.font = [UIFont systemFontOfSize:12];
            ee.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
            [cell.contentView addSubview:ee];
            
            UILabel * ff = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/8), 50, 100, 20)];
            [ff setText:@"0.00"];
            ff.font = [UIFont boldSystemFontOfSize:14];
            ff.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
            [cell.contentView addSubview:ff];
            

            
        }
    }

   
    
    //-----------
        //UITableView去掉自带系统的分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //自定义分割线

        UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 79, self.view.frame.size.width, 0.5)];
        VC.backgroundColor = RGBA(239, 239, 244, 1);
        [cell.contentView addSubview:VC];
    
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
    _tableV.sectionHeaderHeight = 30;
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


-(void)Authentication
{
        PopView  = [[Pop_ups alloc]init];
        //三选其一显示
        [PopView showInView];//遮挡新建的view
        //[PopView coutomshowInView:self.view];
        //[PopView coutomshowInView:[UIApplication sharedApplication].keyWindow];
        
         __block Hy_ViewController *blockSelf = self;//创建一个本地变量blockSelf，指向self，然后用结构体语法访问实例变量
         PopView.block = ^(NSString * text)
        {
           
        // NSString *email  =[[NSString alloc]init];
        // email = text;
              self->_Email = text;
                
            NSLog(@"===%@",text);
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





@end
