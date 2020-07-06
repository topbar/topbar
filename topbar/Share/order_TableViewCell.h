//
//  order_TableViewCell.h
//  topbar
//
//  Created by topbar on 2020/4/14.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface order_TableViewCell : UITableViewCell
@property (nonatomic,retain)  UILabel * buy_sale_type;//购买/出售
@property (nonatomic,retain)  UILabel * btc_type;//币种
@property (nonatomic,retain)  UILabel * type;//撤销、成交
@property (nonatomic,retain)  UILabel * date;//
@property (nonatomic, strong) UILabel * vol;
@property (nonatomic,retain)  UILabel * total;//
@property (nonatomic,retain)  UILabel * m_anther;//商家名别名
@property (nonatomic,retain)  UILabel * m_name;//登陆名
@property (nonatomic, strong) UIImageView * back;//
@property (nonatomic,retain)  UILabel * volA;//

@end

NS_ASSUME_NONNULL_END
