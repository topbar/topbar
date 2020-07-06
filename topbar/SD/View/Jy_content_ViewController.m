//
//  Jy_content_ViewController.m
//  topbar
//
//  Created by topbar on 2019/9/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//交易H5内容

#import "Jy_content_ViewController.h"
#import "news_list_h5_A_ViewController.h"

@interface Jy_content_ViewController ()

@end

@implementation Jy_content_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.view.backgroundColor = [UIColor grayColor];
    // _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height-120)style:UITableViewStyleGrouped];
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    

    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
  
   /*改变 UITableViewStyleGrouped 样式的 背景色 */
     _tableView.backgroundView = [[UIView alloc]init];
     _tableView.backgroundColor = [UIColor clearColor];
    
    //不要忘写了这两句话哟调用delegate*/
    _tableView.delegate =self;
    _tableView.dataSource=self;
    //----隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIView *viewA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.001)];
    self.tableView.tableHeaderView = viewA;
    
    
  
    // [self.view addSubview:_tableView];
    self.view = _tableView;

    currentPage = 1;//初始化
    // //显示沙盒路径
    // NSArray * pathsa =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // NSLog(@"沙盒路径:%@",pathsa);

    [self jsonParse];//预先加载
    [self begin];
   // [self CheckNet];
    
   
//

    

}


////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{
    
  //  NSLog(@"%@",_type);
  /// NSLog(@"%@",_titlea);
    
    NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=1&type=%@",_type];
    NSString *Get_Url_String =[APIURL stringByAppendingString:api_url];

                            
    // NSString *Get_Url_String = [NSString stringWithFormat:@"http://103.75.3.66:6006/Handlershuju.ashx?act=Zuqiu&Zlqlxs=1"];
    // NSLog(@"====%ld",(long)currentPage);
    // NSLog(@"%@",_type);
    // NSLog(@"%@",_titlea);
    // NSLog(@"%@====",Get_Url_String);
 
    
    // 1、构造URL资源地址
    NSURL *url = [NSURL URLWithString:Get_Url_String];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    // 3、配置Request请求
    request.HTTPMethod = @"GET";
    // 设置请求超时
    request.timeoutInterval = 10.0;
    //NSLog(@"%@",request);
    
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
                                            
//                                            //获取字符串
//                                            NSString *bbslistA = [dic objectForKey:@"data"];
//
//
//                                                                      //将字符串转成字典，重新解析
//                                            NSData *jsonData = [bbslistA dataUsingEncoding:NSUTF8StringEncoding];
//
//                                            NSError *err;
//
//                                            NSDictionary *dica = [NSJSONSerialization JSONObjectWithData:jsonData
//
//                                                                                                 options:NSJSONReadingMutableContainers
//
//                                                                                                   error:&err];
//
    NSMutableArray * array = [dic objectForKey:@"news"];
                                            
                                            //if (dic == (NULL))
//                                            if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
//                                                          //主线程
//                                                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//                                                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                                                    self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//                                                    self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                                                    self->HUD.label.text = @"数据加载成功";
//                                                    //self->HUD.minSize = CGSizeMake(100, 10);
//                                                    self->HUD.offset = CGPointMake(0, -300);
//                                                    self->HUD.contentColor = [UIColor whiteColor];
//                                                    self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
//                                                    self->HUD.minShowTime= 0.5;/*指示器停留的时间/以秒为做单位*/
//                                                    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//
//                                                    return;
//
//
//                                                });
//                                            } else {
//                                                          //主线程
//                                                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//                                                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                                                    self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//                                                    self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                                                    self->HUD.label.text = @"数据加载失败";
//                                                    //self->HUD.minSize = CGSizeMake(100, 10);
//                                                    self->HUD.offset = CGPointMake(0, -300);
//                                                    self->HUD.contentColor = [UIColor whiteColor];
//                                                    self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
//                                                    self->HUD.minShowTime= 0.5;/*指示器停留的时间/以秒为做单位*/
//                                                    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//
//                                                    return;
//
//
//                                                });
//                                            }
//
                                            
                                            
                                            
                                            
                                            
                                            
                                            
          //将数组中的字典数据都转换成模型
          self.dataArr=[News_NS mj_objectArrayWithKeyValuesArray:array];
    //由于NSURLSession处理任务的操作默认都是在子线程中进行的，而像刷新数据设置图片这种操作必须在主线程中进行，因此必须进行线程间的通信，转到主队列，执行UI操作
        // NSLog(@"===%@",array);
         //NSLog(@"%@",self->_dataArr);
       [[NSOperationQueue mainQueue]addOperationWithBlock:^{
       [self.tableView reloadData];
       [self.tableView.mj_header endRefreshing];
                                            }];
                                            
