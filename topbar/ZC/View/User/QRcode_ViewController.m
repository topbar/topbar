//
//  QRcode_ViewController.m
//  topbar
//
//  Created by topbar on 2019/11/25.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "QRcode_ViewController.h"

@interface QRcode_ViewController ()

@end

@implementation QRcode_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self Share];
   
}

-(void)Share
{
//       //----右滑手势解决
//      self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//        
//                //给导航条设置一个空的背景图 使其透明化
//      [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//
//                //去除导航条透明后导航条下的黑线
//      [self.navigationController.navigationBar setShadowImage:[UIImage new]];
         
               //设置导航控制器的代理(隐藏顶部-nav)
      self.navigationController.delegate = self;

      
      //设置窗口大小
      _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
     
      _tableV.delegate=self;
      _tableV.dataSource=self;
      //----隐藏滚动条
      self.tableV.showsVerticalScrollIndicator = NO;
      //---滚动条修改颜色
      //self.tableV.indicatorStyle=UIScrollViewIndicatorStyleBlack;
      [self.view addSubview:_tableV];


     [self Nav_UI];
     [self logo];
    

 

}
-(void)Nav_UI
{
    
    //-------自己定义Nav
     UIView * vc =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
     vc.backgroundColor  = [UIColor whiteColor];
     [self.view addSubview:vc];
     //-------左返回
     UIButton *Button_Left = [[UIButton alloc]initWithFrame:CGRectMake(10,(89-20)/2+10,40,40)];
     [Button_Left setImage:[UIImage imageNamed:@"app_back_btn_n"] forState:UIControlStateNormal];
     [Button_Left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:Button_Left];
     //-----居中的title
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-45, (89-20)/2+10, 150, 40)];
     [title setText:@"GOOGLE验证器"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];

    
}
-(void)logo
{
    
    //---打开沙盒用户文件件
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
                   
    //---沙盒里用户信息google验证码
    _QRurl = [dic objectForKey:@"QRurl"];
    _QRcode = [dic objectForKey:@"qrcode"];
    
    UIView * vc  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    //vc.backgroundColor = [UIColor orangeColor];
    _tableV.tableHeaderView = vc;
   

   UILabel *qr = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-80,20,160,20)];
    qr.text  = [NSString stringWithFormat:@"请妥善备份密钥以防遗失"];
    qr.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    qr.font = [UIFont systemFontOfSize:14];
    [vc addSubview:qr];
    
   UIImageView *qrurl = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-80,60,160,160)];
   NSString *string = [NSString stringWithFormat:@"%@",_QRurl];
   NSURL *picURL = [NSURL URLWithString:string];
   [qrurl sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"logo"] ];
   [vc addSubview:qrurl];
    

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;

}


//显示每一行的数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//这个是必需的，
{
    
    static NSString * settingIdentifier=@"topbar";//这个是在没有自定议情况下的类
    
    //以下是当超过全屏时，会调用以下语句
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentifier];//获取一个类
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingIdentifier];

    tableView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];
    cell.textLabel.font = [UIFont italicSystemFontOfSize:16];//设置文本字体与大小
    cell.textLabel.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    cell.backgroundColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//详细箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//UITableView 取消点击cell的选中背景颜色



    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
     if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"GOOGLE验证码"];
            UILabel * text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
            text.text = _QRcode;
            text.font = [UIFont systemFontOfSize:14];
            text.textAlignment  = NSTextAlignmentCenter;
            text.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            cell.accessoryView =text;

     
            
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
    _tableV.sectionHeaderHeight = 80;
    return [[UIView alloc]init];
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

             
                
            }
            if (indexPath.row == 1)
             {

               

                           
             }
            if (indexPath.row == 2)
             {

               // NSLog(@"版本");
                           
             }
            
     
           
            
            
            break;
        }

        
    }
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
