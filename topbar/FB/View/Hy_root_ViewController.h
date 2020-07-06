//
//  Hy_root_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/3/11.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPageViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface Hy_root_ViewController : UIViewController<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>
@property (nonatomic, strong) XLPageViewController *pageViewController;
@property (nonatomic, strong) NSString *stus_type;
@property (nonatomic, strong) NSString *block_id;// 电池栏状态,当同一页面需要调用二个以上不同黑白状态栏使用传值
-(void)nav_new;
@end

NS_ASSUME_NONNULL_END
