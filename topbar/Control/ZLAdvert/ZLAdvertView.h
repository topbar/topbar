
//
//  ZLAdvertViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/2/26.
//  Copyright © 2020 guo feng zou. All rights reserved.

#import <UIKit/UIKit.h>

#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height
#define kUserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@interface ZLAdvertView : UIView

/**
*  显示广告页面方法
*/
- (void)show;

/**
 *  图片路径
 */
@property (nonatomic, copy) NSString *filePath;

@end
