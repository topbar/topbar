//
//  Transaction_TableViewCell.m
//  topbar
//
//  Created by topbar on 2020/3/23.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "Transaction_TableViewCell.h"

@implementation Transaction_TableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
       
   
//        self.layer.cornerRadius = 10;
//        self.layer.shadowColor = [[UIColor redColor] CGColor];
//        self.layer.shadowOffset = CGSizeMake(0, 0);
//        self.layer.shadowOpacity = 0.5;
//        self.layer.shadowRadius = 5;
        

        _logo =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/22, 13, 24, 24)];
        _logo.backgroundColor = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
        _logo.layer.cornerRadius = _logo.frame.size.width / 2;;
        //将多余的部分切掉
        _logo.layer.masksToBounds = YES;
        [self addSubview:_logo];
        
        //小圆点
        _logoA =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/22+18, 28, 8, 8)];
        _logoA.backgroundColor = [UIColor greenColor];
        //圆形、设置圆角
        _logoA.layer.cornerRadius = _logoA.frame.size.width / 2;;
        //将多余的部分切掉
        //_logoA.layer.masksToBounds = YES;
        //小圆点阴影
        _logoA.layer.shadowColor= [UIColor orangeColor].CGColor;//阴影颜色
        _logoA.layer.shadowOffset= CGSizeMake(0,0);//偏移距离
        _logoA.layer.shadowOpacity=10;//不透明度
        _logoA.layer.shadowRadius=3.0;//半径

        [self addSubview:_logoA];

        //logo上的文字
        _logo_text = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 15, 20, 20)];
        _logo_text.font = [UIFont systemFontOfSize:14];
        //_logo_text.backgroundColor = [UIColor  colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
        _logo_text.textAlignment = NSTextAlignmentCenter;
        _logo_text.textColor = [UIColor whiteColor];
        [self addSubview:_logo_text];
        
        _username = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20+20+5, 15, 200, 20)];
        _username.textColor = [UIColor colorWithRed:22.0/255 green:49.0/255 blue:102.0/255 alpha:1];
        //_username.backgroundColor = [UIColor orangeColor];
        _username.font = [UIFont systemFontOfSize:16];
        [self addSubview:_username];

//        UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/18), 10, 6.5, 13)];
//        imageView.image =[UIImage imageNamed:@"app_back_btn_F"];
//        [self addSubview:imageView];

        _vol = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 50, 200, 20)];
        _vol.font = [UIFont systemFontOfSize:14];
        _vol.textColor = [UIColor colorWithRed:127.0/255 green:145.1/255 blue:159.0/255 alpha:1];
        [self addSubview:_vol];
               
        _tatol = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/20, 75, 300, 20)];
        _tatol.font = [UIFont systemFontOfSize:14];
        _tatol.textColor = [UIColor colorWithRed:127.0/255 green:145.1/255 blue:159.0/255 alpha:1];
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
        
        _carpic =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/20, 112, 15, 15)];
        [self addSubview:_carpic];
        _carpicA =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/20+15+10, 112, 15, 15)];
        [self addSubview:_carpicA];
        
        _goumai = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-(ScreenWidth/3.8), 105, 85, 30)];
        _goumai.font = [UIFont boldSystemFontOfSize:15];
        _goumai.textAlignment = NSTextAlignmentCenter;
        //_goumai.backgroundColor = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1];
        _goumai.textColor = [UIColor whiteColor];
        [self addSubview:_goumai];
        


        

        

    }
    return self;
}

@end
