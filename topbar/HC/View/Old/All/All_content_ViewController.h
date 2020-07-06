//
//  All_content_ViewController.h
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
#import "SDCycleScrollView.h"


NS_ASSUME_NONNULL_BEGIN

@interface All_content_ViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,SDCycleScrollViewDelegate>
{
    

    NSInteger currentPage;//分页
    
    
}
@property (nonatomic,retain) UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *dataArr;

//轮播广告
@property (nonatomic,retain)NSMutableArray * Pic_IDs;//
@property (nonatomic,retain)NSMutableArray * Pic_Titles;//
@property (nonatomic,retain)NSMutableArray * Pic_TextFirstPics;//

//新闻
@property (strong,nonatomic)NSString * type;//新闻类型
@property (strong,nonatomic)NSString * titlea;
@end

NS_ASSUME_NONNULL_END
