//
//  Topbar_conter_ViewController.m
//  topbar
//
//  Created by topbar on 2019/11/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "Topbar_conter_ViewController.h"
#import "OtherA_web_ViewController.h"

@interface Topbar_conter_ViewController ()

@end

@implementation Topbar_conter_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self jsonParse];//如果不添加重新请求（网址）JSON，数据不会随时下拉刷新
   //先请求数据后，再加载页面
   dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
   dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                       
        [self share];
       
    });

}
-(void)share{
    
      

         // self.view.backgroundColor = [UIColor grayColor];
         //_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height-120)style:UITableViewStyleGrouped];
    //     [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];

        //_tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth, ScreenHeight-146) style:UITableViewStyleGrouped];
           
         /*改变 UITableViewStyleGrouped 样式的 背景色 */
        _tableView.backgroundView = [[UIView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        
          //----隐藏滚动条
        self.tableView.showsVerticalScrollIndicator = NO;
        //不要忘写了这两句话哟调用delegate*/
        _tableView.delegate =self;
        _tableView.dataSource=self;
        

        //self.view = _tableView;
        [self.view addSubview:_tableView];
        
        [self getData];

         dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
         dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
             // Do something...
              //事件
         [self Mssages];
             
        
          });
      
        [self begin];

        
        //初始化Socket
        _Sock_keys = [[NSMutableArray alloc]init];
        _sock_last = [[NSMutableArray alloc]init];
        _sock_high = [[NSMutableArray alloc]init];
        _sock_low = [[NSMutableArray alloc]init];
        _sock_vol = [[NSMutableArray alloc]init];
}


