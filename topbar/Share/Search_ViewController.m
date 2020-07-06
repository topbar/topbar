//
//  Search_ViewController.m
//  topbar
//
//  Created by topbar on 2019/10/9.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "Search_ViewController.h"
#import "news_list_h5_ViewController.h"

@interface Search_ViewController ()<UISceneDelegate>

@end

@implementation Search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
    UIImage *leftImage = [[UIImage imageNamed:@"app_back_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftButton_top  = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(left:)];
    self.navigationItem.leftBarButtonItem = leftButton_top;
    //右滑手势解决z
     self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    
    UIImage *rightImage = [[UIImage imageNamed:@"share@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
      UIBarButtonItem * rightButton_top  = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(searchbtn)];
      self.navigationItem.rightBarButtonItem = rightButton_top;
    
    //点击空白处隐藏键盘
      UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
      tapGestureRecognizer.cancelsTouchesInView = NO;
      [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
   
    
    [self secach];
   // [self seacher];
     [self conter];
   
}
-(void)conter
{
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
      
       /*改变 UITableViewStyleGrouped 样式的 背景色 */
        // _tableView.backgroundView = [[UIView alloc]init];
         //_tableView.backgroundColor = [UIColor clearColor];
        
        //不要忘写了这两句话哟调用delegate*/
        _tableView.delegate =self;
        _tableView.dataSource=self;
        
        UIView *viewA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.001)];
        self.tableView.tableHeaderView = viewA;
        
        
      
      //  [self.view addSubview:_tableView];
        self.view = _tableView;

        currentPage = 1;//初始化
        // //显示沙盒路径
    //            NSArray * pathsa =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //            NSLog(@"沙盒路径:%@",pathsa);
        
        //  [self jsonParse];
       
      //  [self begin];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{
    
  //  NSLog(@"%@",_type);
  /// NSLog(@"%@",_titlea);
 
   NSString *api_url = [NSString stringWithFormat:@"search_app.PHP?Pagesums=1&key=%@",_searchBar.text];
  _Get_Url_StringaA =[APIURL stringByAppendingString:api_url];
    
    
  //  _Get_Url_StringaA = [NSString stringWithFormat:@"http://192.168.14.109/website/admin/search_app.PHP?Pagesums=1&key=%@",_searchBar.text];
   
    
    
    
    NSString * Get_Url_String = [_Get_Url_StringaA stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    /***
    stringByAddingPercentEncodingWithAllowedCharacters 对字符串进行编码
      URLFragmentAllowedCharacterSet                                "#%<>[\]^`{|}
      URLHostAllowedCharacterSet                                    "#%/<>?@\^`{|}
      URLPasswordAllowedCharacterSet                                "#%/:<>?@[\]^`{|}
      URLPathAllowedCharacterSet                                    "#%;<>?[\]^`{|}
      URLQueryAllowedCharacterSet                                   "#%<>[\]^`{|}
      URLUserAllowedCharacterSet                                    "#%/:<>?@[\]^`
    ***/
                            
    // NSString *Get_Url_String = [NSString stringWithFormat:@"http://103.75.3.66:6006/Handlershuju.ashx?act=Zuqiu&Zlqlxs=1"];
   // NSLog(@"====%ld",(long)currentPage);
//    NSLog(@"%@",_type);
//      NSLog(@"%@",_titlea);
 //  NSLog(@"搜索第一次刷新=%@",Get_Url_String);
 
    
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
                                            
                                            
                                            
                                            //将数组中的字典数据都转换成模型
                                            self.dataArr=[News_NS mj_objectArrayWithKeyValuesArray:array];
                                            //下拉刷新如果需要保持现有的数据，则需要调用如下。同时JSON服务器也要将修改为随机数据
//                                            NSArray *dataArrB = [News_NS mj_objectArrayWithKeyValuesArray:array];
//                                              [self.dataArr addObjectsFromArray:dataArrB];
                                            
                                            //由于NSURLSession处理任务的操作默认都是在子线程中进行的，而像刷新数据设置图片这种操作必须在主线程中进行，因此必须进行线程间的通信，转到主队列，执行UI操作
                                          // NSLog(@"%@",array);
                                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                [self.tableView reloadData];
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
    
    
    
     NSString *api_url = [NSString stringWithFormat:@"search_app.PHP?Pagesums=%ld&key=%@",(long)currentPage,_searchBar.text];
    NSString *Get_Url_StringA =[APIURL stringByAppendingString:api_url];
    
//NSString *Get_Url_StringA = [NSString stringWithFormat:@"http://192.168.14.109/website/admin/search_app.PHP?Pagesums=%ld&key=%@",(long)currentPage,_searchBar.text];
    
    NSString * Get_Url_String = [Get_Url_StringA stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
       /***
       stringByAddingPercentEncodingWithAllowedCharacters 对字符串进行编码
         URLFragmentAllowedCharacterSet                                "#%<>[\]^`{|}
         URLHostAllowedCharacterSet                                    "#%/<>?@\^`{|}
         URLPasswordAllowedCharacterSet                                "#%/:<>?@[\]^`{|}
         URLPathAllowedCharacterSet                                    "#%;<>?[\]^`{|}
         URLQueryAllowedCharacterSet                                   "#%<>[\]^`{|}
         URLUserAllowedCharacterSet                                    "#%/:<>?@[\]^`
       ***/
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
                                           //  NSLog(@"%@",array);
                                            
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
    
    // 拿到当前的上拉刷新控件，结束刷新状态
  //  [self.tableView.mj_footer endRefreshing];
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
            vc.hidesBottomBarWhenPushed =YES;//Push到news_list_h5_ViewController.m隐藏tabBar（底部导航）
  
    
            News_NS *item=self.dataArr[indexPath.row];
            vc.news_id = item.id  ;//传值到WEB页面
         //   NSLog(@"%@",item.id);
    
            [self.navigationController pushViewController:vc animated:YES];

    
    
}


-(void)seacher
{
    
//
    CGRect mainViewBounds = self.navigationController.view.bounds;
     _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+22, CGRectGetWidth(mainViewBounds)-120, 40)];

     _searchBar.delegate = self;
     _searchBar.showsCancelButton = NO;
     _searchBar.searchBarStyle = UISearchBarStyleMinimal;
  //  [self.navigationController.view addSubview: _searchBar];
  self.navigationItem.titleView = _searchBar;

}




-(void)secach
{
    

        UIView*titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-120, 30)];
        //UIColor *color =  self.navigationController.navigationBar.tintColor;

        //[titleView setBackgroundColor:color];
         _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-120, 30)];
   
     

        _searchBar.placeholder = @"请输入关键字！";
    
    
  
     

        _searchBar.layer.cornerRadius = 15;

        _searchBar.layer.masksToBounds = YES;

        //设置背景图是为了去掉上下黑线

        _searchBar.backgroundImage = [[UIImage alloc] init];

        //self.searchBar.backgroundImage = [UIImage imageNamed:@"sexBankgroundImage"];

        // 设置SearchBar的主题颜色

        _searchBar.barTintColor = [UIColor colorWithRed:111/255.0f green:212/255.0f blue:163/255.0f alpha:1];

        //设置背景色

        _searchBar.backgroundColor = [UIColor colorWithRed:204/255.0f green:204/255.0f blue:0/255.0f alpha:0.1];

        // 修改cancel

       _searchBar.showsCancelButton=NO;

       _searchBar.barStyle=UIBarStyleDefault;

       _searchBar.keyboardType=UIKeyboardTypeNamePhonePad;

        _searchBar.searchBarStyle = UISearchBarStyleProminent;;//没有背影，透明样式

        _searchBar.delegate=self;



        // 修改cancelUISearchBarDelegate

        _searchBar.showsSearchResultsButton=YES;
    
    //搜索栏的附件选择按钮视图
//    _searchBar.showsScopeBar = YES;
//    _searchBar.scopeButtonTitles = @[@"One", @"Two", @"Three"];
//    _searchBar.selectedScopeButtonIndex = 1;
  

        //5. 设置搜索Icon

        [_searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
      


        [titleView addSubview:_searchBar];
        self.navigationItem.titleView = titleView;

  
    
}
- (void)left:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
   
}

- (void)searchbtn{

//NSString *search_text=_searchBar.text;
//    NSLog(@"%@",search_text);
       [self begin];

}


//键盘上的搜索按钮点击的会调用该方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    
    //隐藏键盘（指键盘上的搜索按钮）
[searchBar resignFirstResponder]; //searchBar失去焦点

    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn

    cancelBtn.enabled = YES; //把enabled设置为yes
    
    //事件
//       NSString *search_text=_searchBar.text;
//       NSLog(@"%@",search_text);
    [self begin];
  

}
//点击空白处隐藏键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_searchBar resignFirstResponder];
 
}

@end
