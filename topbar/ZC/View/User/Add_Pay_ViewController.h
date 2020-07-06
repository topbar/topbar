//
//  Add_Pay_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/3/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AFNetworking.h>
#import "UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface Add_Pay_ViewController : UIViewController<UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    UITextField *username;//用户名
    UITextField *Lastname;//帐号名称
    UIButton *code;//二维码
    MBProgressHUD * HUD;//提示器
    UIImagePickerController *imagePickerController;//调用相册
    UIView *VC;

  
}
@property (nonatomic, strong) UIImage *urlimg;//拍摄/本地相机图片上传到服务器
@property (nonatomic, strong) NSString *pay_username;//取沙合用户

@property (nonatomic, strong) NSString *pay_url;//取沙合支付宝二维码地址

@property (nonatomic, strong) NSString *Acar_name;//取帐户名
@property (nonatomic, strong) NSString *Acar_num;//取帐号号码

@property (nonatomic, strong) NSString *car_name;//帐号名称
@property (nonatomic, strong) NSString *car_num;//帐号号码
@property (strong,nonatomic)NSString * pay_name_type;//支付方式选择后传值

@property (strong,nonatomic)NSString * id;//传ID

@end

NS_ASSUME_NONNULL_END