//获取到服务器数据后创建websocket
- (void)getData{
    //webscoket链接
    _webSocket = [[WebSocketManager alloc] init];
  
    [_webSocket WithIP:APIURL_Websock];
    _webSocket.delegate = self;
    [_webSocket openSocket];
  
   

  
}
#pragma mark 一一WebSocket协议方法一一一一一一一一一一一一一一一一一一一一一一一一一一一一
- (void)getMessageFromSocket:(NSDictionary *)message {
   
    
    
    //   返回模型数据
    //    {
    //        channel = "btcusdt_ticker";
    //        dataType = ticker;
    //        date = 1574923522164;
    //        ticker =     {
    //            buy = "7484.9";
    //            high = "7651.44";
    //            last = "7486.0";
    //            low = "6852.0";
    //            sell = "7486.0";
    //            vol = "17317.0279";
    //        };
    //    }
    


        //过滤字符“_ticker”
        NSString * channel  = [message objectForKey:@"channel"];
        //NSString * W_channel = [channel substringToIndex:7];
        NSString * W_channel = [channel stringByReplacingOccurrencesOfString:@"_ticker" withString:@""];
     
   
        NSArray * ticker = [message objectForKey:@"ticker"];
        NSString * last =[NSString stringWithFormat:@"%@", [ticker valueForKey:@"last"]];
        NSString * high =[NSString stringWithFormat:@"%@", [ticker valueForKey:@"high"]];
        NSString * low =[NSString stringWithFormat:@"%@",  [ticker valueForKey:@"low"]];
        NSString * vol =[NSString stringWithFormat:@"%@",  [ticker valueForKey:@"vol"]];

        //重建字典
       // NSDictionary * vv =  @{@"name":AA1,@"last":CC};
        //NSDictionary * JJ  = @{AA1:vv};
        //转换数组
       // NSArray * qq = [JJ objectForKey:AA1];
       
       // for (int i = 0; i<qq.count; i++)

       // {
            
      // NSString *uu =[NSString stringWithFormat:@"%@", [qq valueForKey:@"name"]];
      // NSString *ii = [NSString stringWithFormat:@"%@ ",[qq valueForKey:@"last"]];
       [_Sock_keys addObject:W_channel];
       [_sock_last addObject:last];
       [_sock_high addObject:high];
       [_sock_low addObject:low];
       [_sock_vol addObject:vol];


            
       // }
 
       //NSLog(@"%@",message);

       dispatch_async(dispatch_get_main_queue(), ^{
         
       [self.tableView reloadData];
    
        
        });
                                                                                             

    
}
-(void)Mssages
{
    
      [_webSocket sendTalkMessage:@"topbar"];//假数据，定要调用
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{
 //    NSLog(@"%@",_type);
 //     NSLog(@"%@",_titlea);
    NSString *api_url = [NSString stringWithFormat:@"data/v1/allTicker"];
    
//   返回模型数据 {"topcqc":{"high":"0.049479","vol":"14606861.2","last":"0.042008","low":"0.038729","buy":"0.042008","sell":"0.042346"},"eosbtc":{"high":"0.0003822","vol":"613568.38","last":"0.00037277","low":"0.00036674","buy":"0.00037308","sell":"0.00037309"}}
    
    
    
    NSString *Get_Url_String =[APIURL_HC stringByAppendingString:api_url];
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
                                            
                                          
                                            NSArray* reversedArray = [dic allKeys];
                                            NSArray *Tkeys =[[reversedArray reverseObjectEnumerator] allObjects];//倒序
                                            //NSArray *Tvalues = [dic allValues];
                                            
                                            // 0自选 1QC 2USDT 3BTC 4ZB
//                                            if ([self->_type isEqualToString:@"0"]) {
//                                            //需要保留的元素数组
//                                            self->_SaveData = [[NSMutableArray alloc]initWithObjects:@"btcusdt",@"ethusdt",@"xrpusdt", nil];
//                                            }
                                            if ([self->_type isEqualToString:@"1"]) {
                                                 //需要保留的元素数组
                                                self->_SaveData = [[NSMutableArray alloc]initWithObjects:@"btcqc",@"ethqc",@"xrpqc",@"zbqc",@"eosqc",@"xlmqc",@"ltcqc",@"adaqc",@"etcqc",@"xemqc",@"omgqc",@"zrxqc",@"btsqc",@"icxqc", nil];
                                            }
                                            if ([self->_type isEqualToString:@"2"]) {
                                                 //需要保留的元素数组
                                                self->_SaveData = [[NSMutableArray alloc]initWithObjects:@"btcusdt",@"ethusdt",@"xrpusdt",@"zbusdt",@"eosusdt",@"xlmusdt",@"ltcusdt",@"adausdt",@"etcusdt",@"xemusdt",@"omgusdt",@"zrxusdt",@"btsusdt",@"icxusdt", nil];
                                            }
                                            if ([self->_type isEqualToString:@"3"]) {
                                                 //需要保留的元素数组
                                                self->_SaveData = [[NSMutableArray alloc]initWithObjects:@"ethbtc",@"xrpbtc",@"eosbtc",@"zbbtc",@"neobtc",@"xlmbtc",@"ltcbtc",@"adabtc",@"etcbtc",@"batbtc",@"omgbtc",@"zrxbtc",@"btsbtc",@"icxbtc",  nil];
                                            }
//                                            if ([self->_type isEqualToString:@"4"]) {
//                                                 //需要保留的元素数组
//                                                self->_SaveData = [[NSMutableArray alloc]initWithObjects:@"vsyszb",@"xrpbtc",@"eosbtc", nil];
//                                            }
                                           
                                            
                                           
                                            //过滤清除不需要的元素
                                            //NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"( NOT SELF IN %@)",filteredArray];
                                            NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"(SELF IN %@)",self->_SaveData];
                                            //过滤数组
                                            NSArray * reslutFilteredArray = [Tkeys filteredArrayUsingPredicate:filterPredicate];
                                            //NSLog(@"Reslut Filtered Array = %@",reslutFilteredArray);
                                                                         
                                   
                                            //初始化
                                            self->_Tkeys = [[NSMutableArray alloc]init];//货币名称
                                            self->_Tkeys_con = [[NSMutableArray alloc]init];//货币里的参数
                                            for (int i = 0; i<reslutFilteredArray.count; i++)
                                                
                                               {
                                                 NSString *key = [NSString stringWithFormat:@"%@", reslutFilteredArray [i]];
                                                 NSString *object = dic[key];
                                                   
                                                 [self->_Tkeys addObject:key];
                                                 [self->_Tkeys_con addObject:object];
                                                 //NSLog(@"%@",self->_Tkeys);
                                                


                                                }
                                      
                                            
                                            //将数组中的字典数据都转换成模型
                                            self.dataArr=[HC_News_NS mj_objectArrayWithKeyValuesArray:self->_Tkeys_con];
                                            //由于NSURLSession处理任务的操作默认都是在子线程中进行的，而像刷新数据设置图片这种操作必须在主线程中进行，因此必须进行线程间的通信，转到主队列，执行UI操作
                                            // NSLog(@" dataarr==%@",self->_dataArr);
                                            //NSLog(@"array==%@",self->_Tkeys_con);
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
    self.tableView.mj_header = header;
    

}
#pragma mark 下拉刷新数据
- (void)loadNewData
{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //结束上拉刷新
        [self.tableView.mj_header endRefreshing];

        
        
        [self jsonParse];//如果不添加重新请求（网址）JSON，数据不会随时下拉刷新
        

        
        //第一次下拉时，刷新出3条数据，同时刷新上拉为还有更多字眼出现
         [self.tableView.mj_footer endRefreshing];
        // [self Mssages];
        
            });

    
}




-(NSArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}



