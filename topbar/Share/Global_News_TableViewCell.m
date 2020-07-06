//
//  Global_News_TableViewCell.m
//  topbar
//
//  Created by guo feng zou on 2019/12/16.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "Global_News_TableViewCell.h"

@implementation Global_News_TableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        //----币种LOGO
        _logo_png= [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/20, 21, 20, 20)];
        //_keys.backgroundColor  = [UIColor grayColor];
        //_logo.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:_logo_png];
        
        //----币种名称
        _symbol= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/8, 16, 80, 30)];
        //_keys.backgroundColor  = [UIColor grayColor];
        _symbol.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:_symbol];
        

        
        //总成交量
        _market_cap_usd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 80, 30)];
        _market_cap_usd.font = [UIFont systemFontOfSize:12];
        _market_cap_usd.textColor= [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
        // _timeA.textColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
        //_vol.textAlignment = NSTextAlignmentRight;
        [self addSubview:_market_cap_usd];

 
 
        //---实时价格
        _price_usd = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.2,16, 80, 30)];
        // _line.backgroundColor = [UIColor colorWithRed:50.0/255 green:146.0/255 blue:204.0/255 alpha:1];
        // _title.backgroundColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
        _price_usd.textColor =  [UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1];
        _price_usd.font= [UIFont boldSystemFontOfSize:16];
        _price_usd.textAlignment = NSTextAlignmentLeft;
        _price_usd.numberOfLines = 0;
        [self addSubview:_price_usd];
        
        //实时人民币
        _price_cny = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.2,50, 80, 30)];
        _price_cny.font = [UIFont systemFontOfSize:12];
        _price_cny.textColor= [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
        //_Lable.textColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
        _price_cny.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_price_cny];
        
        //----涨跌百分比
        _percent_change_24h = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.25, 30, 80, 30)];
        _percent_change_24h.textColor =  [UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1];
        //_Upsdowns.backgroundColor = [UIColor orangeColor];
        _percent_change_24h.font= [UIFont systemFontOfSize:16];
        _percent_change_24h.textAlignment = NSTextAlignmentLeft;
        _percent_change_24h.numberOfLines = 0;
        [self addSubview:_percent_change_24h];
        

        
  

        

        

        

    }
    return self;
}


@end
