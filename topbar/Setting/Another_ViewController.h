//
//  Another_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/3/25.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN

@interface Another_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UITextFieldDelegate>
{
    

     UITextField *Another;//呢称
     UITextField *Code;//短信认证码
     MBProgressHUD * HUD;//提示器
     int Another_lengt;//呢称输入字数的长度
     UIButton * Mmeages;//验证码按钮变换
     NSString * type;//读取沙盒用户登陆状态，以便发送验证码
    
    
}
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) UIView *Foot_tableView;
@property (nonatomic,strong) NSString *Another_type;//上一页传送沙盒是否存左呢称

@end

NS_ASSUME_NONNULL_END
