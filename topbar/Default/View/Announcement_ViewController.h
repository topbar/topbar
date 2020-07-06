//
//  Announcement_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/4/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_NS.h"
#import "MJExtension.h"
#import "News_TableViewCell.h"
#import "MJRefresh.h"
#import "UITableView+EmptyTipLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Announcement_ViewController : UIViewController
<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UINavigationControllerDelegate>
{
    

    NSInteger currentPage;//分页
    MBProgressHUD *HUD;
    
    
}
@property (nonatomic,retain) UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *dataArr;
@property (strong,nonatomic)NSString * type;//新闻类型
@property (strong,nonatomic)NSString * titlea;
@end

NS_ASSUME_NONNULL_END
