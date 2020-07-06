//
//  Global_conter_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2019/12/16.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJExtension.h"
#import "Global_News_NS.h"
#import "Global_News_TableViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"


NS_ASSUME_NONNULL_BEGIN

@interface Global_conter_ViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>
{
    MBProgressHUD * HUD;
}

@property (nonatomic,retain) UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *dataArr;
//货币
@property (strong,nonatomic)NSString * type;//类型
@property (strong,nonatomic)NSString * titlea;
@property (strong,nonatomic)NSString * Key_BTC;



@end

NS_ASSUME_NONNULL_END
