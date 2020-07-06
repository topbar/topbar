//
//  Hy_goumai_con_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/11.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Hy_goumai_con_ViewController.h"
#import "Add_root_ViewController.h"
#import "Hy_order_ViewController.h"
#import "Login_ViewController.h"
#import "Login_PresentationController.h"
#import "Order_sale_ViewController.h"
#import "Hy_root_ViewController.h"

@interface Hy_goumai_con_ViewController ()

@end

@implementation Hy_goumai_con_ViewController

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
    
    [self jsonParse];
    
    [self begin];
 




}




////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)jsonParse{

    
        //创建session对象
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *UserApi=APIURL_USDT;
           
        NSURL *url = [NSURL URLWithString:UserApi];
        NSString * Urladd =[NSString stringWithFormat:@"action=goumai&Pagesums=1&type=0&Currency=%@",_titlea];
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
               //NSLog(@"aaa==%@",dic);
                // [self CheckNet];

               NSMutableArray * array = [dic objectForKey:@"Megss"];
               //NSLog(@"%@",array);
                 
                 //if (dic == (NULL))
//                 if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
//                               //主线程
//                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                         self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//                         //self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                         self->HUD.label.text = @"数据加载成功";
//                         //self->HUD.minSize = CGSizeMake(100, 10);
//                         self->HUD.offset = CGPointMake(0, -300);
//                         self->HUD.contentColor = [UIColor blackColor];
//                         self->HUD.bezelView.backgroundColor = [UIColor whiteColor];
//                         self->HUD.minShowTime= 0.5;/*指示器停留的时间/以秒为做单位*/
//                         [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//
//                         return;
//
//
//                     });
//                 } else {
//                               //主线程
//                     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
//                     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                         self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//                         self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
//                         self->HUD.label.text = @"数据加载失败";
//                         //self->HUD.minSize = CGSizeMake(100, 10);
//                         self->HUD.offset = CGPointMake(0, -300);
//                         self->HUD.contentColor = [UIColor whiteColor];
//                         self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
//                         self->HUD.minShowTime= 0.5;/*指示器停留的时间/以秒为做单位*/
//                         [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//
//                         return;
//
//
//                     });
//                 }
//
//
                 
                 
               //将数组中的字典数据都转换成模型
               self.dataArr=[Transaction_NS mj_objectArrayWithKeyValuesArray:array];
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
    NSString *UserApi=APIURL_USDT;
       
    NSURL *url = [NSURL URLWithString:UserApi];
    NSString * Urladd =[NSString stringWithFormat:@"action=goumai&Pagesums=%ld&type=0&Currency=%@",(long)currentPage,_titlea];
           
       
         
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
           NSMutableArray * array = [dic objectForKey:@"Megss"];

             
             //将数组中的字典数据都转换成模型
             //
             
             NSArray *dataArrB = [Transaction_NS mj_objectArrayWithKeyValuesArray:array];
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

