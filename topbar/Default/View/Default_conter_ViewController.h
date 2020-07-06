//
//  Default_conter_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/3/3.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJExtension.h"
#import "Global_News_NS.h"
#import "Global_News_TableViewCell.h"
#import "UIImageView+WebCache.h"
NS_ASSUME_NONNULL_BEGIN

@interface Default_conter_ViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>

@property (nonatomic,retain) UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *dataArr;
//货币
@property (strong,nonatomic)NSString * type;//类型
@property (strong,nonatomic)NSString * titlea;

@end

NS_ASSUME_NONNULL_END
