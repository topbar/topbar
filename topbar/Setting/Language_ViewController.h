//
//  Language_ViewController.h
//  topbar
//
//  Created by topbar on 2019/11/13.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Language_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

{
    
     NSString *Language;
     MBProgressHUD * HUD;//提示器
}
@property (nonatomic,strong) UITableView *tableV;

@end

NS_ASSUME_NONNULL_END