-(void)CheckNet
{
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 1;//请求时间
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=1&type=1"];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
   
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
           
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             // NSLog(@"请求成功%@", responseObject);
                                            //主线程
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
                 self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
                 self->HUD.label.text = @"数据请求功能";
                 //self->HUD.minSize = CGSizeMake(100, 10);
                 self->HUD.offset = CGPointMake(0, -300);
                 self->HUD.contentColor = [UIColor whiteColor];
                 self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
                 self->HUD.minShowTime= 0.5;/*指示器停留的时间/以秒为做单位*/
                 [MBProgressHUD hideHUDForView:self.tableView animated:YES];
                  
                 return;

                     
             });
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //  NSLog(@"请求失败");
                    //主线程
          dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);//数字为时间延时
          dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
              self->HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
              self->HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
              self->HUD.label.text = @"服务器连接超时";
              //self->HUD.minSize = CGSizeMake(100, 10);
              self->HUD.offset = CGPointMake(0, -300);
              self->HUD.contentColor = [UIColor whiteColor];
              self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
              self->HUD.minShowTime= 0.5;/*指示器停留的时间/以秒为做单位*/
              [MBProgressHUD hideHUDForView:self.tableView animated:YES];
               
              return;

                  
          });

 

        }];
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
    [tableView tableViewDisplayWitMsg:@"网络不给力哟 ^-^" ifNecessaryForRowCount:self.dataArr.count];
   // [self CheckNet];
    self.tableView.mj_footer.hidden = (self.dataArr.count == 0);
    return self.dataArr.count;
    
    
    
}
//显示每一行的数据

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{

    static NSString *CellIdentifier = @"CustomCell";
    Transaction_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    cell = [[Transaction_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色
    
    
    
    // 取出indexPath对应的数据,  //根据行号来提取模型，并设置数据
    Transaction_NS *item=self.dataArr[indexPath.row];
    //cell.username.text = @"行远币行";
    //cell.vol.text = item.vol;
 
    
    
    NSString * vols = [NSString stringWithFormat:@"数量 %@ %@",item.vol,_titlea];
    cell.vol.text = vols;
    
    int Num = [item.LimitA intValue ];
    NSString *display = [NSNumberFormatter localizedStringFromNumber:@(Num) numberStyle:NSNumberFormatterDecimalStyle];
    
    int NumA = [item.tatol intValue ];
    NSString *Adisplay = [NSNumberFormatter localizedStringFromNumber:@(NumA) numberStyle:NSNumberFormatterDecimalStyle];
    NSString * tatols = [NSString stringWithFormat:@"限额 ¥%@-¥%@",display,Adisplay];
    cell.tatol.text = tatols ;
    

    
    //固定格式 NSNumberFormatterDecimalStyle可进入帮助文档查看更多
    //NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //formatter.numberStyle = NSNumberFormatterDecimalStyle;
    //NSString *num = item.pri;
    //NSNumber *result111 = [NSNumber numberWithDouble:num.doubleValue];
    //NSString *stringA = [formatter stringFromNumber:result111];
    //NSLog(@"--第一种转换后的格式是--- %@",stringA);
 
    
    //自定义格式
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    [moneyFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *num = item.pri;
    //NSLog(@"--第二种转换后的格式是--- %@",[moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]]);
    NSString * pris  = [moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]];
    cell.pri.text = [NSString stringWithFormat:@"¥%@",pris];
    
    

    int Vol_ID = arc4random() % 10+90;//成功交易率，100是生成百位以内的数
    int Vol_X = arc4random() % 10000;//成功交易单数，10000是生成千位以内的数
    cell.vol_A.text = [NSString stringWithFormat:@"%d | %d%@",Vol_X,Vol_ID,@"%"];
    cell.pri_A.text = @"单价" ;
   
    if ([item.alipay isEqualToString:@"(null)"]) {
        cell.carpic.image = [UIImage imageNamed:@"weixin"];
    } else if([item.weixin isEqualToString:@"(null)"]) {
        cell.carpic.image = [UIImage imageNamed:@"alipay"];
    } else{
         cell.carpic.image = [UIImage imageNamed:@"alipay"];
         cell.carpicA.image = [UIImage imageNamed:@"weixin"];
    }
    
    UILabel * chusou = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/3.8), 105, 85, 30)];
    chusou.backgroundColor = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
    chusou.text = @"购买";
    chusou.textAlignment = NSTextAlignmentCenter;
    chusou.textColor = [UIColor whiteColor];
    chusou.font = [UIFont boldSystemFontOfSize:15];
    [cell.contentView addSubview:chusou];

    //cell.goumai.text = @"购买";
    //cell.logo.image = [UIImage imageNamed:@"V"];
    NSString *originalStr = item.Another;
    NSString *subStr = [originalStr substringWithRange:NSMakeRange(0, 1)];
    cell.logo_text.text = subStr;
  

    
//    //创建富文本
//    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString: item.Another];
//    //NSTextAttachment可以将要插入的图片作为特殊字符处理
//    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//    //定义图片内容及位置和大小
//    attch.image = [UIImage imageNamed:@"shine"];
//    attch.bounds = CGRectMake(4, -4, 20, 20);
//    //创建带有图片的富文本
//    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//    //将图片放在最后一位
//    [attri appendAttributedString:string];
//    //将图片放在第一位
//    //[attri insertAttributedString:string atIndex:0];
//    //用label的attributedText属性来使用富文本
//    cell.username.attributedText = attri;
    

