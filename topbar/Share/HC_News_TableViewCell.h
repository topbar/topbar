//
//  News_TableViewCell.h
//  topbar
//
//  Created by topbar on 2019/9/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HC_News_TableViewCell : UITableViewCell


@property (nonatomic,retain)  UILabel * high;  //最高价
@property (nonatomic,retain)  UILabel * low;   //最低价
@property (nonatomic, strong) UILabel * buy;   //买一价
@property (nonatomic,retain)  UILabel * sell;  //卖一价
@property (nonatomic,retain)  UILabel * last;  //实时价/最新成交价
@property (nonatomic,retain)  UILabel * vol;   //成交量（24小是时
@property (nonatomic,retain)  UILabel * keys;  //货币名称
@property (nonatomic,retain)  UILabel * Upsdowns;  //涨跌百份比
@property (nonatomic,retain)  UILabel * meny;  //实时美金转化
@property (nonatomic,retain)  UILabel * keys_lable;  //小写
@end

NS_ASSUME_NONNULL_END
