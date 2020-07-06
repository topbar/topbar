//
//  News_NS.h
//  topbar
//
//  Created by topbar on 2019/9/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface News_NS : NSObject

//----
//以下变量部份存在共用
//---
@property (nonatomic, strong) NSString *id; //新闻ID
@property (nonatomic, strong) NSString * Title;
@property (nonatomic,retain)  NSString * Edittime;//
@property (nonatomic,retain)  NSString * Psizes;//
@property (nonatomic,retain)  NSString * Lable;//
@property (nonatomic,retain)  NSString * Authors;//
@property (nonatomic,retain)  NSString * FirstPics;//

//订单list
@property (nonatomic,retain)  NSString * buy_sale_type;//购买/出售
@property (nonatomic,retain)  NSString * btc_type;//币种
@property (nonatomic,retain)  NSString * type;//撤销、成交
@property (nonatomic,retain)  NSString * date;//
@property (nonatomic, strong) NSString * vol;
@property (nonatomic,retain)  NSString * total;//
@property (nonatomic,retain)  NSString * m_anther;//商家名别名
@property (nonatomic,retain)  NSString * m_name;//登陆名
//pub下一页详细订单内容需要
@property (nonatomic,retain)  NSString * pri;//
@property (nonatomic,retain)  NSString * pay_type;//支付方式
@property (nonatomic,retain)  NSString * pay_name;//帐号名
@property (nonatomic,retain)  NSString * pay_num;//帐号号码
@property (nonatomic,retain)  NSString * order_num;//订单号码








@end

NS_ASSUME_NONNULL_END
