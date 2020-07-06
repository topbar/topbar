//
//  Default_conter_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/3.
//  Copyright © 2020 guo feng zou. All rights reserved.
//  暂无用到

#import "Default_conter_ViewController.h"

@interface Default_conter_ViewController ()

@end

@implementation Default_conter_ViewController

- (void)viewDidLoad {
     [super viewDidLoad];
        //执行一次刷新
        [self jsonParse];//如果不添加重新请求（网址）JSON，数据不会随时下拉刷新

         // self.view.backgroundColor = [UIColor grayColor];
         //_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height-120)style:UITableViewStyleGrouped];
    //     [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];

        //_tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];

        
           
         /*改变 UITableViewStyleGrouped 样式的 背景色 */
        _tableView.backgroundView = [[UIView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        
        //不要忘写了这两句话哟调用delegate*/
        _tableView.delegate =self;
        _tableView.dataSource=self;
        

        //self.view = _tableView;
        [self.view addSubview:_tableView];

   

       

    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    - (void)jsonParse{
     //    NSLog(@"%@",_type);
     //     NSLog(@"%@",_titlea);
        NSString *api_url = [NSString stringWithFormat:@"public/v1/ticker?limit=7&convert=cny"];
      

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
                                                 [self.tableView reloadData];
                                                    
                                                    // 拿到当前的下拉刷新控件，结束刷新状态
                                                // [self.tableView.mj_header endRefreshing];
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
        
       // self.tableView.mj_footer.hidden = (self.dataArr.count == 0);
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

        
        
    }

@end
