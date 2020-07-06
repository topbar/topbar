//
//  Order_details_ViewController.h
//  topbar
//
//  Created by topbar on 2020/4/15.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Order_details_ViewController : UIViewController<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    UIImageView * imageView;//全屏二维码
}
//接收上一页订单list
@property (nonatomic,retain)  NSString * buy_sale_type;//购买/出售
@property (nonatomic,retain)  NSString * btc_type;//币种
@property (nonatomic,retain)  NSString * type;//撤销、成交
@property (nonatomic,retain)  NSString * date;//
@property (nonatomic, strong) NSString * vol;
@property (nonatomic,retain)  NSString * total;//
@property (nonatomic,retain)  NSString * m_anther;//商家名别名
@property (nonatomic,retain)  NSString * m_name;//登陆名

@property (nonatomic,retain)  NSString * pri;//
@property (nonatomic,retain)  NSString * pay_type;//支付方式
@property (nonatomic,retain)  NSString * pay_name;//帐号名
@property (nonatomic,retain)  NSString * pay_num;//帐号号码
@property (nonatomic,retain)  NSString * order_num;//订单号码


@property (nonatomic,retain) NSMutableAttributedString *attri;
@property (nonatomic,retain) NSTextAttachment *attch;

@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) UIView *Foot_tableView;
@property (nonatomic, strong) UIView *headerBackView;

@property (nonatomic,retain)  UILabel * Pri_A;
@property (nonatomic,retain)  UILabel * Vol_A;
@property (nonatomic,retain)  UILabel * Tatol_A;
@property (nonatomic,retain)  NSString * qrcode;

@property (nonatomic,retain)  NSString * stus_type;

@end

NS_ASSUME_NONNULL_END
