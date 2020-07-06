//
//  Setting_ViewController.m
//  topbar
//
//  Created by topbar on 2019/9/25.
//  Copyright © 2019 guo feng zou. All rights reserved.
//设置

#import "Setting_ViewController.h"
#import "Another_ViewController.h"
#import "Currency_ViewController.h"
#import "Edit_password_ViewController.h"
#import "Language_ViewController.h"



@interface Setting_ViewController ()

@end

@implementation Setting_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//显示沙盒路径
//    NSArray * paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSLog(@"沙盒路径:%@",paths);

    [self ShareaA];

}

-(void)ShareaA
{

//     //----右滑手势解决
//     self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//    
//            //给导航条设置一个空的背景图 使其透明化
//     [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//
//            //去除导航条透明后导航条下的黑线
//     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
     
           //设置导航控制器的代理(隐藏顶部-nav)
     self.navigationController.delegate = self;
      
      ///设置窗口大小
    _tableVA=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
     
    _tableVA.delegate=self;
    _tableVA.dataSource=self;
      //----隐藏滚动条
    self.tableVA.showsVerticalScrollIndicator = NO;
    //---滚动条修改颜色
    //self.tableV.indicatorStyle=UIScrollViewIndicatorStyleBlack;
    [self.view addSubview:_tableVA];


    [self Nav_UI];
   
    //初始化pickController相册
    [self createData];
    //定位当前省市
    [self LocationService];
    //计算缓存
    [self ClearCache];
 

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
     [title setText:@"设置"];
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
    
    return 10;

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


    
    //---打开沙盒用户文件件
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    
    //---沙盒里用户信息
    Currency = [dic objectForKey:@"Currency"];
    Language = [dic objectForKey:@"Language"];
    Sex = [dic objectForKey:@"Sex"];
    username = [dic objectForKey:@"username"];//用于POST用户身份确认
    pic= [dic objectForKey:@"pic"];
    Another= [dic objectForKey:@"Another"];//用户呢称

    
    //沙盒里的头像文件,单位独文件
//    NSString *imageFilePath = [documentsPath stringByAppendingPathComponent:@"face_img.jpg"];
//    Face_img = [UIImage imageWithContentsOfFile:imageFilePath];


    
     if (indexPath.section == 0)
    {
        
        
        
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"呢称"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            cell.detailTextLabel.text = Another;
            cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
         }
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"头像"];
            //自定义小箭头
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            //获取本地沙盒头像
            UIImageView *FaceImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/5), 15, 30, 30)];
            //FaceImg.image = Face_img;沙盒头像文件名,单独一个图片文件
            NSString *api_url = [NSString stringWithFormat:@"%@",pic];
            NSString *urlString =[APIURL stringByAppendingString:api_url];
            
            NSString *string = urlString;
            NSURL *picURL = [NSURL URLWithString:string];
            [FaceImg sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"user@2x.png"] ];
            //NSLog(@"%@",picURL);
            //设置圆角
            FaceImg.layer.cornerRadius = FaceImg.frame.size.width / 2;;
            //将多余的部分切掉
            FaceImg.layer.masksToBounds = YES;
            
            [cell.contentView addSubview:FaceImg];

            
        }
        if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"修改密码"];
            //cell.imageView.image = [UIImage imageNamed:@""];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            
            
        }
        if (indexPath.row == 3)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"语言设置"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            cell.detailTextLabel.text = Language;
            cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
 
        }
        if (indexPath.row == 4)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"计价方式"];
            //cell.imageView.image = [UIImage imageNamed:@""];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            cell.detailTextLabel.text = Currency;
            cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];

        }
        if (indexPath.row == 5)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"视频保存/上传"];
            //cell.imageView.image = [UIImage imageNamed:@"app_back_btn_n"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
            cell.accessoryView = imageView;
            cell.detailTextLabel.text = @"默认";
            cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];


        }
        if (indexPath.row == 6)
         {
                   
             //调用网络判断
             [CheckNet netWorkState:^(NSInteger netState) {
                    switch (netState) {
                        case -1:{
                            //NSLog(@"11=%@",self->Netstatus);
                            self->Netstatus =@"未知网络";
                        }
                            break;
                         case 0:{
                            //NSLog(@"11=%@",self->Netstatus);
                            self->Netstatus =@"没有网络";
                        }
                           break;
                        case 1:{
                            //NSLog(@"22=%@",self->Netstatus);
                            self->Netstatus =@"4G";
                        }
                            break;
                        case 2:{
                           // NSLog(@"33=%@",self->Netstatus);
                            self->Netstatus =@"WiFi";
                        }
               
                    }
                }];
                 
           cell.textLabel.text = [NSString stringWithFormat:@"网络检测"];
           //cell.imageView.image = [UIImage imageNamed:@""];
           UILabel * text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
           text.text = Netstatus;
           text.font = [UIFont systemFontOfSize:14];
           text.textAlignment  = NSTextAlignmentCenter;
           text.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
           cell.accessoryView =text;
      

         }
        if (indexPath.row == 7)
         {
           cell.textLabel.text = [NSString stringWithFormat:@"地区"];
           //cell.imageView.image = [UIImage imageNamed:@""];
           UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
           cell.accessoryView = imageView;
           cell.detailTextLabel.text = City;
           cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
           cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
 
             
          }
        
        if (indexPath.row == 8)
          {
             cell.textLabel.text = [NSString stringWithFormat:@"性别"];
             //cell.imageView.image = [UIImage imageNamed:@""];
             UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_back_btn_F"]];
             cell.accessoryView = imageView;
             cell.detailTextLabel.text = Sex;
             cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
             cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
           }
        if (indexPath.row == 9)
          {
             cell.textLabel.text = [NSString stringWithFormat:@"清除缓存"];
             cell.detailTextLabel.text = _cachesSize;
             cell.detailTextLabel.textColor =[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
             cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
           }
    }

        //-----------
        //UITableView去掉自带系统的分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //自定义分割线
        UIView * VC = [[UIView alloc]initWithFrame:CGRectMake(0, 59, self.view.frame.size.width, 0.5)];
        VC.backgroundColor = RGBA(239, 239, 244, 1);
        [cell.contentView addSubview:VC];
    
