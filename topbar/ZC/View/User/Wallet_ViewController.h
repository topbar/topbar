//
//  Wallet_ViewController.h
//  topbar
//
//  Created by topbar on 2019/11/14.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "Pop-ups.h"

NS_ASSUME_NONNULL_BEGIN

@interface Wallet_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    
    MBProgressHUD * HUD;//提示器
    //int Mobi_lengt;//用户输入字数的长度
    Pop_ups * PopView;
 
}
@property (nonatomic,strong) UITableView *tableV;
//修改邮箱
@property (nonatomic ,strong) NSString * Email;



@end

NS_ASSUME_NONNULL_END
