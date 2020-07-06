//
//  nes_list_h5_ViewController.h
//  topbar
//
//  Created by topbar on 2019/10/8.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface news_list_h5_ViewController : UIViewController
@property (nonatomic,strong) NSString *news_id;//传递新闻ID
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong)  WKWebView *wkwebView;

@end

NS_ASSUME_NONNULL_END
