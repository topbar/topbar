//
//  News_TableViewCell.h
//  topbar
//
//  Created by topbar on 2019/9/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface News_TableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *Title;//
@property (nonatomic, strong) UILabel *Edittime;//
@property (nonatomic, strong) UILabel *Lable;//
@property (nonatomic, strong) UIImageView * FirstPics;//
@property (nonatomic, strong) NSString * ID;//
//公告LIST
@property (nonatomic, strong) UILabel * Announcement_Title;//
@property (nonatomic, strong) UILabel * Announcement_date;//

@end

NS_ASSUME_NONNULL_END
