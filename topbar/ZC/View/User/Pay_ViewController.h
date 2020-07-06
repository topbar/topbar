//
//  Pay_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/3/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pay_NS.h"
#import "Pay_TableViewCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "Pop_rz.h"//弹出微、支付宝等选择
NS_ASSUME_NONNULL_BEGIN

@interface Pay_ViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UINavigationControllerDelegate>
{
  

    UIImageView * imageView;//全屏二维码

    NSInteger currentPage;//分页
    Pop_rz * PopView;
    MBProgressHUD * HUD;//提示器
    NSString * pay_name;//支付方式选择后传值
    
    
}
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) NSMutableAttributedString *attri;
@property (strong,nonatomic) NSMutableArray *dataArr;
@property (strong,nonatomic) NSString *qrcode_url;

//写一个返回刷新方法
-(void)begin;




@end

NS_ASSUME_NONNULL_END
