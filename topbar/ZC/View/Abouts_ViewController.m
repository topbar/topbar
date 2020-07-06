//
//  Abouts_ViewController.m
//  topbar
//
//  Created by topbar on 2019/11/4.
//  Copyright © 2019 guo feng zou. All rights reserved.
//关于我们

#import "Abouts_ViewController.h"
#import "Share_Web_H5_ViewController.h"

@interface Abouts_ViewController ()

@end

@implementation Abouts_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

 
    [self Share];
   
 
 
   
}


-(void)Share
{
       //----右滑手势解决
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
      _tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
     
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
     [title setText:@"关于我们"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];

    
}
-(void)logo
{
    UIView * vc  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 200)];
    //vc.backgroundColor = [UIColor orangeColor];
    _tableV.tableHeaderView = vc;
    

    UIButton *AA = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-60,40,120,160)];
    [AA setImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
    //[AA addTarget:self action:@selector(Mssages) forControlEvents:UIControlEventTouchUpInside];
    [AA setTitle:@"V1.88" forState:UIControlStateNormal];
    AA.titleLabel.font = [UIFont systemFontOfSize:14];
    AA.titleLabel.textAlignment = NSTextAlignmentCenter;
    [AA setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5] forState:UIControlStateNormal];
    [AA setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [AA setImageEdgeInsets:UIEdgeInsetsMake(-AA.titleLabel.intrinsicContentSize.height, -(self.view.bounds.size.width)/6/9, 0, -AA.titleLabel.intrinsicContentSize.width)];
    [AA setTitleEdgeInsets:UIEdgeInsetsMake(AA.currentImage.size.height + 10, -AA.currentImage.size.width-10, 0, 0)];
    [vc addSubview:AA];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

//统计菜单总共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;

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
            cell.textLabel.text = [NSString stringWithFormat:@"隐私政策"];
            //cell.imageView.image = [UIImage imageNamed:@""];
            //自定义小箭头
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"去评分"];
            //cell.imageView.image = [UIImage imageNamed:@""];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            
        }
        if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"版本"];
            UILabel * text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 20)];
            text.text = @"当前是最新版本";
            text.font = [UIFont italicSystemFontOfSize:14];
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
    _tableV.sectionHeaderHeight = 50;
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

              // NSLog(@"隐私政策");
               Share_Web_H5_ViewController * vc =[[Share_Web_H5_ViewController alloc]init];
               vc.news_url=@"https://okexsupport.zendesk.com/hc/zh-cn/articles/360021590732-%E9%9A%90%E7%A7%81%E6%94%BF%E7%AD%96%E5%92%8C%E5%A3%B0%E6%98%8E";
               vc.news_Title = @"隐私政策";
               [self.navigationController pushViewController:vc animated:YES];
                
            }
            if (indexPath.row == 1)
             {

                // NSLog(@"去评分");
                NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/ku-you-lun-tan/id1198053796?l=zh&ls=1&mt=8"];
                NSURL *url = [NSURL URLWithString: str];
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];

                           
             }
            if (indexPath.row == 2)
             {

               // NSLog(@"版本");
                           
             }
            
     
           
            
            
            break;
        }

        
    }
}

////// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];

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
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

    //NSLog(@"3");
    // 刷除tableV,释放内存
    [self.tableV removeFromSuperview];
    [self.tableV.layer removeFromSuperlayer];
    //  _tableV=nil;
    [self Share];


}

@end
