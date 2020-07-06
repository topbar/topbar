//
//  RecommendViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/2/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "RecommendViewController.h"
#import "OtherA_web_ViewController.h"

@interface RecommendViewController ()

@end

@implementation RecommendViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self jsonParse];
   
        //先请求数据后，再加载页面
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC);//数字为时间延时
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        
                            [self Share];
        
     });
}

-(void)Share
{
    

      
      // 设置窗口大小
     _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
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
      
 
 
 

}
- (void)jsonParse{
 //    NSLog(@"%@",_type);
 //     NSLog(@"%@",_titlea);
    NSString *api_url = [NSString stringWithFormat:@"public/v1/ticker?start=11&limit=10&convert=cny"];
  

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
                                            
                                            //写入沙盒
                                             NSArray *array_L = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                             NSString *documents = [array_L lastObject];
                                             NSString *documnetPath = [documents stringByAppendingPathComponent:@"feixiaohao_1.plist"];
                                             NSArray *dic_notice = [NSArray mj_keyValuesArrayWithObjectArray:self->_dataArr ];
                                             // NSLog(@"%@",dic_notice);
                                             [dic_notice writeToFile:documnetPath atomically:YES];
                                            
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
    
    //读取沙盒数据
     NSArray *array_L = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documents = [array_L lastObject];
     NSString *documnetPath = [documents stringByAppendingPathComponent:@"feixiaohao_1.plist"];
     NSArray *resultArray = [NSArray arrayWithContentsOfFile:documnetPath];
     self.dataArr=[Global_News_NS mj_objectArrayWithKeyValuesArray:resultArray];
    
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
     [_tableV tableViewDisplayWitMsg:@"网络不给力哟 ^-^" ifNecessaryForRowCount:self.dataArr.count];
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
    self.tableV.scrollEnabled = NO;

 //@property (nonatomic,retain)  UILabel * symbol;   //货币名称
 //@property (nonatomic,retain)  UILabel * logo; //
 //@property (nonatomic,retain)  UILabel * market_cap_usd;   //流通市值（单位：美元）
 //@property (nonatomic,retain)  UILabel * price_usd;  //实时价/最新成交价/美金价
 //@property (nonatomic,retain)  UILabel * price_btc;  //实时价/BTC价格
 //@property (nonatomic,retain)  UILabel * percent_change_24h; //24小时涨跌幅

    
    // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
    Global_News_NS *item=self.dataArr[indexPath.row];
    
    cell.symbol.text = item.symbol;
    _Key_BTC=item.symbol;
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
//
//       NSLog(@"%@",_Key_BTC);

         //取值并且拼接
        Global_News_NS *item=self.dataArr[indexPath.row];
         //大写转小写
        NSString *Name = [item.symbol lowercaseStringWithLocale:[NSLocale currentLocale]];
        _Key_BTC=[NSString stringWithFormat:@"%@_usdt",Name];
        
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

@end
