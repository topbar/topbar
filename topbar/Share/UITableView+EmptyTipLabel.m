//
//  UITableView+EmptyTipLabel.m
//  topbar
//
//  Created by guo feng zou on 2020/4/18.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import "UITableView+EmptyTipLabel.h"




@implementation UITableView (EmptyTipLabel)
//第一种方法
- (void) tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [UILabel new];
 
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];

         
 
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}
//第二种方法
- (void)showDataCount:(NSInteger)count{
    if (count > 0) {
        self.backgroundView = nil;
        return;
    }
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    UIImageView *showImageView = [[UIImageView alloc]init];
    showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backgroundView addSubview:showImageView];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor  = [UIColor redColor];
    [backgroundView addSubview:tipLabel];
    
    showImageView.image = [UIImage imageNamed:@"image_noData"];
    tipLabel.text = @"暂无数据";
    ///tipLabel.text = @"网络不可用";
 
//    [showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(backgroundView.mas_centerX);
//        make.centerY.mas_equalTo(backgroundView.mas_centerY).mas_offset(-20);
//    }];
//    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(backgroundView.mas_centerX);
//        make.top.mas_equalTo(showImageView.mas_bottom).mas_offset(30);
//    }];
    
    self.backgroundView = tipLabel;
    

}
@end
