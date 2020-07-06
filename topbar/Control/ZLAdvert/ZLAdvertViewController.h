//
//  ZLAdvertViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/2/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//  广告链接页

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ZLAdvertViewController : UIViewController

@property (nonatomic,strong)  WKWebView *wkwebView;

//进度条
@property(nonatomic,strong)UIProgressView *progressView;
@end
