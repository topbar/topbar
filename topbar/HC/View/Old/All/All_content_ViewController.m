//
//  All_content_ViewController.m
//  topbar
//
//  Created by topbar on 2019/9/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "All_content_ViewController.h"
#import "news_list_h5_ViewController.h"

@interface All_content_ViewController ()

@end

@implementation All_content_ViewController


{
    NSArray *_imagesURLStrings;
    SDCycleScrollView *_customCellScrollViewDemo;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor grayColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height-120)style:UITableViewStyleGrouped];
    
    _tableView.delegate =self;//不要忘写了这两句话哟调用delegate*/
    _tableView.dataSource=self;
    
    /*改变 UITableViewStyleGrouped 样式的 背景色 */
    _tableView.backgroundView = [[UIView alloc]init];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    currentPage = 1;//初始化
    //  [self jsonParse];
    [self jsonParsePic];
    [self begin];

    
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{
      //  NSLog(@"%@",_type);
    // NSLog(@"%@",_titlea);
    NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=1&type=%@",_type];
    NSString *Get_Url_String =[APIURL stringByAppendingString:api_url];
  //  NSString *Get_Url_String = [NSString stringWithFormat:@"http://192.168.14.109/website/admin/JSON.PHP?Pagesums=1&type=%@",_type];
    // NSString *Get_Url_String = [NSString stringWithFormat:@"http://103.75.3.66:6006/Handlershuju.ashx?act=Zuqiu&Zlqlxs=1"];
    // NSLog(@"====%ld",(long)currentPage);
      //  NSLog(@"%@",_type);
      //    NSLog(@"%@",_titlea);
    //    NSLog(@"%@",Get_Url_String);
    
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
                                            self.dataArr=[News_NS mj_objectArrayWithKeyValuesArray:array];
                                            //由于NSURLSession处理任务的操作默认都是在子线程中进行的，而像刷新数据设置图片这种操作必须在主线程中进行，因此必须进行线程间的通信，转到主队列，执行UI操作
                                           // NSLog(@"%@",array);
                                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                [self.tableView reloadData];
                                                
                                                // 拿到当前的下拉刷新控件，结束刷新状态
                                                [self.tableView.mj_header endRefreshing];
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


////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse_more{
    
    NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=%ld&type=%@",(long)currentPage,_type];
    NSString *Get_Url_String =[APIURL stringByAppendingString:api_url];
   // NSString *Get_Url_String = [NSString stringWithFormat:@"http://192.168.14.109/website/admin/JSON.PHP?Pagesums=%ld&type=%@",(long)currentPage,_type];
    
    
    
    
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
                                            //   NSLog(@"%@",_dataArr);
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
    [header beginRefreshing];
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
    //结束上拉刷新
    [self.tableView.mj_header endRefreshing];
    currentPage = 1;//初始化
    
    
    [self jsonParse];//如果不添加重新请求（网址）JSON，数据不会随时下拉刷新
    

    
    //第一次下拉时，刷新出3条数据，同时刷新上拉为还有更多字眼出现
     [self.tableView.mj_footer endRefreshing];
    
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

-(void)header
{
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 180)];
    demoContainerView.contentSize = CGSizeMake(self.view.frame.size.width, 180);
    // [self.view addSubview:demoContainerView];
    self.tableView.tableHeaderView = demoContainerView;
    
    
    // 采用网络图片实现
    NSArray *imagesURLStrings = _Pic_TextFirstPics;
    _imagesURLStrings = imagesURLStrings;
    //  NSLog(@"%@",Pic_TextFirstPics);
    
    // 图片配文字
    NSArray *titles = _Pic_Titles;
    
    
    CGFloat w = self.view.bounds.size.width;
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"nopic.png"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [demoContainerView addSubview:cycleScrollView2];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //NSLog(@"---点击了第%ld张图片", (long)index);
  //  NSLog(@"%@",[_Pic_IDs objectAtIndex:(long)index]);
      news_list_h5_ViewController * vc = [news_list_h5_ViewController alloc];
      vc.news_id = [_Pic_IDs objectAtIndex:(long)index]  ;//传值到WEB页面
      [self.navigationController pushViewController:vc animated:YES];
    
    
    // [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
    //    [你的CycleScrollview adjustWhenControllerViewWillAppera];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParsePic{
    
    NSString *api_url = [NSString stringWithFormat:@"json_lunbo.php?type=%@",_type];
    NSString *Get_Url_String =[APIURL stringByAppendingString:api_url];
   // NSString *Get_Url_String = [NSString stringWithFormat:@"http://192.168.14.109/website/admin/json_lunbo.php?type=%@",_type];
    //NSLog(@"====%@",Get_Url_String);
    
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
                                            
                                             NSMutableArray * array = [dic objectForKey:@"news_lunbo_pic"];
                                           // NSLog(@"%@",array);
                                            
                                            
                                            self->_Pic_IDs = [[NSMutableArray alloc]init];//
                                            self->_Pic_Titles = [[NSMutableArray alloc]init];////
                                            self->_Pic_TextFirstPics = [[NSMutableArray alloc]init];//
                                            
                                            
                                            //获取字符串
                                            self->_Pic_IDs = [array valueForKeyPath:@"id"];
                                            self->_Pic_Titles = [array valueForKeyPath:@"Title"];
                                            self->_Pic_TextFirstPics  = [array valueForKeyPath:@"FirstPics"];
                                            
//
//                                            NSLog(@"iD--》%@", self->_Pic_IDs );
//                                            NSLog(@"标题--》%@", self->_Pic_Titles );
//                                            NSLog(@"轮播图URL--》%@", self->_Pic_TextFirstPics );
                                          
                                            
                                            
                                            
                                            
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
    
    [NSThread sleepForTimeInterval:0.5];//延时加以便tableview显示数据
    // [_tableView reloadData];
    [self header];
    
}

//显示每一行的数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
    News_NS *item=self.dataArr[indexPath.row];
    
    
    cell.Title.text = item.Title;
    
//    NSRange range = [item.Edittime rangeOfString:@"T"];
//    NSString *Edittime = [item.Edittime substringToIndex:range.location];
    cell.Edittime.text = item.Edittime;
    
    cell.Lable.text = item.Lable;
    [cell.FirstPics sd_setImageWithURL:[NSURL URLWithString:item.FirstPics]placeholderImage:[UIImage imageNamed:@"nopic.png"]];
    
    
    
    
    
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.f;
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
    news_list_h5_ViewController * vc = [news_list_h5_ViewController alloc];
              vc.hidesBottomBarWhenPushed =YES;//PUB到news_list_h5_ViewController.m隐藏tabBar（底部导航）
               News_NS *item=self.dataArr[indexPath.row];
               vc.news_id = item.id  ;//传值到WEB页面
      [self.navigationController pushViewController:vc animated:YES];
    
    
}





@end
