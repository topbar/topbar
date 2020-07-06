//
//  UITableView+EmptyTipLabel.h
//  topbar
//
//  Created by guo feng zou on 2020/4/18.
//  Copyright © 2020 guo feng zou. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (EmptyTipLabel)

//添加一个方法
- (void) tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

- (void)showDataCount:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
