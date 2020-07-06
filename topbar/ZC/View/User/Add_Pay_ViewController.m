//
//  Add_Pay_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Add_Pay_ViewController.h"
#import "Pay_ViewController.h"

@interface Add_Pay_ViewController ()

@end

@implementation Add_Pay_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor whiteColor];
    //----右滑手势解决
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    //设置导航控制器的代理(隐藏顶部-nav)
    self.navigationController.delegate = self;
    
    //---打开沙盒用户文件件
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    
    //---沙盒里用户信息
    if ([_pay_name_type isEqualToString:@"支付宝"]) {
        _car_name = [dic objectForKey:@"A_car_name"];//帐户名称
        _car_num = [dic objectForKey:@"A_car_num"];//帐号号码
    } else if([_pay_name_type isEqualToString:@"微信"]){
        _car_name = [dic objectForKey:@"W_car_name"];//帐户名称
        _car_num = [dic objectForKey:@"W_car_num"];//帐号号码
    }
    

    
    [self Nav_UI];
    [self Share_UI];
    [self KeyBoardHide_Yc];
    [self createData];


    //NSLog(@"%@",_pay_url);
    // 显示沙盒路径
//        NSArray * paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSLog(@"沙盒路径:%@",paths);

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
     [Button_Left addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:Button_Left];
     //-----居中的title
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-45, (89-20)/2+10, 90, 40)];
     [title setText:@"收付管理"];
     title.font = [UIFont systemFontOfSize:20];
     title.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
     [vc addSubview:title];
     
     //-------右添加
     UIButton *Add = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50,(89-20)/2+10,40,40)];
     //[Add setImage:[UIImage imageNamed:@"Add"] forState:UIControlStateNormal];
    if (_car_name == NULL || [_car_name isEqualToString:@""]) {
       // NSLog(@"空值");
      
    } else {
         [Add setTitle:@"删除" forState:UIControlStateNormal];
    }
    
     [Add setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
     Add.titleLabel.font = [UIFont systemFontOfSize: 16];
     [Add addTarget:self action:@selector(pay_del) forControlEvents:UIControlEventTouchUpInside];
     [vc addSubview:Add];

}

