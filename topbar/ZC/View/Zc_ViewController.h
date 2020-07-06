//
//  Zc_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2019/9/17.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "Setting_ViewController.h"
#import "Abouts_ViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface Zc_ViewController : ViewController<UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate,UINavigationControllerDelegate>
{
    
    MBProgressHUD * HUD;//提示器
}
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) UIView *Foot_tableView;
@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic, strong) UIView *headerBackView;
@property (nonatomic, strong) UIView *mengView;

@property (nonatomic, strong) NSString *username;//json请求的用户
@property (nonatomic, strong) NSString *pic;//json请求的用户头像
@property (nonatomic, strong) NSString *type;//沙盒用户状态
@property (nonatomic,strong) NSString *code;//登陆成功失败状态代码
@property (nonatomic,strong) NSString * Language;//显示沙盒语言

@property (nonatomic, strong) NSString *stus_type;// 电池栏状态





@end

NS_ASSUME_NONNULL_END
