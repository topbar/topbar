//
//  Order_ViewController.h
//  topbar
//
//  Created by topbar on 2019/11/14.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_NS.h"
#import "MJExtension.h"
//#import "News_TableViewCell.h"
#import "order_TableViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface Order_ViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UINavigationControllerDelegate>
{
    

    NSInteger currentPage;//分页
    
    
}
@property (nonatomic,retain) UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *dataArr;
@property (strong,nonatomic)NSString * type;//新闻类型
@property (strong,nonatomic)NSString * titlea;
@property (strong,nonatomic)NSString * username;//沙盒用户


@end

NS_ASSUME_NONNULL_END
