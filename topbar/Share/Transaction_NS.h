//
//  Transaction_NS.h
//  topbar
//
//  Created by topbar on 2020/3/23.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Transaction_NS : NSObject
@property (nonatomic, strong) NSString * id; //ID
@property (nonatomic, strong) NSString * username;//用户名称
@property (nonatomic,retain)  NSString * Currency;//币种。如：USDT BTC
@property (nonatomic,retain)  NSString * vol;//数量
@property (nonatomic,retain)  NSString * pri;//单价
@property (nonatomic,retain)  NSString * tatol;//总价
@property (nonatomic,retain)  NSString * rzdj;//认证等级
@property (nonatomic,retain)  NSString * Another;//商家名称或别名
@property (nonatomic,retain)  NSString * LimitA;//限额
@property (nonatomic,retain)  NSString * fk_time;//付款时间
@property (nonatomic,retain)  NSString * reg_time;//注册时间
@property (nonatomic,retain)  NSString * conter;//内容
@property (nonatomic,retain)  NSString * alipay;//
@property (nonatomic,retain)  NSString * weixin;//





@end

NS_ASSUME_NONNULL_END
