//
//  Add_order_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/4/11.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pop_rz.h"//弹出微、支付宝等选择
#import "UIImageView+WebCache.h"
NS_ASSUME_NONNULL_BEGIN

@interface Add_order_ViewController : UIViewController<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
  
        @private
        NSTimer *timer;   //计时器
        NSInteger currentTime; //计时时间，秒
        Pop_rz * APopView;
        MBProgressHUD * HUD;
        UIImageView * imageView;//全屏二维码


}
@property (strong,nonatomic)  NSString * Currency;//币种
@property (nonatomic,retain)  NSString * pri;//单价
@property (nonatomic,retain)  NSString * LimitA;//限额
@property (nonatomic,retain)  NSString * tatol;//总价
@property (nonatomic,retain)  NSString * vol;//数量
@property (nonatomic,retain)  NSString * username;//用户名
@property (nonatomic,retain)  NSString * Another;//买家/卖家名称
@property (nonatomic,retain)  NSString * KYC;//买家/卖家的认证级别
@property (nonatomic,retain)  NSString * conter;//备注
@property (nonatomic,retain)  NSString * order_num;//订单号
@property (nonatomic,retain)  NSString * text_num;//离开、付款返回的block值

@property (nonatomic,retain)  NSString * alipay;
@property (nonatomic,retain)  NSString * weixin;
@property (nonatomic,retain)  UILabel * Pri_A;
@property (nonatomic,retain)  UILabel * Vol_A;
@property (nonatomic,retain)  UILabel * Tatol_A;


//请求服务器支付方式
@property (nonatomic,retain)  NSString * type;
@property (nonatomic,retain)  NSString * car_name;
@property (nonatomic,retain)  NSString * car_num;
//传参数到下一页
@property (nonatomic,retain)  NSArray * type_S;
@property (nonatomic,retain)  NSArray * car_name_S;
@property (nonatomic,retain)  NSArray * car_num_S;
@property (nonatomic,retain)  NSArray * alipay_S;
@property (nonatomic,retain)  NSArray * weixin_S;


@property (nonatomic,retain)  NSString * qrcode;



@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) UIView *Foot_tableView;
@property (nonatomic, strong) UIView *headerBackView;

@property (nonatomic,retain)  NSString * black_A;
@end

NS_ASSUME_NONNULL_END
