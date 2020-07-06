//
//  Account_ViewController.h
//  topbar
//
//  Created by topbar on 2019/11/4.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopbarTimerPickerView.h"
#import "AddressPickerView.h"
#import "PopUP.h"
#import "Pop_rz.h"//弹出微、支付宝等选择

#define SCREEN [UIScreen mainScreen].bounds.size
NS_ASSUME_NONNULL_BEGIN

@interface Account_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,AddressPickerViewDelegate>
{
    Pop_rz * APopView;
    MBProgressHUD * HUD;//提示器
    //int Mobi_lengt;//用户输入字数的长度
    PopUP * PopView;

}
@property (nonatomic,strong) UITableView *tableV;


//时间选择器

@property (nonatomic, strong) TopbarTimerPickerView *pickerView;
@property (nonatomic, copy) NSString *timeStr;


//地址选择器
@property (nonatomic ,strong) AddressPickerView * AddPickerView;
@property (nonatomic ,strong) NSString * AddressStr;

//修改邮箱
@property (nonatomic ,strong) NSString * Email;

//修改手机
@property (nonatomic ,strong) NSString * Mobi;

//GOOGLE验证码
@property (nonatomic ,strong) NSString * QRcode;

//限额
@property (nonatomic ,strong) NSString * LimitA;

//面容开关
@property (nonatomic ,strong) NSString * UISwitch_type;


//返回页面刷新限额
-(void)LimitA_S;




@end

NS_ASSUME_NONNULL_END
