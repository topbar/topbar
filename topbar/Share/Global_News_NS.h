//
//  Global_News_NS.h
//  topbar
//
//  Created by guo feng zou on 2019/12/16.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Global_News_NS : NSObject
@property (nonatomic, strong) NSString *id; //ID

//@property (nonatomic,retain)  NSString * high;  //最高价
//@property (nonatomic,retain)  NSString * low;   //最低价
//@property (nonatomic, strong) NSString * buy;   //买一价
//@property (nonatomic,retain)  NSString * sell;  //卖一价
@property (nonatomic,retain)  NSString * symbol;   //货币名称
@property (nonatomic,retain)  NSString * logo_png; //
@property (nonatomic,retain)  NSString * market_cap_usd;   //流通市值（单位：美元）
@property (nonatomic,retain)  NSString * price_usd;  //实时价/最新成交价/美金价
@property (nonatomic,retain)  NSString * price_btc;  //实时价/BTC价格
@property (nonatomic,retain)  NSString * price_cny;   //实时人民币
@property (nonatomic,retain)  NSString * percent_change_24h; //24小时涨跌幅


@end

NS_ASSUME_NONNULL_END
