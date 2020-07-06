//
//  Default_root_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/2/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPageViewController.h"
#import "MJRefresh.h"
#import "Pop_rz.h"
#import "SDCycleScrollView.h"//滚动图文或文字
#import "Placard_list_h5_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Default_root_ViewController : UIViewController<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce,UINavigationControllerDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate>
{
    Pop_rz * APopView;
}
@property (nonatomic, strong) XLPageViewController *pageViewController;

@property (nonatomic,strong) UITableView *tableV;

@property (strong,nonatomic)NSMutableArray *dataArr;
@property (nonatomic, strong) NSString *type;//沙盒用户状态
@property (nonatomic, strong) NSString *stus_type;// 电池栏状态
@property (nonatomic, strong) NSString *block_id;// 电池栏状态,当同一页面需要调用二个以上不同黑白状态栏使用传值

@property (nonatomic, strong) NSString *Ad_url;// 启动图片
@property (nonatomic, strong) NSString *Ad_id;// 启动图片ID

//轮播公告
@property (nonatomic,retain)NSMutableArray * IDs;//
@property (nonatomic,retain)NSMutableArray * Titles;//
@property (nonatomic,retain)NSMutableArray * Dates;//



@end

NS_ASSUME_NONNULL_END