//    NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:0];
//    //刷新
//    [self.tableVA reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//
//    //获取需要刷新的cell所在位置
//    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
//    //刷新
//    [self.tableVA reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
//

    
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
    _tableVA.sectionHeaderHeight = 50;
    return [[UIView alloc]init]; //_tableV.sectionHeaderHeight = 50;”才生效
    
  
}

////脚视图高度
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10.0f;
//
//}


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

              //   NSLog(@"呢称设置");
                Another_ViewController * vc = [[Another_ViewController alloc]init];
                vc.Another_type = Another;
                [self.navigationController pushViewController:vc animated:YES];
                           
             }
            
            if (indexPath.row == 1)
            {

              //  NSLog(@"头像");
                 AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                 // 设置超时时间
                 [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
                 manager.requestSerializer.timeoutInterval = 0.5f;//请求时间
                 [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
                 NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=1&type=1"];
                 NSString *urlString =[APIURL stringByAppendingString:api_url];
                
                 [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  // NSLog(@"请求成功%@", responseObject);
                       [self phpto];
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  //  NSLog(@"请求失败");
                        
                  self->HUD = [MBProgressHUD showHUDAddedTo:self.tableVA animated:YES];
                  //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
                  self->HUD.label.text = @"未连接服务器";
                  self->HUD.minSize = CGSizeMake(100, 10);
                  self->HUD.contentColor = [UIColor whiteColor];
                  self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
                  self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
                  [MBProgressHUD hideHUDForView:self.tableVA animated:YES];
                         
                   return;
                  }];
             
                
            }
            if (indexPath.row == 2)
            {

              //   NSLog(@"密码");
                Edit_password_ViewController * vc = [[Edit_password_ViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                           
            }
            if (indexPath.row == 3)
            {

              //   NSLog(@"语言设置");
                Language_ViewController * vc = [[Language_ViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                           
             }
            
            if (indexPath.row == 4)
            {

              //  NSLog(@"计价方式");
                Currency_ViewController * vc = [[Currency_ViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row == 5)
            {

              //  NSLog(@"涨跌色");
                 AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                 // 设置超时时间
                 [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
                 manager.requestSerializer.timeoutInterval = 0.5f;//请求时间
                 [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
                 NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=1&type=1"];
                 NSString *urlString =[APIURL stringByAppendingString:api_url];
                
                 [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  // NSLog(@"请求成功%@", responseObject);
                        [self Video];
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  //  NSLog(@"请求失败");
                        
                  self->HUD = [MBProgressHUD showHUDAddedTo:self.tableVA animated:YES];
                  //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
                  self->HUD.label.text = @"未连接服务器";
                  self->HUD.minSize = CGSizeMake(100, 10);
                  self->HUD.contentColor = [UIColor whiteColor];
                  self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
                  self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
                  [MBProgressHUD hideHUDForView:self.tableVA animated:YES];
                         
                   return;
                  }];
               
                           
            }
            if (indexPath.row == 6)
             {

              //  NSLog(@"网络检测");
 
                           
              }
            if (indexPath.row == 7)
             {

              //  NSLog(@"地区");
                 [self LocationService];
                           
             }

            if (indexPath.row == 8)
            {

              // NSLog(@"性别");
                
            [self Sex];
                                     
            }
            if (indexPath.row == 9)
            {

               
                [ClearCacheTool clearCacheWithFilePath:NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]];
                [self DismissViewController];
                //NSLog(@"清除");
                // 刷新 一个cell或row
                // NSIndexPath *indexPath=[NSIndexPath indexPathForRow:8 inSection:0];
                // [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

                                     
            }
    
            break;
        }

        
    }
}
//初始化相册
- (void)createData
{
    //初始化pickerController
    imagePickerController = [[UIImagePickerController alloc]init];
    // [imagePickerController.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    imagePickerController.view.backgroundColor = [UIColor whiteColor];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;


    
    
    //跳转动画效果
    //imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //imagePickerController.allowsEditing = YES;
    

}

-(void)Video
{
    
    //初始化视频
    self->imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
       
           //录制的类型 下面为视频
    self->imagePickerController.mediaTypes=@[(NSString*)kUTTypeMovie];
           //录制的时长
    self->imagePickerController.videoMaximumDuration=10.0;
    
    //  UIAlertController *alertCtl =[[UIAlertController alloc]init];
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //NSLog(@"取消");
    }];
 
    UIAlertAction *luxiang =[UIAlertAction actionWithTitle:@"拍摄视频保存/上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //NSLog(@"拍照");
        
        
        [self luxiang];
    }];
    UIAlertAction *xiangce =[UIAlertAction actionWithTitle:@"相册视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //NSLog(@"相册");
        
        [self choosePicture];
    }];
   
    
    [alertCtl addAction:cancel];
    [alertCtl addAction:xiangce];
    [alertCtl addAction:luxiang];
    
    // [self presentViewController:alertCtl animated:YES completion:nil];
    //alertCtl//-----UIAlertController弹出非常慢,将present的代码放在主线程中执行
      dispatch_async(dispatch_get_main_queue(), ^{
           [self presentViewController: alertCtl animated: YES completion: nil];
      });
    
}

