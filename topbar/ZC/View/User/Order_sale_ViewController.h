//
//  Order_sale_ViewController.h
//  topbar
//
//  Created by topbar on 2020/4/15.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction_NS.h"
#import "Transaction_TableViewCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UITableView+EmptyTipLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Order_sale_ViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UINavigationControllerDelegate>
{
    

    //NSInteger currentPage;//分页
    MBProgressHUD * HUD;
    
    
}
@property (nonatomic,retain) UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *dataArr;
@property (strong,nonatomic)NSMutableArray *dataArrA;

//@property (strong,nonatomic)NSString * type;//新闻类型
@property (strong,nonatomic)NSString * titlea;
@property (strong,nonatomic)NSString * username;
@property (strong,nonatomic)NSString * Another;//商家名称，别名

@property (strong,nonatomic)NSString * typeA;//沙盒用户是否登陆
@property (strong,nonatomic)NSString * balck_A;//

@property (nonatomic, strong) UIView *headerBackView;
@property (nonatomic, strong) NSString *stus_type;

@end

NS_ASSUME_NONNULL_END
