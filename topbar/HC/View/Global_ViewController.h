//
//  Global_ViewController.h
//  topbar
//
//  Created by topbar on 2019/11/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPageViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface Global_ViewController : UIViewController<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>
@property (nonatomic, strong) XLPageViewController *pageViewController;


@end

NS_ASSUME_NONNULL_END
