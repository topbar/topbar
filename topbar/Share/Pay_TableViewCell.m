//
//  Pay_TableViewCell.m
//  topbar
//
//  Created by guo feng zou on 2020/3/30.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Pay_TableViewCell.h"

@implementation Pay_TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
       
   

        

        _logo =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/20, 17.5, 15, 15)];
        //_logo.backgroundColor = [UIColor redColor];
        [self addSubview:_logo];
        
        _username = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20+20, 15, 200, 20)];
        _username.textColor = [UIColor blackColor];
        //_username.backgroundColor = [UIColor orangeColor];
        _username.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:_username];

//        UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
//        imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
//        [self addSubview:imageView];

        _vol = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 200, 20)];
        _vol.font = [UIFont systemFontOfSize:16];
        _vol.textColor = [UIColor colorWithRed:127.0/255 green:145.1/255 blue:159.0/255 alpha:1];
        [self addSubview:_vol];
               
        _tatol = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 75, 300, 20)];
        _tatol.font = [UIFont systemFontOfSize:16];
        _tatol.textColor = [UIColor blackColor];
        [self addSubview:_tatol];

        _vol_A = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/3), 15, 110, 20)];
        _vol_A.font = [UIFont systemFontOfSize:14];
        _vol_A.textAlignment = NSTextAlignmentRight;
        _vol_A.textColor = [UIColor colorWithRed:127.0/255 green:145.1/255 blue:159.0/255 alpha:1];;
        [self addSubview:_vol_A];
        
        _pri_A = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/3), 50, 110, 20)];
        _pri_A.font = [UIFont systemFontOfSize:14];
        _pri_A.textAlignment = NSTextAlignmentRight;
        _pri_A.textColor = [UIColor colorWithRed:127.0/255 green:145.1/255 blue:159.0/255 alpha:1];;
        [self addSubview:_pri_A];

        _pri = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/2.9), 75, 117, 20)];
        _pri.font = [UIFont boldSystemFontOfSize:20];
        _pri.textAlignment = NSTextAlignmentRight;
        _pri.textColor = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
        [self addSubview:_pri];
        
        _qr_code =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/9), 75, 20, 20)];
        //_logo.backgroundColor = [UIColor redColor];
        [self addSubview:_qr_code];
        
        _carpic =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/20, 112, 15, 15)];
        [self addSubview:_carpic];
        
//        _goumai = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/3.8), 105, 85, 30)];
//        _goumai.font = [UIFont boldSystemFontOfSize:15];
//        _goumai.textAlignment = NSTextAlignmentCenter;
//        _goumai.backgroundColor = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
//        _goumai.textColor = [UIColor whiteColor];
//        [self addSubview:_goumai];

        

        

    }
    return self;
}

@end
