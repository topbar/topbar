//
//  Topbar_conter_ViewController.h
//  topbar
//
//  Created by topbar on 2019/11/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJExtension.h"
#import "HC_News_NS.h"
#import "HC_News_TableViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "WebSocketManager.h"



NS_ASSUME_NONNULL_BEGIN

@interface Topbar_conter_ViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,getMessageDelegate,UINavigationControllerDelegate>


@property (nonatomic,retain) UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *dataArr;


//货币
@property (strong,nonatomic)NSString * type;//类型
@property (strong,nonatomic)NSString * titlea;
//JSON请求
@property (nonatomic,retain)NSMutableArray * Tkeys;//货币名称
@property (nonatomic,retain)NSMutableArray * Tkeys_con;//货币里的参数
@property (nonatomic,retain)NSMutableArray * SaveData;// 0自选 1QC 2USDT 3BTC 4ZB

//初始Websock
@property (nonatomic,retain)NSArray * Web_tkeys_con;//货币里的参数
@property (strong,nonatomic)NSString * Web_tkey_high;//最高价（24小时)
@property (strong,nonatomic)NSString * Web_tkey_low;//最低价（24小时)
@property (strong,nonatomic)NSString * Web_tkey_last;//实时价
@property (strong,nonatomic)NSString * Web_tkey_vol;//交易量（24小时）


//接收Websock
@property (nonatomic,retain)NSMutableArray * Sock_keys;//货币名称
@property (nonatomic,retain)NSMutableArray * sock_last;//实时价格
@property (nonatomic,retain)NSMutableArray * sock_high;//最高价格（24小时）
@property (nonatomic,retain)NSMutableArray * sock_low;//最低价格(24小时）
@property (nonatomic,retain)NSMutableArray * sock_vol;//交易量（24小时）



@property (nonatomic, strong) WebSocketManager *webSocket;

@property (nonatomic, strong) NSString *Key_BTC;


@end

NS_ASSUME_NONNULL_END
