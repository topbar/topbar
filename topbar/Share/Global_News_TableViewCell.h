//
//  Global_News_TableViewCell.h
//  topbar
//
//  Created by guo feng zou on 2019/12/16.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Global_News_TableViewCell : UITableViewCell
@property (nonatomic,retain)  UILabel * symbol;   //货币名称
@property (nonatomic,retain)  UIImageView * logo_png; //
@property (nonatomic,retain)  UILabel * market_cap_usd;   //流通市值（单位：美元）
@property (nonatomic,retain)  UILabel * price_usd;  //实时价/最新成交价/美金价
//@property (nonatomic,retain)  UILabel * price_btc;  //实时价/BTC价格
@property (nonatomic,retain)  UILabel * price_cny;//实时人民币
@property (nonatomic,retain)  UILabel * percent_change_24h; //24小时涨跌幅



@end

NS_ASSUME_NONNULL_END
