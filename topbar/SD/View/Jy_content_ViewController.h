//
//  Jy_content_ViewController.h
//  topbar
//
//  Created by topbar on 2019/9/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_NS.h"
#import "MJExtension.h"
#import "News_TableViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UITableView+EmptyTipLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Jy_content_ViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>
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
