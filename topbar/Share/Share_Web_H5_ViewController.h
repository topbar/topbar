//
//  Share_Web_H5_ViewController.h
//  topbar
//
//  Created by topbar on 2019/11/4.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface Share_Web_H5_ViewController : UIViewController
@property (nonatomic,strong) NSString *news_url;//传递新闻url
@property (nonatomic,strong) NSString *news_Title;//传递新闻标题
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong)  WKWebView *wkwebView;




@end

NS_ASSUME_NONNULL_END
