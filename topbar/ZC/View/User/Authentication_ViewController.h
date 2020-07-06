//
//  Authentication_ViewController.h
//  topbar
//
//  Created by topbar on 2019/11/4.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Authentication_ViewController : UIViewController<UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UITextField *username;//用户名
    UITextField *Lastname;//用户密码
    UITextField *code;//短信验证码
    MBProgressHUD * HUD;//提示器



  
}

@end

NS_ASSUME_NONNULL_END
