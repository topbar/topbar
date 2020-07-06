//
//  order_TableViewCell.m
//  topbar
//
//  Created by topbar on 2020/4/14.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "order_TableViewCell.h"

@implementation order_TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        @property (nonatomic,retain)  NSString * buy_sale_type;//购买/出售
//        @property (nonatomic,retain)  NSString * btc_type;//币种
//        @property (nonatomic,retain)  NSString * type;//撤销、成交
//        @property (nonatomic,retain)  NSString * date;//
//        @property (nonatomic, strong) NSString * vol;
//        @property (nonatomic,retain)  NSString * total;//
//        @property (nonatomic,retain)  NSString * m_anther;//商家名别名
//        @property (nonatomic,retain)  NSString * m_name;//登陆名
        _buy_sale_type = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 10, 50, 20)];
        //[_buy_sale_type setText:@"USDT"];
        _buy_sale_type.textColor = [UIColor colorWithRed:38/255 green:129.1/255 blue:212.0/255 alpha:1];
        _buy_sale_type.font = [UIFont systemFontOfSize:16];
        [self addSubview:_buy_sale_type];
        
        _btc_type = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20+36, 10, 50, 20)];
        //[_buy_sale_type setText:@"USDT"];
        _btc_type.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1];
        _btc_type.font = [UIFont systemFontOfSize:16];
        [self addSubview:_btc_type];
        
        
        _type = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18+60), 10, 60, 13)];
        _type.font = [UIFont systemFontOfSize:14];
        _type.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
        [self addSubview:_type];
        
        _back = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18+2), 10, 6.5, 13)];
        //_back.image =[UIImage imageNamed:@"app_back_btn_F"];
        [self addSubview:_back];
        
        UILabel * time = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 40, 40, 20)];
        [time setText:@"时间"];
        time.font = [UIFont systemFontOfSize:12];
        time.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
        [self addSubview :time];
               
        _date = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 65, 100, 20)];
        //[_date setText:@"0.00122551"];
        _date.font = [UIFont systemFontOfSize:14];
        _date.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
        [self addSubview :_date];
        
        _m_anther = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 90, 100, 20)];
        _m_anther.font = [UIFont systemFontOfSize:14];
        _m_anther.textColor = [UIColor blackColor];
        [self addSubview :_m_anther];
        
        
        
        _volA = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3+30, 40, 70, 20)];
        //[_volA setText:@"数量(BTC)"];
        _volA.font = [UIFont systemFontOfSize:12];
        _volA.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
        [self addSubview :_volA];
               
        _vol= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3+30, 65, 100, 20)];
        _vol.font = [UIFont systemFontOfSize:14];
        _vol.textColor = [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.4];
        [self addSubview:_vol];
        
        UILabel * Tatol = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18+80), 40, 100, 20)];
        [Tatol setText:@"交易总额(CNY)"];
        Tatol.font = [UIFont systemFontOfSize:12];
        Tatol.textColor = [UIColor colorWithRed:204.0/255 green:204.1/255 blue:204.0/255 alpha:1];
        [self addSubview :Tatol];
        
        _total = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18+100), 65, 100, 20)];
        //[_total setText:@"0.00"];
        _total.textAlignment = NSTextAlignmentRight;
        _total.font = [UIFont systemFontOfSize:14];
        _total.textColor = [UIColor colorWithRed:110.0/255 green:132.1/255 blue:152.0/255 alpha:0.8];;
        [self addSubview:_total];
    }
    return self;
}


@end