//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//
//
//}


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
    HC_News_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //启动重用机制
      if (cell == nil) {
    cell = [[HC_News_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
      }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//     if ([self->_type isEqualToString:@"0"]) {
//         NSString *Achannel = [[_Tkeys objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"usdt" withString:@"" ];
//         NSString * channel = [Achannel uppercaseString];
//         cell.keys.text = [NSString stringWithFormat:@"%@",channel ];
//         cell.keys_lable.text = [NSString stringWithFormat:@"%@",@"/ USDT" ];
//
//     }
    
    if ([self->_type isEqualToString:@"1"]) {
         NSString *Achannel = [[_Tkeys objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"qc" withString:@"" ];
         NSString * channel = [Achannel uppercaseString];
         cell.keys.text = [NSString stringWithFormat:@"%@",channel ];
         cell.keys_lable.text = [NSString stringWithFormat:@"%@",@"/ QC" ];
        
    }
    
    if ([self->_type isEqualToString:@"2"]) {
         NSString *Achannel = [[_Tkeys objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"usdt" withString:@"" ];
         NSString * channel = [Achannel uppercaseString];
         cell.keys.text = [NSString stringWithFormat:@"%@",channel ];
         cell.keys_lable.text = [NSString stringWithFormat:@"%@",@"/ USDT" ];
    }
    
    if ([self->_type isEqualToString:@"3"]) {
         NSString *Achannel = [[_Tkeys objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"btc" withString:@"" ];
         NSString * channel = [Achannel uppercaseString];
         cell.keys.text = [NSString stringWithFormat:@"%@",channel ];
         cell.keys_lable.text = [NSString stringWithFormat:@"%@",@"/ BTC" ];
    }
    
//    if ([self->_type isEqualToString:@"4"]) {
//         NSString *Achannel = [[_Tkeys objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"zb" withString:@"" ];
//         NSString * channel = [Achannel uppercaseString];
//         cell.keys.text = [NSString stringWithFormat:@"%@",channel ];
//         cell.keys_lable.text = [NSString stringWithFormat:@"%@",@"/ ZB" ];
//    }


    
    // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
    HC_News_NS *item=self.dataArr[indexPath.row];

    cell.last.text = item.last;
    cell.high.text = item.high;
    cell.low.text = item.low;
    cell.meny.text = [NSString stringWithFormat:@"%@%@",@"$",item.last];
    CGFloat tFloat = (CGFloat)([item.vol floatValue])/10000;
    cell.vol.text = [NSString stringWithFormat:@"%.3f%@",tFloat,@"万"];
    //cell.vol.text = item.vol;


    
    for (int i = 0; i < _Sock_keys.count; i++) {
                   
                   if ([_Sock_keys[i] isEqualToString:[_Tkeys objectAtIndex:indexPath.row]]) {
                                             
                           // 24小时涨幅百份比 =（当前最新价-24小时前的价格)/24小时前的价格*100%
                           CGFloat LOHI = (CGFloat) (([_sock_high[i] floatValue])+([_sock_low[i] floatValue]))/2;
                           CGFloat tFloat = (CGFloat)(([_sock_last[i] floatValue])-LOHI)/LOHI*100;
                           //CGFloat tFloat = (CGFloat)(aa-bb)/bb*100;
                           //NSLog(@"%f",tFloat);
                           NSString *outlast = [NSString stringWithFormat:@"%.2f%@",tFloat,@"%"];
                                                 if (tFloat >= 0 ) {
                                                     cell.Upsdowns.text =[NSString stringWithFormat:@"%@%@",@"+",outlast] ;
                                                     cell.Upsdowns.textColor = [UIColor redColor];
                                                     //NSLog(@"%f",tFloat );
                         
                                                 } else {
                                                      cell.Upsdowns.text =outlast ;
                                                      cell.Upsdowns.textColor = [UIColor colorWithRed:77.0/255 green:179.0/255 blue:118.0/255 alpha:1];
                                                      //NSLog(@"%f",tFloat );
                                                 }
                  
                       
                        cell.last.text = [NSString stringWithFormat:@"%@", _sock_last[i]];
                        cell.high.text = [NSString stringWithFormat:@"%@", _sock_high[i]];
                        cell.low.text =  [NSString stringWithFormat:@"%@", _sock_low[i]];
                        CGFloat AtFloat = (CGFloat)([_sock_vol[i] floatValue])/10000;
                        cell.vol.text = [NSString stringWithFormat:@"%.3f%@",AtFloat,@"万"];
                        //cell.vol.text =  [NSString stringWithFormat:@"%@", _sock_vol[i]];
                        cell.meny.text = [NSString stringWithFormat:@"%@%@",@"$",_sock_last[i]];
             
                     
                       
                       
                   }
        
    }
    
    //NSLog(@"%lu",(unsigned long)_Sock_keys.count);

    
    
//         if ([[_Tkeys objectAtIndex:indexPath.row] isEqualToString:@"btcusdt"]) {
//             cell.last.text = _Web_tkey_last;
//             cell.last.textColor = [UIColor orangeColor];
//             cell.high.text = _Web_tkey_high;
//             cell.low.text = _Web_tkey_low;
//             cell.vol.text = _Web_tkey_vol;
//         }
    


    
    //UITableView去掉自带系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //自定义分割线
    UIView * VC1 = [[UIView alloc]initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, 1)];
    VC1.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [cell.contentView addSubview:VC1];
    
   
    return cell;
     
    
}
////顶部距离
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//
//    return 44.f;//配合“  _tableV.sectionHeaderHeight = 0;”才生效
//}

////脚视图高度
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10.0f;
//
//}
//iOS 11 TableView heightForFooter 设置Header高度无效解决方法
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //------TableView顶间距
    tableView.sectionHeaderHeight = 1;
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//行间距离（108）
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
    //取消选中后的蓝色背景
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
       //随机数及数组随机取元素
//       NSArray *array = [[NSArray alloc] initWithObjects:@"btc_usdt",@"eth_usdt",@"ht_usdt",@"xrp_usdt",@"ltc_usdt",@"ltc_usdt",@"bch_usdt",@"eos_usdt",@"etc_usdt",@"bsv_usdt",@"trx_usdt",@"zec_usdt",@"dash_usdt",@"ada_usdt",@"xmr_usdt",@"link_usdt",@"mx_usdt",@"ont_usdt",nil];
//       NSMutableSet *randomSet = [[NSMutableSet alloc] init];
//
//       while ([randomSet count] < 1) {
//           int r = arc4random() % [array count];
//           [randomSet addObject:[array objectAtIndex:r]];
//       }
//
//       NSArray *randomArray = [randomSet allObjects];
//       _Key_BTC = [randomArray componentsJoinedByString:@","];
       //NSLog(@"%@",_Key_BTC);

    
          if ([self->_type isEqualToString:@"1"] ) {
        
                    //取值并且拼接
                    NSString *Achannel = [[_Tkeys objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"qc" withString:@"" ];
                    NSString *AL = [Achannel uppercaseString];
                    //大写转小写
                    NSString *Name = [AL lowercaseStringWithLocale:[NSLocale currentLocale]];
                    _Key_BTC=[NSString stringWithFormat:@"%@_usdt",Name];
         }
        
         if ([self->_type isEqualToString:@"2"] ) {
             
                    //取值并且拼接
                    NSString *Achannel = [[_Tkeys objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"usdt" withString:@"" ];
                    NSString *AL = [Achannel uppercaseString];
                    //大写转小写
                    NSString *Name = [AL lowercaseStringWithLocale:[NSLocale currentLocale]];
                    _Key_BTC=[NSString stringWithFormat:@"%@_usdt",Name];
         }
         if ([self->_type isEqualToString:@"3"]) {
        
                    //取值并且拼接
                    NSString *Achannel = [[_Tkeys objectAtIndex:indexPath.row]  stringByReplacingOccurrencesOfString:@"btc" withString:@"" ];
                    NSString *AL = [Achannel uppercaseString];
                    //大写转小写
                    NSString *Name = [AL lowercaseStringWithLocale:[NSLocale currentLocale]];
                    _Key_BTC=[NSString stringWithFormat:@"%@_btc",Name];
          }
    
       
        
        //取消选中后的蓝色背景
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        OtherA_web_ViewController *vc =[[OtherA_web_ViewController alloc]init];
        vc.news_Title = @"K线行情";
        //vc.news_url = @"https://m.huobi.me/zh-cn/market/";
        //vc.news_url = @"https://m.huobi.me/zh-cn/market/chart/?s=btc_usdt";
        vc.news_url = [NSString stringWithFormat:@"https://m.huobi.me/zh-cn/market/chart/?s=%@",_Key_BTC];
        //NSLog(@"%@",vc.news_url);
        [self.navigationController pushViewController:vc animated:YES];
    
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//
//      //NSLog(@"1");
//      //反回时顶部加一张白色背景图
//      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BgmBC"] forBarMetrics:UIBarMetricsDefault];
//
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//
//    //NSLog(@"2");
//
//    //反回时顶部加一张白色背景图
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BgmBC"] forBarMetrics:UIBarMetricsDefault];
//
//}
////计价方式返回用到调用
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:YES];
//
//   NSLog(@"3");
//    //反回时顶部加一张白色背景图
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BgmBC"] forBarMetrics:UIBarMetricsDefault];
//
//
//
//
//}
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:YES];
//
//    NSLog(@"4");
//    //反回时顶部加一张白色背景图
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BgmBC"] forBarMetrics:UIBarMetricsDefault];
//
//}
@end
