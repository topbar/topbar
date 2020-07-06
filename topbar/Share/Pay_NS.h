//
//  Pay_NS.h
//  topbar
//
//  Created by guo feng zou on 2020/3/30.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pay_NS : NSObject
@property (nonatomic, strong) NSString * id; //ID
@property (nonatomic, strong) NSString * username;//用户名称
@property (nonatomic,retain)  NSString * type;//微信或支付宝
@property (nonatomic,retain)  NSString * alipay;//
@property (nonatomic,retain)  NSString * weixin;//
@property (nonatomic,retain)  NSString * car_name;//帐号名
@property (nonatomic,retain)  NSString * car_num;//帐号号码

@end

NS_ASSUME_NONNULL_END