- (void)phpto {
    
  //  UIAlertController *alertCtl =[[UIAlertController alloc]init];
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //NSLog(@"取消");
    }];
    UIAlertAction *xiangji =[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //NSLog(@"拍照");
            //拍摄

        
        [self makePhoto];
    }];
    //    UIAlertAction *luxiang =[UIAlertAction actionWithTitle:@"拍摄视频保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        //NSLog(@"拍照");
    //
    //
    //        self->imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //
    //            //录制的类型 下面为视频
    //        self->imagePickerController.mediaTypes=@[(NSString*)kUTTypeMovie];
    //
    //            //录制的时长
    //        self->imagePickerController.videoMaximumDuration=60.0;//秒
    //
    //        [self luxiang];
    //    }];
    UIAlertAction *xiangce =[UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //NSLog(@"相册");
        
        [self choosePicture];
    }];
    // UIAlertAction *tuku =[UIAlertAction actionWithTitle:@"从图库上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    // NSLog(@"图库");
    //
    // [self pictureLibrary];
    // }];
    
    [alertCtl addAction:cancel];
    [alertCtl addAction:xiangji];
    [alertCtl addAction:xiangce];
    //[alertCtl addAction:tuku];
    //[alertCtl addAction:luxiang];
    
    // [self presentViewController:alertCtl animated:YES completion:nil];
    //alertCtl//-----UIAlertController弹出非常慢,将present的代码放在主线程中执行
      dispatch_async(dispatch_get_main_queue(), ^{
           [self presentViewController: alertCtl animated: YES completion: nil];
      });
}