//         // if ([array isKindOfClass:[NSArray class]] && array.count > 0)
//         if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0)
//         {
//
//           [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//             [self.tableView reloadData];
//             [self.tableView.mj_header endRefreshing];
//
//          }];
//             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                 self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//                 self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                 self->HUD.label.text = @"加载完成";
//                 //self->HUD.minSize = CGSizeMake(100, 10);
//                 self->HUD.offset = CGPointMake(0, -200);
//                 self->HUD.contentColor = [UIColor whiteColor];
//                 self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
//
//                 self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
//                 [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//                    });
//            // NSLog(@"我是有数组的 ");
//
//         } else {
//
//         // [self.tableView.mj_footer endRefreshingWithNoMoreData];
//             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                 self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//                 self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                 self->HUD.label.text = @"暂无数据";
//                 //self->HUD.minSize = CGSizeMake(100, 10);
//                 self->HUD.offset = CGPointMake(0, -200);
//                 self->HUD.contentColor = [UIColor whiteColor];
//                 self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
//
//                 self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
//                 [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//
//                            });
//
//          //NSLog(@"我是空数组的");
//
//         }
                                            
                                            
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


////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse_more{
    NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=%ld&type=%@",(long)currentPage,_type];
     NSString *Get_Url_String =[APIURL stringByAppendingString:api_url];
    
   
    
   // NSLog(@"%ld",(long)currentPage);
//      NSLog(@"%@",_type);
//      NSLog(@"%@",_titlea);
   // NSLog(@"%@",Get_Url_String);
    
    // 1、构造URL资源地址
    NSURL *url = [NSURL URLWithString:Get_Url_String];
    // NSLog(@"%@",url);
    
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
                                            
//                                            //获取字符串
//                                            NSString *bbslistA = [dic objectForKey:@"data"];
//
//
//                                            //将字符串转成字典，重新解析
//                                            NSData *jsonData = [bbslistA dataUsingEncoding:NSUTF8StringEncoding];
//
//                                            NSError *err;
//
//                                            NSDictionary *dica = [NSJSONSerialization JSONObjectWithData:jsonData
//
//                                                                                                 options:NSJSONReadingMutableContainers
//
//                                                                                                   error:&err];
                                            
                                            NSMutableArray * array = [dic objectForKey:@"news"];
                                            
                                            
                                            
                                            //将数组中的字典数据都转换成模型
                                            //
                                            
                                            NSArray *dataArrB = [News_NS mj_objectArrayWithKeyValuesArray:array];
                                            [self.dataArr addObjectsFromArray:dataArrB];
                                          //   NSLog(@"%@",array);
                                            
                                          //由于NSURLSession处理任务的操作默认都是在子线程中进行的，而像刷新数据设置图片这种操作必须在主线程中进行，因此必须进行线程间的通信，转到主队列，执行UI操作
                                            
                                            
                                            
                                            //判断请求JSON是否空值，如果是空值就会执行“已经全部加载完毕”， [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                            
                                            if ([array isKindOfClass:[NSArray class]] && array.count > 0) {
                                                
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                  [self.tableView reloadData];
                                                 [self.tableView.mj_footer endRefreshing];
                                                    
                                                  }];
                                                 // NSLog(@"我是有数组的 ");
                                                
                                            } else {
                                              
                                             [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                            //    NSLog(@"我是空数组的");
                                                
                                            }
                                            
                                           
                                            
                                            
                                            
                                            
                                            
                                            
                                            
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


-(void)begin
{
#pragma mark -上拉、下拉功能显示
    __unsafe_unretained __typeof(self) weakSelf = self;
    
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
//               dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);//数字为时间延时
//               dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                           // Do something...
//
//
//
//           });

    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        

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
    
    
    
    // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
    News_NS *item=self.dataArr[indexPath.row];
    
    
    cell.Title.text = item.Title;
    

    //  cell.Edittime.text = item.Edittime;
    //  截取从0位到第n为（第n位不算在内）
    NSString *DATE = [item.Edittime substringToIndex:10];
    cell.Edittime.text = DATE;

    
    cell.Lable.text = item.Lable;
    
    NSString *api_url = [NSString stringWithFormat:@"%@",item.FirstPics];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
    
    NSString *string = urlString;
    NSURL *picURL = [NSURL URLWithString:string];
    [cell.FirstPics sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"nopic.png"] ];
    
    
   // [cell.FirstPics sd_setImageWithURL:[NSURL URLWithString:item.FirstPics]placeholderImage:[UIImage imageNamed:@"nopic.png"]];
    
    
   
    
    
    
    
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
////顶部距离
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 1.f;
//}

//顶部距离
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     //   NSLog(@"执行");
 
     //------TableView顶间距
    tableView.sectionHeaderHeight = 20;
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


            news_list_h5_A_ViewController * vc = [news_list_h5_A_ViewController alloc];
            vc.hidesBottomBarWhenPushed =YES;//Push到news_list_h5_ViewController.m隐藏tabBar（底部导航）
  
    
            News_NS *item=self.dataArr[indexPath.row];
            vc.news_id = item.id  ;//传值到WEB页面
            //   NSLog(@"%@",item.id);
    
            [self.navigationController pushViewController:vc animated:YES];

    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    // NSLog(@"2");
    //AudioServicesPlaySystemSound(SOUNDID);//文件类型
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动类型


}
@end
