//
//  Transaction_TableViewCell.h
//  topbar
//
//  Created by topbar on 2020/3/23.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Transaction_TableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *username;//
@property (nonatomic, strong) UILabel *pri;//
@property (nonatomic, strong) UILabel *vol;//
@property (nonatomic, strong) UILabel *tatol;//
@property (nonatomic, strong) UILabel * pri_A;//
@property (nonatomic, strong) UILabel * vol_A;//
@property (nonatomic, strong) UIImageView * logo;//
@property (nonatomic, strong) UIImageView * logoA;//
@property (nonatomic, strong) UILabel * logo_text;//
@property (nonatomic, strong) UIImageView * carpic;//
@property (nonatomic, strong) UIImageView * carpicA;//
@property (nonatomic, strong) NSString * ID;//
@property (nonatomic, strong) UILabel * goumai;//购买按钮


@end

NS_ASSUME_NONNULL_END