//录像模式
-(void)luxiang
{
 
    imagePickerController.sourceType = UIImagePickerControllerCameraCaptureModeVideo;
    [self presentViewController:imagePickerController animated:YES completion:nil];

    
}
//跳转到摄像头
- (void)makePhoto
{
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
//跳转到相册
- (void)choosePicture
{
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
//跳转图库
- (void)pictureLibrary
{
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

//用户取消退出picker时候调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   // NSLog(@"%@",picker);
   // NSLog(@"取消");
    [picker dismissViewControllerAnimated:YES completion:^{
         
                    [self.tableVA removeFromSuperview];
                    [self.tableVA.layer removeFromSuperlayer];

                      // _tableV=nil;
                    [self ShareaA];
    }];
}

//用户选中图片之后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    //UIImagePickerControllerEditedImage//获取编辑后的照片
    //UIImagePickerControllerOriginalImage//获取原始照片
    UIImage *userImage = [self fixOrientation:[info objectForKey:@"UIImagePickerControllerEditedImage"]];
    //缩放图片
    userImage = [self scaleImage:userImage toScale:0.3];
    //保存图片到沙盒的文件名，单独图片
    //  [self saveImage:userImage name:@"face_img"];


    //---------//如果是拍照提取做头像
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]   && picker.sourceType ==UIImagePickerControllerSourceTypeCamera) {
    // 保存拍照图片到相册中  //必要实现的协议方法, 不然会崩溃 image didFinishSavingWithError
    UIImageWriteToSavedPhotosAlbum(userImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
      //  NSLog(@"1");


    //获取头像地址
    _urlimg = userImage;
    //上传头像到服务器
    [self upDateHeadIcon:userImage];

    }
    
    //-----------//如果是相册提取做头像
     else if
     ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //  NSLog(@"2");
     //获取头像地址
     _urlimg = userImage;
     //上传头像到服务器
     [self upDateHeadIcon:userImage];
               
      }
    
     //-----------//如果是拍摄视频,并不做头像，只是保存在相册
     else if
     ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
     // 保存拍摄视频到相册中  //必要实现的协议方法, 不然会崩溃 videoPath didFinishSavingWithError
     NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
     NSString *urlStr=[url path];
     if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
     //保存视频到相簿，
     UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
       
     }
         //  NSLog(@"3");
         //获取视频地址
         _urlVideo = urlStr;
         //将视频上传到服务器
         [self upDateHeadVideo:userImage];
          
      }
    

    
    //------公用刷新页面
    [picker dismissViewControllerAnimated:YES completion:^{

          [self.tableVA removeFromSuperview];
          [self.tableVA.layer removeFromSuperlayer];

          // _tableV=nil;
          [self ShareaA];
          //NSLog(@"刷新");
            
    }];

}

//拍照相片保存到相簿的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
            // NSLog(@"保存图片失败");
         } else {
            // NSLog(@"保存图片成功");
         }
 
}
// 拍摄视频保存到相簿的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        //NSLog(@"视频保存成功.");
        //录制完之后可以使用AVPlayer自动播放
        //NSURL *url=[NSURL fileURLWithPath:videoPath];
        //NSLog(@"视频路径=%@", url);
        
    }
}