//
//    cell.username.userInteractionEnabled=YES;
//    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
//    objc_setAssociatedObject(cell.username, "username", item.username, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON传值使用
//
//    [cell.username addGestureRecognizer:labelTapGestureRecognizer];


    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 15, 100, 20);
    //btn.backgroundColor  = [UIColor orangeColor];
    //UIImage *image = [UIImage imageNamed:@"qr-acode"]
    //[btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setTitle:item.Another forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [btn addTarget:self action:@selector(sale:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(btn, "username", item.username, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON传值使用
    objc_setAssociatedObject(btn, "Another", item.Another, OBJC_ASSOCIATION_RETAIN_NONATOMIC);////BUTTON传值使用
    [cell addSubview:btn];

    //UITableView去掉自带系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //自定义分割线
    //    UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 10)];
    //    VC.backgroundColor = RGBA(245,245,245,1);
    //    [cell.contentView addSubview:VC];
    UIView * VC1 = [[UIView alloc]initWithFrame:CGRectMake(0, 143, self.view.frame.size.width, 1)];
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
    return 144;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath


{
    //取沙盒用户信息
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    _typeA = [dic objectForKey:@"type"];
    
    if ([_typeA isEqualToString:@"1"]) {
        
         Hy_order_ViewController * vc = [[Hy_order_ViewController alloc]init];
         Transaction_NS *item=self.dataArr[indexPath.row];
         vc.Currency = item.Currency;//传币种
         vc.pri = item.pri;//传单价
         vc.tatol = item.tatol;//总金额
         vc.LimitA = item.LimitA;//限额
         vc.vol  = item.vol;//数量
         vc.alipay = item.alipay;
         vc.weixin  = item.weixin;
         vc.username = item.username;//
         vc.Another = item.Another;//买家/卖家名称
         vc.KYC = item.rzdj;//认证等级
         vc.conter = item.conter;//备注
         vc.black_A =@"0";
        

         [self.navigationController pushViewController:vc animated:YES];
    } else {
         [self performSelector:@selector(Login:) withObject:self ];
    }

    
}
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{

      // UILabel *label=(UILabel*)recognizer.view;

       //NSLog(@"%@被点击了",label.text);
    
     // id KYC = objc_getAssociatedObject(recognizer, "username"); //取参
      // NSLog(@"%@",KYC);

    }
-(void)sale:(UIButton *)sender{




 
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTransferIndex" object:self userInfo:nil];

        id username = objc_getAssociatedObject(sender, "username"); //取参
        id Another = objc_getAssociatedObject(sender, "Another"); //取参

    
         Order_sale_ViewController * vc = [[Order_sale_ViewController alloc]init];
//         Transaction_NS *item=self.dataArr[indexPath.row];
//         vc.Currency = item.Currency;//传币种
//         vc.pri = item.pri;//传单价
//         vc.tatol = item.tatol;//总金额
//         vc.LimitA = item.LimitA;//限额
//         vc.vol  = item.vol;//数量
//         vc.alipay = item.alipay;
//         vc.weixin  = item.weixin;
//         vc.username = item.username;//
//         vc.Another = item.Another;//买家/卖家名称
//         vc.KYC = item.rzdj;//认证等级
//         vc.conter = item.conter;//备注
//         vc.black_A =@"0";
           vc.username = username;
           vc.Another = Another;
           
           vc.balck_A = @"0";
   
        

         [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)Login:(UITapGestureRecognizer*)sender{
    //具体事件
   
    Login_ViewController *toVC = [Login_ViewController alloc];
    
    Login_PresentationController *presentationC = [[Login_PresentationController alloc] initWithPresentedViewController:toVC presentingViewController:self];
    
    toVC.transitioningDelegate = presentationC ;  // 指定自定义modal动画的代理
    
    [self presentViewController:toVC animated:YES completion:nil];
    //[self dismissView];//清除顶部黑边
  
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // UIStatusBarStyleLightContent 白色
    // UIStatusBarStyleDefault      黑色
    //NSLog(@"5");

   return UIStatusBarStyleLightContent;
    

    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    // NSLog(@"2");
    //AudioServicesPlaySystemSound(SOUNDID);//文件类型
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动类型


}

@end
