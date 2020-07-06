//
//  Edit_password_ViewController.h
//  topbar
//
//  Created by topbar on 2019/11/7.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface Edit_password_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UITextFieldDelegate>
{
    
     UITextField *Old_Password;//原密码
     UITextField *New_Password;//新密码
     UITextField *Confirm_password;//确认密码
     UITextField *Code;//短信认证码
     MBProgressHUD * HUD;//提示器
     int Password_lengt;//用户输入字数的长度
     UIButton * Mmeages;//验证码按钮变换
     NSString * type;//读取沙盒用户登陆状态，以便发送验证码
    
    
}
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) UIView *Foot_tableView;


@end

NS_ASSUME_NONNULL_END