//将头像图片上传到服务器
- (void)upDateHeadIcon:(UIImage *)photo
{
    //[self CheckNet];//网络超时
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //设置服务器允许的请求格式内容
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *api_url = [NSString stringWithFormat:@"faceimg_api.php"];
    NSString *urlString =[APIURL stringByAppendingString:api_url];

    
    
    // fromData: AFN封装好的http header类，可以添加请求体
    [session POST:urlString parameters:@{@"username":username} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            UIImage *image = self->_urlimg;
            NSData *fileData = UIImageJPEGRepresentation(image, 0.1);//压缩系数
            //NSLog(@"upload image size: %ld k", (long)(fileData.length / 1024));
        
            // 随机生成图片名字
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"upload_face/%@.jpg", str];
        
            //头像文件名外网路径保存在沙盒----开始
            NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documents = [array lastObject];
            NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
            NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
            [dic_notice setObject:fileName forKey:@"pic"];
            //准备要添加存入的字典
            [dic_notice writeToFile:documnetPath atomically:YES];
            //-----------结束
        
        

            
        [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            //NSLog(@"%f",uploadProgress.fractionCompleted);
          
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            //NSLog(@"成功%@",responseObject);
            self->HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
            self->HUD.label.text = @"上传成功！";
             //HUD.minSize = CGSizeMake(100, 10);
            self->HUD.contentColor = [UIColor whiteColor];
            self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
            
             //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 // Do something...
                  //事件
             [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
            
              });

            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败");
            
     
        }];

}

//将视频上传到服务器
- (void)upDateHeadVideo:(UIImage *)photo
{
    //[self CheckNet];//网络超时
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //设置服务器允许的请求格式内容
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *api_url = [NSString stringWithFormat:@"faceimg_api.php"];
    NSString *urlString =[APIURL stringByAppendingString:api_url];

    
    
    // fromData: AFN封装好的http header类，可以添加请求体
    [session POST:urlString parameters:@{@"username":username} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //UIImage *image = self->_urlimg;
            //NSData *fileData = UIImageJPEGRepresentation(image, 0.1);//压缩系数
           NSData*fileData = [NSData dataWithContentsOfFile:self->_urlVideo];
           //NSLog(@"upload image size: %ld k", (long)(fileData.length / 1024));
        
            // 随机生成图片名字
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"upload_face/%@.mp4", str];
      
        [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:@"image/mp4"];
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            //NSLog(@"%f",uploadProgress.fractionCompleted);
           
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
           // NSLog(@"成功%@",responseObject);
            self->HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
            self->HUD.label.text = @"视频上传成功！";
             //HUD.minSize = CGSizeMake(100, 10);
            self->HUD.contentColor = [UIColor whiteColor];
            self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
            
             //HUD.minShowTime= 2;/*指示器停留的时间/以秒为做单位*/
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 // Do something...
                  //事件
             [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
            
              });

            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败");
            
     
        }];
}
//缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //NSLog(@"%@",NSStringFromCGSize(scaledImage.size));
    return scaledImage;
}


//保存照片到沙盒路径(保存)
- (void)saveImage:(UIImage *)image name:(NSString *)iconName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //写入文件
    NSString *icomImage = iconName;
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", icomImage]];
    // 保存文件的名称
    // [[self getDataByImage:image] writeToFile:filePath atomically:YES];
    [UIImagePNGRepresentation(image)writeToFile: filePath  atomically:YES];
}




//修正照片方向(手机转90度方向拍照)
- (UIImage *)fixOrientation:(UIImage *)aImage {
   
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
       switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


-(void)Sex
{
        //打开沙盒
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [array lastObject];
        NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
        //--------
    
    
        //1.创建Controller
        UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

        //2.添加按钮动作
        UIAlertAction *action_man = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // NSLog(@"男");
            //性别信息存入沙盒
            //NSDictionary *dic_notice = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"Sex",nil];
            NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
            [dic_notice setObject:@"男" forKey:@"Sex"];
            //准备要添加存入的字典
            [dic_notice writeToFile:documnetPath atomically:YES];
            [self Updata_sex];
            //刷新tableva
            //[self DismissViewController];
        }];
        UIAlertAction *action_woman = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // NSLog(@"女");
            //性别信息存入沙盒
            NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
            [dic_notice setObject:@"女" forKey:@"Sex"];
             //准备要添加存入的字典
            [dic_notice writeToFile:documnetPath atomically:YES];
            [self Updata_sex];
            //刷新tableva
            //[self DismissViewController];

           
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
    
        //3.添加动作
        [alertSheet addAction:action_man];
        [alertSheet addAction:action_woman];
        [alertSheet addAction:cancel];
    


        //4.显示sheet///UIAlertController弹出非常慢,将present的代码放在主线程中执行
        dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController: alertSheet animated: YES completion: nil];
        });
 



}