-(void)Share_UI
{

    
    //以下两种方法为UITextField 光标颜色
    //username.tintColor = [UIColor redColor];//指定UITextField
     [[UITextField appearance] setTintColor:[UIColor orangeColor]];//全局
    
    VC =  [[UIView alloc]initWithFrame:CGRectMake(10, 89, ScreenWidth, ScreenHeight)];
    [self.view addSubview:VC];
   // VC.backgroundColor  = [UIColor redColor];
    UILabel * lablelA= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20, ScreenWidth/2, 40)];
    lablelA.text =@"支付方式";
    lablelA.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    lablelA.font = [UIFont systemFontOfSize:12];
    [VC addSubview:lablelA];
    //-------
    UILabel * lablelB= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40, ScreenWidth/2, 40)];
    lablelB.text =_pay_name_type;
    lablelB.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    lablelB.font = [UIFont systemFontOfSize:20];
    [VC addSubview:lablelB];
    
    //-------
    UILabel * lablelC= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40, ScreenWidth/2, 40)];
    lablelC.text =@"姓名";
    lablelC.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    lablelC.font = [UIFont systemFontOfSize:12];
    [VC addSubview:lablelC];
    
    //----
    username = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40, ScreenWidth/2, 40)];
    username.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    username.text =_car_name;
  
    //username.delegate = self;//限制输入字符,配合方法才能使用


    if (_car_name == NULL || [_car_name isEqualToString:@""]) {
                    //占位符颜色
        NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
        NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请输入您的名字" attributes:attDicA];
        username.attributedPlaceholder = attPlaceA;
        [VC addSubview:username];
    }
    else
    {
                    //占位符颜色
        NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
        NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:_car_name attributes:attDicA];
        username.attributedPlaceholder = attPlaceA;
        [VC addSubview:username];
    }
    //-----------
    UIView * VCA = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40 ,ScreenWidth-50, 1)];
    VCA.backgroundColor = RGBA(239, 239, 244, 1);
    [VC addSubview:VCA];
    //-------
     UILabel * lableldD= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20, ScreenWidth/2, 40)];
    lableldD.text =@"帐号";
    lableldD.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    lableldD.font = [UIFont systemFontOfSize:12];
    [VC addSubview:lableldD];
     
     //----
    Lastname = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40, ScreenWidth/2, 40)];
    Lastname.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
    Lastname.text = _car_num;
    
    //Lastname.delegate = self;//限制输入字符,配合方法才能使用
    if (_car_num == NULL || [_car_num isEqualToString:@""]) {
                    //占位符颜色
        NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
        NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:@"请输入您的帐号" attributes:attDicA];
        Lastname.attributedPlaceholder = attPlaceA;
        [VC addSubview:Lastname];
    }
    else
    {
                    //占位符颜色
        NSMutableDictionary *attDicA = [@{NSForegroundColorAttributeName:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2], NSFontAttributeName:[UIFont systemFontOfSize:16]} mutableCopy];
        NSMutableAttributedString *attPlaceA = [[NSMutableAttributedString alloc] initWithString:_car_num attributes:attDicA];
        Lastname.attributedPlaceholder = attPlaceA;
        [VC addSubview:Lastname];
    }
    //-----

    UIView * VCB = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40 ,ScreenWidth-50, 1)];
    VCB.backgroundColor = RGBA(239, 239, 244, 1);
    [VC addSubview:VCB];
    
    //------
    UILabel * lableldE= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20, ScreenWidth/2, 40)];
    lableldE.text =@"添加二维收款码/银行卡片";
    lableldE.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
    lableldE.font = [UIFont systemFontOfSize:12];
    [VC addSubview:lableldE];
    
    [self up_pic];//单独调用二维码显示

   
    UIView * VCC = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20+40+40 ,ScreenWidth-50, 1)];
    VCC.backgroundColor = RGBA(239, 239, 244, 1);
   // [VC addSubview:VCC];
    //---
    UILabel * lableldF= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20+40+40, ScreenWidth/2, 40)];
    lableldF.text =@"身份证、护照 、驾照或其他合法证件号码";
    lableldF.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.2];
    lableldF.font = [UIFont systemFontOfSize:12];
    //[VC addSubview:lableldF];
    
    
    UIButton *Qbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20+40+40+150, ScreenWidth-50, 40)];
    [Qbutton setTitle:@"提交" forState:UIControlStateNormal];
    [Qbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Qbutton.backgroundColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.7];
    [Qbutton addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
    [VC addSubview:Qbutton];
    
    

    
    
}
-(void)up_pic
{
    //----
    
    //---打开沙盒用户文件件
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:@"UserMesg.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    
 

    
    //---沙盒里用户信息
    _pay_username = [dic objectForKey:@"username"];//用于POST用户身份确认
    if ([_pay_name_type isEqualToString:@"支付宝"]) {
        _pay_url = [dic objectForKey:@"alipay"];//选择后，调用支付宝二维码
 
    } else if([_pay_name_type isEqualToString:@"微信"]) {
        _pay_url = [dic objectForKey:@"weixin"];//选择后，调用微信二维码
   
    }
    
  
    
    
    //NSLog(@"%@",_pay_url);
    
    if (_pay_url == NULL || [_pay_url isEqualToString:@""]) {
                
    code = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20+40, 100, 100)];
    //[code setTitle:@"上传" forState:UIControlStateNormal];
    [code setBackgroundImage:[UIImage imageNamed:@"Add_image"] forState:UIControlStateNormal];//正常未点击图片
    [code setBackgroundImage:[UIImage imageNamed:@"Add_image"] forState:UIControlStateSelected];//选中图片
    
    [code setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [code addTarget:self action:@selector(Add_code) forControlEvents:UIControlEventTouchUpInside];
    [VC addSubview:code];
    //NSLog(@"上传");
               
    } else {
                 
    NSString *api_url = [NSString stringWithFormat:@"%@",_pay_url];
    NSString *urlString =[APIURL stringByAppendingString:api_url];
    UIImageView *headimageView = [[UIImageView alloc] init];
    headimageView.frame = CGRectMake(ScreenWidth/30, ScreenHeight/20+40+40+40+40+20+40+40+20+40, 100, 100);
                                           
    NSString *string = urlString;
    NSURL *picURL = [NSURL URLWithString:string];
    //从网络获取照片,如果没有就用系统自带占位照片
    [headimageView sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"Add_image"] ];
    headimageView.userInteractionEnabled = YES;//默认为NO，需要改为YES，否则会触发不了手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Add_code)];
        
    [headimageView addGestureRecognizer:tap];
    [VC addSubview:headimageView];
                         
    }
}
//////// 隐藏顶部nav,需要与“   self.navigationController.delegate = self;”一齐使用才可以执行
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是否是自己
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
//
//}


