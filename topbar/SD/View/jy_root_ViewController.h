//
//  jy_root_ViewController.h
//  topbar
//
//  Created by topbar on 2019/12/18.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPageViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface jy_root_ViewController : UIViewController<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>
@property (nonatomic, strong) XLPageViewController *pageViewController;

@end

NS_ASSUME_NONNULL_END
