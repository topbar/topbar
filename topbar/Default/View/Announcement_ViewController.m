//
//  Announcement_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/4/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Announcement_ViewController.h"
#import "Placard_list_h5_ViewController.h"//公告

@interface Announcement_ViewController ()

@end

@implementation Announcement_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

       ///设置窗口大小
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, self.view.bounds.size.height-89) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //----隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //---滚动条修改颜色
    //self.tableV.indicatorStyle=UIScrollViewIndicatorStyleBlack;
    [self.view addSubview:_tableView];
    
    //设置导航控制器的代理(隐藏顶部-nav)
    self.navigationController.delegate = self;


    currentPage = 1;//初始化
    // //显示沙盒路径
    // NSArray * pathsa =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // NSLog(@"沙盒路径:%@",pathsa);

    [self Nav_UI];
    [self jsonParse];//预先加载
    [self begin];
 

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
     [Button_Left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:Button_Left];
     //-----居中的title
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-45, (89-20)/2+10, 90, 40)];
     [title setText:@"公告"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];
    

    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{
    
        
        
            //创建session对象
            NSURLSession *session = [NSURLSession sharedSession];
            NSString *UserApi=APIURL_USER;
               
            NSURL *url = [NSURL URLWithString:UserApi];
            NSString * Urladd =[NSString stringWithFormat:@"action=Placard&Pagesums=1&all=all"];
            //NSLog(@"%@",Urladd);
               
                 
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
              
                   //----------------公告
                   NSMutableArray * array = [dic objectForKey:@"Megss"];
                   NSMutableArray * Announcement = [array valueForKey:@"Announcement"];//公告信息5条
 
                   //将数组中的字典数据都转换成模型
                   self.dataArr=[News_NS mj_objectArrayWithKeyValuesArray:Announcement];
               //由于NSURLSession处理任务的操作默认都是在子线程中进行的，而像刷新数据设置图片这种操作必须在主线程中进行，因此必须进行线程间的通信，转到主队列，执行UI操作
                   // NSLog(@"===%@",Announcement);
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


- (void)jsonParse_more{

    //创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *UserApi=APIURL_USER;
       
    NSURL *url = [NSURL URLWithString:UserApi];
    NSString * Urladd =[NSString stringWithFormat:@"action=Placard&Pagesums=%ld&all=all",(long)currentPage];
    //NSLog(@"more=%@",Urladd);
         
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
           //NSLog(@"bbb==%@",dic);
                             //----------------公告
                NSMutableArray * array = [dic objectForKey:@"Megss"];
                NSMutableArray * Announcement = [array valueForKey:@"Announcement"];//公告信息5条
            
           
            
               //将数组中的字典数据都转换成模型
               //
               
               NSArray *dataArrB = [News_NS mj_objectArrayWithKeyValuesArray:Announcement];
               [self.dataArr addObjectsFromArray:dataArrB];

               
             //由于NSURLSession处理任务的操作默认都是在子线程中进行的，而像刷新数据设置图片这种操作必须在主线程中进行，因此必须进行线程间的通信，转到主队列，执行UI操作
               
               
               
               //判断请求JSON是否空值，如果是空值就会执行“已经全部加载完毕”， [self.tableView.mj_footer endRefreshingWithNoMoreData];
               
               if ([Announcement isKindOfClass:[NSArray class]] && Announcement.count > 0) {
                   
                   [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                     [self.tableView reloadData];
                    [self.tableView.mj_footer endRefreshing];
                       
                     }];
                     //NSLog(@"我是有数组的 ");
                   
               } else {
                 
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                   //NSLog(@"我是空数组的");
                   
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
        [task resume];//恢复线程，启动任务
        

}
-(void)begin
{
#pragma mark -上拉、下拉功能显示
 __unsafe_unretained __typeof(self) weakSelf = self;
    //下拉2样式隐藏时间////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    //[header beginRefreshing];
    // 设置header
    self.tableView.mj_header = header;
    
    //  上拉
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];

    

}
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
      self->currentPage = 1;//初始化
      [self jsonParse];//如果不添加重新请求（网址）JSON，数据不会随时下拉刷新
      //结束上拉刷新
      [self.tableView.mj_header endRefreshing];
       
      //第一次下拉时，刷新出3条数据，同时刷新上拉为还有更多字眼出现
      [self.tableView.mj_footer endRefreshing];
               
    });

}
#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    
    
    // 结束下拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    
    currentPage ++;
    
    [self jsonParse_more];//如果不添加重新请求（网址）JSON，数据不会随时下拉刷新
    
  
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
   //第一种方法
    [tableView tableViewDisplayWitMsg:@"网络不给力哟 ^-^" ifNecessaryForRowCount:self.dataArr.count];
    //return self.dataArr.count;
  //第二种方法
    //[self.tableView showDataCount:self.dataArr.count];
    
    //NSLog(@"77====%lu",(unsigned long)self.dataArr.count);
    self.tableView.mj_footer.hidden = (self.dataArr.count == 0);
    return self.dataArr.count;
    
    
    
}


//显示每一行的数据

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{
    
    
    
    
    static NSString *CellIdentifier = @"CustomCell";
    News_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    cell = [[News_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色
    tableView.backgroundColor = [UIColor whiteColor];
    

    
    // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
    News_NS *item=self.dataArr[indexPath.row];
    
    
    cell.Announcement_Title.text = item.Title;

    cell.Announcement_date.text = item.date;


    
    //UITableView去掉自带系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //自定义分割线
    //    UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 10)];
    //    VC.backgroundColor = RGBA(245,245,245,1);
    //    [cell.contentView addSubview:VC];
    UIView * VC1 = [[UIView alloc]initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, 1)];
    VC1.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [cell.contentView addSubview:VC1];
    
    
    
    return cell;
    
    
    
    
}
//顶部距离
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     //   NSLog(@"执行");
 
     //------TableView顶间距
    tableView.sectionHeaderHeight = 30;
    return [[UIView alloc]init]; //_tableV.sectionHeaderHeight = 50;”才生效
    
  
}


-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath//行间距离（108）
{
    
    // 一般cell的高度都需要根据内容来自适应高度，高度的变化就在此处根据indexPath来更改
    //    if(indexPath.row == 0)
    //    {
    //        return 100;
    //
    //    }
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath


{


            Placard_list_h5_ViewController * vc = [Placard_list_h5_ViewController alloc];
            //vc.hidesBottomBarWhenPushed =YES;//Push到news_list_h5_ViewController.m隐藏tabBar（底部导航）


            News_NS *item=self.dataArr[indexPath.row];
            vc.news_id = item.id  ;//传值到WEB页面
            //   NSLog(@"%@",item.id);

            [self.navigationController pushViewController:vc animated:YES];

    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    // NSLog(@"1");
    //AudioServicesPlaySystemSound(SOUNDID);//文件类型
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动类型
    //设置导航控制器的代理(隐藏顶部-nav)
    self.navigationController.delegate = self;


}
////// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

}

- (void)left:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
   
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