-(void)Updata_sex
{
     //取沙盒用户信息
        NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [documentsPathArr lastObject];
        NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
        NSString * username = [dic objectForKey:@"username"];
        NSString * Urlsex = [dic objectForKey:@"Sex"];
     

        
        //创建session对象
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *UserApi=APIURL_USER;
           
        NSURL *url = [NSURL URLWithString:UserApi];
        NSString * Urladd =[NSString stringWithFormat:@"action=edit_sex&username=%@&sex=%@",username,Urlsex];
        //NSLog(@"URL==%@",Urladd);
                
           
             
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        //设置request
        request.HTTPMethod = @"POST" ;
           
        NSData *data=[Urladd dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = data;
        //创建任务
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               if (!error )
                 {
                     
                   
                     
                 NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                       
                    //修改状态，返回failure或success
                    //1008 修改成功 ，1009 修改失败 ，
                    NSString *status = [dict objectForKey:@"status"];
                    NSString *code = [dict objectForKey:@"code"];
                    if ([status isEqualToString:@"failure"])
                    {
                        
                    NSLog(@"失败==%@",status);
                    NSLog(@"失败代码==%@",code);
                        
    //                self->HUD = [MBProgressHUD showHUDAddedTo:self.tableV animated:YES];
    //                //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
    //                self->HUD.label.text = @"修改失败！";
    //                self->HUD.minSize = CGSizeMake(100, 10);
    //                self-> HUD.contentColor = [UIColor whiteColor];
    //                self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
    //                [MBProgressHUD hideHUDForView:self.tableV animated:YES];
    //                return;
                                     
                                            
                     }
              
                                  
                      else {
                     
                           //修改状态，返回failure或success
                           //1008 修改成功 ，1009 修改失败 ，
                     NSString *status = [dict objectForKey:@"status"];
                     //NSString *code = [dict objectForKey:@"code"];
                     if ([status isEqualToString:@"success"])
                     {

                     // NSLog(@"成功==%@",status);
                     // NSLog(@"成功代码==%@",code);
                                         

                                
                      }
                    
                   
                           }
                 }
                 else
                     
                 {
                     NSLog(@"error is :%@",error.localizedDescription);
                   
                  
                 }
            
                 }];
              
             //开始任务

           
             [task resume];
           
            [self CheckNet];
            [self DismissViewController];
}
- (void)DismissViewController
{
    
    
     HUD = [MBProgressHUD showHUDAddedTo:self.tableVA animated:YES];
//   HUD.mode = MBProgressHUDModeCustomView;
//   UIImage *image = [[UIImage imageNamed:@"checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//   HUD.customView = [[UIImageView alloc] initWithImage:image];
//   HUD.square = YES;
     HUD.label.text = NSLocalizedString(@"Done", @"HUD done title");
    
     HUD.contentColor = [UIColor whiteColor];
     HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
    

     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);//数字为时间延时
     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
         // Do something...
          // 刷除tableV,释放内存
          [self.tableVA removeFromSuperview];
          [self.tableVA.layer removeFromSuperlayer];
          //  _tableV=nil;
          [self ShareaA];
         
     [MBProgressHUD hideHUDForView:self.tableVA animated:YES];
         
    
      });

}