- (void)left
{
    //[self.navigationController popViewControllerAnimated:YES];

           for (UIViewController *controller in self.navigationController.viewControllers) {
               if ([controller isKindOfClass:[Pay_ViewController class]]) {
                   Pay_ViewController *vc =(Pay_ViewController *)controller;
                   [self.navigationController popToViewController:vc animated:YES];
       //            直接调用MyViewController里面的加载数据的方法即isRefreshData
                   [vc begin];//POP回去刷新页面
       //            若是需要传值的直接属性
                  // vc.name = @"你好！帅哥";
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
-(void)Add_code
{
 
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
               
         self->HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
         self->HUD.label.text = @"未连接服务器";
         self->HUD.minSize = CGSizeMake(100, 10);
         self->HUD.contentColor = [UIColor whiteColor];
         self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
         self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
         [MBProgressHUD hideHUDForView:self.view animated:YES];
                
          return;
         }];
    
}
-(void)phpto
{

        
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
//用户取消退出picker时候调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   // NSLog(@"%@",picker);
    //NSLog(@"取消");
    [picker dismissViewControllerAnimated:YES completion:^{
         
//                    [self.tableVA removeFromSuperview];
//                    [self.tableVA.layer removeFromSuperlayer];
//
//                      // _tableV=nil;
//                    [self ShareaA];
    }];
}
//用户选中图片之后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
     //NSLog(@"选中");
    
    //UIImagePickerControllerEditedImage//获取编辑后的照片
    //UIImagePickerControllerOriginalImage//获取原始照片
    UIImage *userImage = [self fixOrientation:[info objectForKey:@"UIImagePickerControllerEditedImage"]];
    //缩放图片
    userImage = [self scaleImage:userImage toScale:0.3];
    //保存图片到沙盒的文件名，单独图片
    //[self saveImage:userImage name:@"face_img"];


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
   
    

    
//    //------公用刷新页面
    [picker dismissViewControllerAnimated:YES completion:^{

//          [self.tableVA removeFromSuperview];
//          [self.tableVA.layer removeFromSuperlayer];
//
//          // _tableV=nil;
//          [self ShareaA];
//          //NSLog(@"刷新");
         [self up_pic];//回调重新加载二维码图片

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
//将头像图片上传到服务器
- (void)upDateHeadIcon:(UIImage *)photo
{
    
    _Acar_name = username.text;
    _Acar_num = Lastname.text;
    //[self CheckNet];//网络超时
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //设置服务器允许的请求格式内容
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *api_url = [NSString stringWithFormat:@"pay_api.php"];
    NSString *urlString =[APIURL stringByAppendingString:api_url];

    
    
    // fromData: AFN封装好的http header类，可以添加请求体
    [session POST:urlString parameters:@{@"username":_pay_username,@"car_name":username.text,@"car_num":Lastname.text,@"pay":_pay_name_type} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
            
            UIImage *image = self->_urlimg;
            NSData *fileData = UIImageJPEGRepresentation(image, 0.1);//压缩系数
            //NSLog(@"upload image size: %ld k", (long)(fileData.length / 1024));
        
            // 随机生成图片名字
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"upload_qcode/%@.jpg", str];
        
            //头像文件名外网路径保存在沙盒----开始
            NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documents = [array lastObject];
            NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
            NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
        
            if ([self->_pay_name_type isEqualToString:@"支付宝"]) {
            [dic_notice setObject:fileName forKey:@"alipay"];
            [dic_notice setObject:self->_Acar_name forKey:@"A_car_name"];
            [dic_notice setObject:self->_Acar_num forKey:@"A_car_num"];
             } else {
            [dic_notice setObject:fileName forKey:@"weixin"];
            [dic_notice setObject:self->_Acar_name forKey:@"W_car_name"];
            [dic_notice setObject:self->_Acar_num forKey:@"W_car_num"];
             }
            
            
          
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
- (void)Aupdata
{
     // [session POST:urlString parameters:@{@"username":_pay_username,@"car_name":username.text,@"car_num":Lastname.text}
        
        _Acar_name = username.text;
        _Acar_num = Lastname.text;
        //NSLog(@"===%@",_Acar_name);
        //创建session对象
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *UserApi=APIURL_USER;
           
        NSURL *url = [NSURL URLWithString:UserApi];
        NSString * Urladd =[NSString stringWithFormat:@"action=add_pay&username=%@&car_name=%@&car_num=%@&pay_url=%@&pay=%@",_pay_username,username.text,Lastname.text,_pay_url,_pay_name_type];  //
        
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
                    // NSLog(@"%@",dict);
                                       
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
                       

                         //头像文件名外网路径保存在沙盒----开始
                         NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                         NSString *documents = [array lastObject];
                         NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
                         NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
                         
                         if ([self->_pay_name_type isEqualToString:@"支付宝"])
                         {
                         
                         [dic_notice setObject:self->_pay_url forKey:@"alipay"];
                         [dic_notice setObject:self->_Acar_name forKey:@"A_car_name"];
                         [dic_notice setObject:self->_Acar_num forKey:@"A_car_num"];
                         }
                         else
                         {
                         [dic_notice setObject:self->_pay_url forKey:@"weixin"];
                         [dic_notice setObject:self->_Acar_name forKey:@"W_car_name"];
                         [dic_notice setObject:self->_Acar_num forKey:@"W_car_num"];
                         }
                        // [dic_notice setObject:self->username.text forKey:@"car_name"];
                         //[dic_notice setObject:self->Lastname.text forKey:@"car_num"];
                         //准备要添加存入的字典
                         [dic_notice writeToFile:documnetPath atomically:YES];
                         //-----------结束
                         //NSLog(@"成功==%@",status);
                         //NSLog(@"成功代码==%@",code);
                     
                                         

                                
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
           
          

    }

-(void)Action
{
    
    if ([username.text isEqualToString:@""] ) {
                   
          HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
          HUD.label.text = @"名不能为空！";
          // HUD.minSize = CGSizeMake(100, 10);
          HUD.contentColor = [UIColor whiteColor];
          HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
          HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
          [MBProgressHUD hideHUDForView:self.view animated:YES];
                
          return;
           
       }
       
       if ([Lastname.text isEqualToString:@""] ) {
                   
          HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
          HUD.label.text = @"姓不能为空！";
          // HUD.minSize = CGSizeMake(100, 10);
          HUD.contentColor = [UIColor whiteColor];
          HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
          HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
          [MBProgressHUD hideHUDForView:self.view animated:YES];
                
          return;
           
       }
   
     if  (_pay_url == NULL || [_pay_url isEqualToString:@""]) {
                
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
        HUD.label.text = @"二维码不能为空！";
        // HUD.minSize = CGSizeMake(100, 10);
        HUD.contentColor = [UIColor whiteColor];
        HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
        HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
        [MBProgressHUD hideHUDForView:self.view animated:YES];
             
        return;
        
    }
    

   [self CheckNet];
    
}
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
         
          self->HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          self->HUD.label.text = @"提交成功";
          self->HUD.contentColor = [UIColor whiteColor];
          self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
          
             
             
          dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
          dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
          [self Aupdata];//提交事件
          [self left];//返回事件
          [MBProgressHUD hideHUDForView:self.view animated:YES];
                   
               });
                      
          return;

             
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //  NSLog(@"请求失败");
           self->HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
           //HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
           self->HUD.label.text = @"未连接服务器";
           self->HUD.minSize = CGSizeMake(100, 10);
           self->HUD.contentColor = [UIColor whiteColor];
           self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
           self->HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
           [MBProgressHUD hideHUDForView:self.view animated:YES];
            
           return;
        }];
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
   //点击空白处隐藏键盘
