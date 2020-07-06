//
//  Order_ViewController.m
//  topbar
//
//  Created by topbar on 2019/11/14.
//  Copyright © 2019 guo feng zou. All rights reserved.
//订单

#import "Order_ViewController.h"
#import "Order_details_ViewController.h"

@interface Order_ViewController ()

@end

@implementation Order_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     //设置导航控制器的代理(隐藏顶部-nav)
     self.navigationController.delegate = self;
    
     _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
  
    /*改变 UITableViewStyleGrouped 样式的 背景色 */
     _tableView.backgroundView = [[UIView alloc]init];
     _tableView.backgroundColor = [UIColor clearColor];
    
    
    //不要忘写了这两句话哟调用delegate*/
    _tableView.delegate =self;
    _tableView.dataSource=self;
    //隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //NSLog(@"%@",_titlea);
    //NSLog(@"%@",_type);
    
    UIView *viewA = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.001)];
    self.tableView.tableHeaderView = viewA;
    
    
    //取沙盒用户信息
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    _username = [dic objectForKey:@"username"];


 
    
  
    //[self.view addSubview:_tableView];
    self.view = _tableView;
    currentPage = 1;//初始化
    [self begin];

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{

    
        //创建session对象
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *UserApi=APIURL_USER;
           
        NSURL *url = [NSURL URLWithString:UserApi];
       // NSString * Urladd =[NSString stringWithFormat:@"action=order&Pagesums=1&type=0&Currency=%@",_titlea];
    
        NSString * Urladd =[NSString stringWithFormat:@"action=order_list&Pagesums=1&username=%@&type=%@",_username,_type];
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
              // NSLog(@"aaa==%@",dic);
                // [self CheckNet];

               NSMutableArray * array = [dic objectForKey:@"Megss"];
               //NSLog(@"%@",array);
 
                 
                 
               //将数组中的字典数据都转换成模型
               self.dataArr=[News_NS mj_objectArrayWithKeyValuesArray:array];
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



////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)jsonParse_more{

    //创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *UserApi=APIURL_USER;
       
    NSURL *url = [NSURL URLWithString:UserApi];
    NSString * Urladd =[NSString stringWithFormat:@"action=order_list&Pagesums=%ld&username=%@&type=%@",(long)currentPage,_username,_type];
    //NSLog(@"dd==%@",Urladd);
 
       
         
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
          // NSLog(@"bbb==%@",dic);
           NSMutableArray * array = [dic objectForKey:@"Megss"];

             
             //将数组中的字典数据都转换成模型
             //
             
             NSArray *dataArrB = [News_NS mj_objectArrayWithKeyValuesArray:array];
             [self.dataArr addObjectsFromArray:dataArrB];
             //NSLog(@"%@",array);
             
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
    
   // NSLog(@"1");
    
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
      [tableView tableViewDisplayWitMsg:@"你还没有订单信息 ^-^" ifNecessaryForRowCount:self.dataArr.count];
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
    order_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    cell = [[order_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色
    
    
    
    // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
    News_NS *item=self.dataArr[indexPath.row];
    
    
    if ([item.buy_sale_type isEqualToString:@"0"]) {
        cell.buy_sale_type.text = @"购买";
    }else{
        cell.buy_sale_type.text = @"出售";
    }
    
    cell.back.image = [UIImage imageNamed:@"app_back_btn_F"];
    if ([item.type isEqualToString:@"0"]) {
       // cell.type.text = @"已撤销";
        //创建富文本
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: @" 已撤销"];
        //NSTextAttachment可以将要插入的图片作为特殊字符处理
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        //定义图片内容及位置和大小
        attch.image = [UIImage imageNamed:@"red"];
        attch.bounds = CGRectMake(0, 2, 7, 7);
        //创建带有图片的富文本
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        //将图片放在最后一位
        //[attri appendAttributedString:string];
        //将图片放在第一位
        [attri insertAttributedString:string atIndex:0];
        //用label的attributedText属性来使用富文本
        cell.type.attributedText = attri;
    } else {
        //cell.type.text = @"已成交";
        //创建富文本
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: @" 已成交"];
        //NSTextAttachment可以将要插入的图片作为特殊字符处理
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        //定义图片内容及位置和大小
        attch.image = [UIImage imageNamed:@"bluer"];
        attch.bounds = CGRectMake(0, 2, 7, 7);
        //创建带有图片的富文本
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        //将图片放在最后一位
        //[attri appendAttributedString:string];
        //将图片放在第一位
        [attri insertAttributedString:string atIndex:0];
        //用label的attributedText属性来使用富文本
        cell.type.attributedText = attri;
    }

    //用于格式化NSDate对象
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];

    //NSString转NSDate
    NSDate *date=[formatter dateFromString:item.date];
    [formatter setDateFormat:@"HH:mm MM/dd"];

    //NSDate转NSString
    NSString *DateString=[formatter stringFromDate:date];
    cell.date.text = DateString;
    
    cell.vol.text = item.vol;
    cell.total.text = item.total;
    cell.m_anther.text = item.m_anther;
    cell.btc_type.text = item.btc_type;
    cell.volA.text =  [NSString stringWithFormat:@"数量(%@)",item.btc_type];
    

    
    
    //UITableView去掉自带系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 自定义分割线
    // UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 10)];
    // VC.backgroundColor = RGBA(245,245,245,1);
    // [cell.contentView addSubview:VC];
    UIView * VC1 = [[UIView alloc]initWithFrame:CGRectMake(0, 119, self.view.frame.size.width, 1)];
    VC1.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [cell.contentView addSubview:VC1];
    
    
    
    return cell;
    

    
}
////顶部距离
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

    return 120;
}
////// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击事件
    Order_details_ViewController * vc  =[[Order_details_ViewController alloc]init];
    News_NS *item=self.dataArr[indexPath.row];
    vc.pri = item.pri;
    vc.vol = item.vol;
    vc.total = item.total;
    vc.pay_type = item.pay_type;
    vc.pay_name = item.pay_name;
    vc.pay_num  = item.pay_num;
    vc.m_anther = item.m_anther;
    vc.m_name = item.m_name;
    vc.order_num = item.order_num;
    vc.btc_type =item.btc_type;
    vc.date  =item.date;
    vc.type = item.type;
    [self.navigationController pushViewController:vc animated:YES];
   
}


@end
