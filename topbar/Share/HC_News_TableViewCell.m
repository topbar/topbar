//
//  News_TableViewCell.m
//  topbar
//
//  Created by topbar on 2019/9/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "HC_News_TableViewCell.h"

@implementation HC_News_TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        //----币种名称
        _keys= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 16, 80, 30)];
        //_keys.backgroundColor  = [UIColor grayColor];
        _keys.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:_keys];
        
        //----币种明细
        _keys_lable = [[UILabel alloc]initWithFrame:CGRectMake(44, 0, 60, 30)];
        _keys_lable.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];;
        //_keys_lable.backgroundColor = [UIColor orangeColor];
        _keys_lable.font= [UIFont systemFontOfSize:12];
        //_keys_lable.textAlignment = NSTextAlignmentCenter;
        _keys_lable.numberOfLines = 0;
        [_keys addSubview:_keys_lable];
        
        //总成交量
        _vol = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 80, 30)];
        _vol.font = [UIFont systemFontOfSize:12];
        _vol.textColor= [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
        // _timeA.textColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
        //_vol.textAlignment = NSTextAlignmentRight;
        [self addSubview:_vol];
         
        //----最高价
        _high = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3,16, 80, 30)];
        // _line.backgroundColor = [UIColor colorWithRed:50.0/255 green:146.0/255 blue:204.0/255 alpha:1];
        // _title.backgroundColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
        _high.textColor =  [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
        _high.font= [UIFont systemFontOfSize:12];
        _high.textAlignment = NSTextAlignmentLeft;
        _high.numberOfLines = 0;
        [self addSubview:_high];
        
        //最低价
        _low = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3,50, 80, 30)];
        _low.font = [UIFont systemFontOfSize:12];
        _low.textColor= [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
        //_Lable.textColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
        _low.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_low];
 
 
        //---实时价格
        _last = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.8,16, 80, 30)];
        // _line.backgroundColor = [UIColor colorWithRed:50.0/255 green:146.0/255 blue:204.0/255 alpha:1];
        // _title.backgroundColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
        _last.textColor =  [UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1];
        _last.font= [UIFont boldSystemFontOfSize:16];
        _last.textAlignment = NSTextAlignmentLeft;
        _last.numberOfLines = 0;
        [self addSubview:_last];
        
        //实时美金转换
        _meny = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.8,50, 80, 30)];
        _meny.font = [UIFont systemFontOfSize:12];
        _meny.textColor= [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
        //_Lable.textColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
        _meny.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_meny];
        
        //----涨跌百分比
        _Upsdowns = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/1.25, 30, 60, 30)];
        _Upsdowns.textColor =  [UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1];
        //_Upsdowns.backgroundColor = [UIColor orangeColor];
        _Upsdowns.font= [UIFont systemFontOfSize:16];
        _Upsdowns.textAlignment = NSTextAlignmentCenter;
        _Upsdowns.numberOfLines = 0;
        [self addSubview:_Upsdowns];
        

        
  

        

        

        

    }
    return self;
}


@end
