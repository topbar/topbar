//
//  Language_ViewController.m
//  topbar
//
//  Created by topbar on 2019/11/13.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "Language_ViewController.h"

@interface Language_ViewController ()

@end

@implementation Language_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
     //----右滑手势解决
//     self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//    
//            //给导航条设置一个空的背景图 使其透明化
//     [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//
//            //去除导航条透明后导航条下的黑线
//     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
     
           //设置导航控制器的代理(隐藏顶部-nav)
     self.navigationController.delegate = self;
     [self Sharea];
}
-(void)Sharea
{
      
      ///设置窗口大小
    _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
     
    _tableV.delegate=self;
    _tableV.dataSource=self;
      //----隐藏滚动条
    self.tableV.showsVerticalScrollIndicator = NO;
    //---滚动条修改颜色
    //self.tableV.indicatorStyle=UIScrollViewIndicatorStyleBlack;
    [self.view addSubview:_tableV];
    [self Nav_UI];
   

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
     [title setText:@"语言设置"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;

}


//显示每一行的数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{
    
    static NSString * settingIdentifier=@"topbar";//这个是在没有自定议情况下的类
    
    //以下是当超过全屏时，会调用以下语句
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentifier];//获取一个类
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingIdentifier];

    tableView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:16];//设置文本字体与大小
    cell.textLabel.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    cell.backgroundColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//详细箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色



    
    //---取沙盒用户信息
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    Language = [dic objectForKey:@"Language"];

    
    //---------
    
     if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"简体中文"];
            if ([Language isEqualToString:@"简体中文"]) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checked"]];
                cell.accessoryView = imageView;
            }
 
            
        }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"繁体中文"];
            if ([Language isEqualToString:@"繁体中文"]) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checked"]];
                cell.accessoryView = imageView;
            }
            
        }
        if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"English"];
            if ([Language isEqualToString:@"English"]) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checked"]];
                cell.accessoryView = imageView;
            }
 
        }
        if (indexPath.row == 3)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"日本語"];
            if ([Language isEqualToString:@"日本語"]) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checked"]];
                cell.accessoryView = imageView;

        }
        }
        if (indexPath.row == 4)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"Tiếng việt nam"];
            if ([Language isEqualToString:@"Tiếng việt nam"]) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checked"]];
                cell.accessoryView = imageView;

        }
        }
        if (indexPath.row == 5)
         {
           cell.textLabel.text = [NSString stringWithFormat:@"ภาษาเวียดนาม"];
           if ([Language isEqualToString:@"ภาษาเวียดนาม"]) {
               UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checked"]];
               cell.accessoryView = imageView;
         

         }
         }
    
    }

        //-----------
        //UITableView去掉自带系统的分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //自定义分割线
        UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 59, self.view.frame.size.width, 0.5)];
        VC.backgroundColor = RGBA(239, 239, 244, 1);
        [cell.contentView addSubview:VC];
    

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//行间距离（108）
{
    
    return 60;
    
}
////顶部距离
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    NSLog(@"执行");
//    return 24.f;//配合“  _tableV.sectionHeaderHeight = 0;”才生效
//
//}

//iOS 11 TableView heightForFooter 设置Header高度无效解决方法
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     //   NSLog(@"执行");
 
     //------TableView顶间距
    _tableV.sectionHeaderHeight = 50;
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
                
                Language=@"简体中文";
                [self Language];

               
                
            }
            if (indexPath.row == 1)
            {
                Language=@"繁体中文";
                [self Language];

                           
            }
            if (indexPath.row == 2)
            {
                Language=@"English";
                [self Language];

                           
             }
            
            if (indexPath.row == 3)
            {
                Language=@"日本語";
                [self Language];

                
            }
            if (indexPath.row == 4)
            {
                Language=@"Tiếng việt nam";
                [self Language];

                           
            }
            if (indexPath.row == 5)
             {
                 Language=@"ภาษาเวียดนาม";
                 [self Language];
              
                           
              }

    
            break;
        }

        
    }
}
-(void)Language
{
        //打开沙盒
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [array lastObject];
        NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
        //--------
    
       //计价方式信息存入沙盒
        NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
        [dic_notice setObject:Language forKey:@"Language"];
        //准备要添加存入的字典
        [dic_notice writeToFile:documnetPath atomically:YES];
        //刷新tableva
        [self DismissViewController];

}

- (void)DismissViewController
{
    
     HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
     //HUD.mode = MBProgressHUDModeCustomView;
     HUD.label.text = NSLocalizedString(@"Done", @"HUD done title");
     HUD.contentColor = [UIColor whiteColor];
     HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
    
     //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
         // Do something...
          //事件
           // 刷除tableV,释放内存
           [self.tableV removeFromSuperview];
           [self.tableV.layer removeFromSuperlayer];
          
           //  _tableV=nil;
           [self Sharea];
         
      [MBProgressHUD hideHUDForView:self.tableV animated:YES];
         
    
      });
    
    


    
}
- (void)left:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
   
}

@end
