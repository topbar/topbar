//
//  News_TableViewCell.m
//  topbar
//
//  Created by topbar on 2019/9/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "News_TableViewCell.h"

@implementation News_TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        if ([UIScreen mainScreen].bounds.size.width >= 375)
            
        {
            
         
            //标题
            //_Title = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, self.bounds.size.width-(self.bounds.size.width/4), 58.666)];
            _Title = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.bounds.size.width-(self.bounds.size.width/4), 58.666)];
            
            // _line.backgroundColor = [UIColor colorWithRed:50.0/255 green:146.0/255 blue:204.0/255 alpha:1];
            // _title.backgroundColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
            _Title.textColor =  [UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1];
            _Title.font= [UIFont systemFontOfSize:16];
            _Title.textAlignment = NSTextAlignmentLeft;
            _Title.numberOfLines = 2;
            
            [self addSubview:_Title];
            
            //公告
            //_Title = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, self.bounds.size.width-(self.bounds.size.width/4), 58.666)];
            _Announcement_Title = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth-70, 58.666)];
            
            // _line.backgroundColor = [UIColor colorWithRed:50.0/255 green:146.0/255 blue:204.0/255 alpha:1];
            // _title.backgroundColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
            _Announcement_Title.textColor =  [UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1];
            _Announcement_Title.font= [UIFont systemFontOfSize:16];
            _Announcement_Title.textAlignment = NSTextAlignmentLeft;
            _Announcement_Title.numberOfLines = 2;
            
            [self addSubview:_Announcement_Title];
            
            
            //公告时间
            // _Edittime = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-(self.bounds.size.width/3), 50, 80, 50)];
            _Announcement_date = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 200, 50)];
            
            _Announcement_date.font = [UIFont systemFontOfSize:12];
            _Announcement_date.textColor= [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
            // _timeA.textColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
            _Announcement_date.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_Announcement_date];
            
            
            //时间
            // _Edittime = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-(self.bounds.size.width/3), 50, 80, 50)];
            _Edittime = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/4, 50, 80, 50)];
            
            _Edittime.font = [UIFont systemFontOfSize:12];
            _Edittime.textColor= [UIColor grayColor];
            // _timeA.textColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
            _Edittime.textAlignment = NSTextAlignmentRight;
            [self addSubview:_Edittime];
            
        } else {
            //标题
            _Title = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, self.bounds.size.width-(self.bounds.size.width/2.6), 58.666)];
            // _line.backgroundColor = [UIColor colorWithRed:50.0/255 green:146.0/255 blue:204.0/255 alpha:1];
            // _title.backgroundColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
            _Title.textColor =  [UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1];
            _Title.font= [UIFont systemFontOfSize:16];
            _Title.textAlignment = NSTextAlignmentLeft;
            _Title.numberOfLines = 0;
            
            [self addSubview:_Title];
            
            //时间
            _Edittime = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-(self.bounds.size.width/3.4), 50, 80, 50)];
            
            _Edittime.font = [UIFont systemFontOfSize:12];
            _Edittime.textColor= [UIColor grayColor];
            // _timeA.textColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
            _Edittime.textAlignment = NSTextAlignmentRight;
            [self addSubview:_Edittime];
            
        }
        
   
        
        //标签
        // _Lable = [[UILabel alloc]initWithFrame:CGRectMake(120, 50, self.bounds.size.width-100, 50)];
        _Lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, self.bounds.size.width-100, 50)];
        _Lable.font = [UIFont systemFontOfSize:14];
         _Lable.textColor= [UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:0.5];
        //_Lable.textColor =  [UIColor colorWithRed:221.0/255 green:51.0/255 blue:43.0/255 alpha:1];
        _Lable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_Lable];
        

        
        //缩略图
        // _FirstPics =[[UIImageView alloc]initWithFrame:CGRectMake(10, 11.67, 100, 66.666)];
        _FirstPics =[[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-(self.bounds.size.width/6), 11.67, 100, 66.666)];
        // _FirstPics.layer.cornerRadius =5.0; //圆角
        // _FirstPics.layer.masksToBounds = YES;
        [self addSubview:_FirstPics];
        

        

    }
    return self;
}


@end
