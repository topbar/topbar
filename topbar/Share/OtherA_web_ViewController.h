//
//  OtherA_web_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/3/10.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MJRefresh.h"
#import <AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN

@interface OtherA_web_ViewController : UIViewController
@property (nonatomic,strong) NSString *news_url;//传递新闻url
@property (nonatomic,strong) NSString *news_Title;//传递新闻标题
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong)  WKWebView *wkwebView;
//进度条
@property(nonatomic,strong)UIProgressView *progressView;
@end

NS_ASSUME_NONNULL_END
