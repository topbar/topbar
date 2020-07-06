//
//  QRcode_ViewController.h
//  topbar
//
//  Created by topbar on 2019/11/25.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Abouts_ViewController.h"
#import "UIImageView+WebCache.h"


NS_ASSUME_NONNULL_BEGIN

@interface QRcode_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *tableV;

//GOOGLE验证码
@property (nonatomic ,strong) NSString * QRcode;
//GOOGLE二维码地址
@property (nonatomic ,strong) NSString * QRurl;


@end

NS_ASSUME_NONNULL_END
