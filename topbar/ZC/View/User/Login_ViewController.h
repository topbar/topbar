//
//  Login_ViewController.h
//  topbar
//
//  Created by topbar on 2019/10/21.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Login_ViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>
{
    UITextField *username;//用户名
    UITextField *password;//用户密码
    UITextField *code;//短信验证码
    UITextField *QRcode;//GOOGLE验证码
    MBProgressHUD * HUD;//提示器
    int Username_lengt;//用户输入字数的长度
    UIButton * Mmeages;//验证码按钮变换
    int Password_lengt;//用户输入字数的长度
    int QRcode_lengt;//用户输入字数的长度


  
}
@property (nonatomic,strong) NSString *Json_name;
@property (nonatomic,strong) NSString *Json_pic;
@property (nonatomic,strong) NSString *Json_email;
@property (nonatomic,strong) NSString *Json_tel;
@property (nonatomic,strong) NSString *Json_birthday;
@property (nonatomic,strong) NSString *Json_qrcode;
@property (nonatomic,strong) NSString *Json_qrurl;
@property (nonatomic,strong) NSString *Json_area;
@property (nonatomic,strong) NSString *Json_sex;
@property (nonatomic,strong) NSString *Json_Another;//别名或商家名称
@property (nonatomic,strong) NSString *Json_LimitA;//限额
@property (nonatomic,strong) NSString *face_id;//下载服务器面容状态
@property (nonatomic,strong) NSString *Json_alipay;//支付宝
@property (nonatomic,strong) NSString *Json_weixin;//微信
@property (nonatomic,strong) NSString *Json_car_name;//帐号名
@property (nonatomic,strong) NSString *Json_car_num;//帐号号码
@property (nonatomic,strong) UIView *Share_View;
@property (nonatomic,strong) NSString *Address;
@property (nonatomic,strong) NSString *statusED;//登陆成功失败状态
@property (nonatomic,strong) NSString *codeED;//登陆成功失败状态代码





;


@end

NS_ASSUME_NONNULL_END
