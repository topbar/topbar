//
//  news_list_h5_A_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/3/10.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface news_list_h5_A_ViewController : UIViewController
@property (nonatomic,strong) NSString *news_id;//传递新闻ID
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong)  WKWebView *wkwebView;


//进度条
@property(nonatomic,strong)UIProgressView *progressView;

@end

NS_ASSUME_NONNULL_END