//----- 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
     // 判断要显示的控制器是否是自己
     BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
     [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
    
    // bug fixes: UIIMagePickerController使用中偷换StatusBar颜色的问题
     if ([navigationController isKindOfClass:[UIImagePickerController class]]) {
        [navigationController.navigationBar setBarStyle:UIBarStyleBlack];
  //头像返回调用NAV
        navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController setNavigationBarHidden:YES animated:YES];

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

     // NSLog(@"1");
      self.navigationController.navigationBarHidden= YES;//半返回状态，然后恢位，解决喇叭不响应事件



}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//
//    NSLog(@"2");
//
//
//}
//计价方式返回用到调用
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

    //NSLog(@"3");
    // 刷除tableV,释放内存
    [self.tableVA removeFromSuperview];
    [self.tableVA.layer removeFromSuperlayer];
    //  _tableV=nil;
    [self ShareaA];


}
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:YES];
//
//    NSLog(@"4");
//
//
//}
-(void)CheckNet
{
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 1.f;//请求时间
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *api_url = [NSString stringWithFormat:@"JSON.PHP?Pagesums=1&type=1"];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
   
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
           
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          // NSLog(@"请求成功%@", responseObject);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //  NSLog(@"请求失败");
           self->HUD = [MBProgressHUD showHUDAddedTo:self.tableVA animated:YES];
           //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
           self->HUD.label.text = @"未连接服务器";
           self->HUD.minSize = CGSizeMake(100, 10);
           self->HUD.contentColor = [UIColor whiteColor];
           self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
           self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
           [MBProgressHUD hideHUDForView:self.tableVA animated:YES];
            
           return;
        }];
}

//之后便是开始定位，因为iOS8.0之后，当APP想访问用户的隐私信息时，系统不再自动弹出一个对话框让用户授权，所以需要主动请求用户授权
-(void)LocationService
{
        // 初始化定位管理器
        self.locationManager=[[CLLocationManager alloc]init];
        self.locationManager.delegate=self;
        // 设置定位精确度到千米
        self.locationManager.desiredAccuracy=kCLLocationAccuracyKilometer;
        // 设置过滤器为无
        self.locationManager.distanceFilter=kCLDistanceFilterNone;
        //这句话ios8以上版本使用
        [ self.locationManager requestAlwaysAuthorization];
        //开始定位
        [ self.locationManager startUpdatingLocation];

}



-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
       if ([error code] == kCLErrorDenied) {
       NSLog(@"访问被拒绝");
           
       }
      if ([error code] == kCLErrorLocationUnknown) {
      NSLog(@"无法获取位置信息");
          
      }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];

    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks[0];
            
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            //NSLog(@"city = %@", city);//城市名
            //NSLog(@"--%@",placemark.name);//街名
            //NSLog(@"++++%@",placemark.subLocality); //区（海淀）
            //NSLog(@"country == %@",placemark.country);//中国
            //NSLog(@"administrativeArea == %@",placemark.administrativeArea); //省
            self->City =[NSString stringWithFormat:@"%@-%@", placemark.subLocality,placemark.name];
        }
        else if (placemarks.count == 0 && error == nil){
            NSLog(@"没有结果");
        }else if (error != nil){
            NSLog(@"有错误");
        }}];
    [manager stopUpdatingLocation];

}
/*监听用户授权状态，表示当前应用程序的授权状态。(CLAuthorizationStatus)status，当用户授权状态发生变化时调用
 */
-(void)locationManager:(nonnull CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
           // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定");
            break;
        }
           // 访问受限(苹果预留选项,暂时没用)
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
            //定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            //定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位开启，但被拒");
               // 在此处, 应该提醒用户给此应用授权, 并跳转到"设置"界面让用户进行授权
               // 在iOS8.0之后跳转到"设置"界面代码
                NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:settingURL])
                {
                    [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:nil];
                   
                }
            }else
            {
                NSLog(@"定位关闭，不可用");
            }
            break;
        }
//           // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
           // case kCLAuthorizationStatusAuthorized: //失效，不建议使用
        {
           // NSLog(@"获取前后台定位授权");
            break;
        }
           // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            //NSLog(@"获得前台定位授权");
            break;
        }
        default:
            break;
    }


}

-(void)ClearCache
{
    //Document文件夹：
    _Document =  [ClearCacheTool getCacheSizeWithFilePath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
    //Library文件夹：
    _Library =  [ClearCacheTool getCacheSizeWithFilePath:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0]];
    //Library/Caches:
    _Caches =   [ClearCacheTool getCacheSizeWithFilePath:NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]];
 
    //    NSLog(@"Document文件夹==%@",_Document);
    //    NSLog(@"Library文件夹==%@",_Library);
    //    NSLog(@"Library/Caches==%@",_Caches);
    _cachesSize =_Caches;
}
@end
