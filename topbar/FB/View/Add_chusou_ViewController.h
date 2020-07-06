//
//  Add_chusou_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/3/11.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "TopbarTimerPickerView.h"
#import "Pop_rz.h"



NS_ASSUME_NONNULL_BEGIN

@interface Add_chusou_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UITextFieldDelegate>
{
    
     UITextField *Pric_type;//定价方式
     UITextField *Pric;//交易价格
     UITextField *Pric_vol;//交易数量
     UITextField *Pric_total;//金额
     UITextField *Fk_time;//付款时间
     UITextField *Rzdj ;//认证等级
     UITextField *Rz_time;//注册时间
     UITextField *Rz_con;//交易说明
    
     MBProgressHUD * HUD;//提示器
     int Pric_vol_lengt;//--交易数量--用户输入字数的长度
     int Pric_lengt;//--交易单价--用户输入字数的长度
 
     NSString * type;//读取沙盒用户登陆状态，以便发送验证码
    
    
     Pop_rz * PopView;
    
    
}
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) UIView *Foot_tableView;
@property (nonatomic,strong) NSString *Apri_total;




//认证等级
@property (nonatomic ,strong) NSString * KYC;




//时间选择器

@property (nonatomic, strong) TopbarTimerPickerView *pickerView;
@property (nonatomic, copy) NSString *timeStr;
//
@property (nonatomic ,strong) NSString * Fk_time_A;


//@property (strong,nonatomic)NSString * typeA;//
@property (strong,nonatomic)NSString * titlea;

@property (strong,nonatomic)NSString * Btn_type;//同一按钮传参数


@end

NS_ASSUME_NONNULL_END
