//
//  Hy_chusou_con_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/3/11.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction_NS.h"
#import "Transaction_TableViewCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
NS_ASSUME_NONNULL_BEGIN

@interface Hy_chusou_con_ViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>
{
    

    NSInteger currentPage;//分页
    MBProgressHUD * HUD;
    
    
}
@property (nonatomic,retain) UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *dataArr;
@property (strong,nonatomic)NSString * type;//新闻类型
@property (strong,nonatomic)NSString * titlea;

@property (strong,nonatomic)NSString * typeA;//沙盒用户是否登陆

@end

NS_ASSUME_NONNULL_END