-(void)KeyBoardHide_Yc
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [username resignFirstResponder];
    [Lastname resignFirstResponder];
    [code resignFirstResponder];
 
}
-(void)pay_del{
        //NSLog(@"dell");
        //头像文件名外网路径保存在沙盒----开始
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [array lastObject];
        NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
        NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
    
        if ([self->_pay_name_type isEqualToString:@"支付宝"]) {
          [dic_notice removeObjectForKey:@"alipay"];
          [dic_notice removeObjectForKey:@"A_car_name"];
          [dic_notice removeObjectForKey:@"A_car_num"];
        }else if([self->_pay_name_type isEqualToString:@"微信"]){
          [dic_notice removeObjectForKey:@"weixin"];
          [dic_notice removeObjectForKey:@"W_car_name"];
          [dic_notice removeObjectForKey:@"W_car_num"];
        }
        [dic_notice writeToFile:documnetPath atomically:YES];
        [self del_pay];
    
        
}
-(void)del_pay{
    
            //NSLog(@"%@",_id);
            //创建session对象
            NSURLSession *session = [NSURLSession sharedSession];
            NSString *UserApi=APIURL_USER;
               
            NSURL *url = [NSURL URLWithString:UserApi];
            NSString * Urladd =[NSString stringWithFormat:@"action=del_pay&id=%@",_id];
            
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

                    // JSON数据格式解析
                    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                          //登陆状态，返回failure或success
                          //1001 登陆成功 ，1002 登陆失败 ， 1003 注册失败/已存在同名 ，1004 注册成功
                          NSString *status = [dict objectForKey:@"status"];
                          NSString *code =[dict objectForKey:@"code"];
                          //SLog(@"==%@",dict);
                        

                          if ([status isEqualToString:@"failure"]) {
                              
                              NSLog(@"失败==%@",status);
                              NSLog(@"失败代码==%@",code);
                              

    
                                        
                                       
                          } else {
                              //NSLog(@"成功==%@",status);
                              //NSLog(@"成功代码==%@",code);
                              

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
                  
                 //开始任务

               
                 [task resume];
    
    
               self->HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
               self->HUD.label.text = @"成功解绑";
               self->HUD.contentColor = [UIColor whiteColor];
               self->HUD.bezelView.backgroundColor = [UIColor colorWithRed:86.0/255 green:103.0/255 blue:162.0/255 alpha:0.8];
               
                  
                  
               dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);//数字为时间延时
               dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
               [self left];//返回事件
               [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                    });
                           
               return;

    
}

@end
