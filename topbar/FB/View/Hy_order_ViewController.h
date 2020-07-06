//
//  Hy_order_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/4/7.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hy_order_ViewController : UIViewController<UINavigationControllerDelegate,UITextFieldDelegate>
{
  
    @private
       
        
        NSTimer *timer;   //计时器
        NSInteger currentTime; //计时时间，秒
        MBProgressHUD * HUD;
        
        
   
}
@property (strong,nonatomic)  NSString * Currency;//币种
@property (nonatomic,retain)  NSString * pri;//单价
@property (nonatomic,retain)  NSString * LimitA;//限额
@property (nonatomic,retain)  NSString * tatol;//总价
@property (nonatomic,retain)  NSString * vol;//数量
@property (nonatomic,retain)  NSString * username;//用户名
@property (nonatomic,retain)  NSString * Another;//买家/卖家名称
@property (nonatomic,retain)  NSString * KYC;//买家/卖家的认证级别
@property (nonatomic,retain)  NSString * conter;//备注
@property (nonatomic,retain)  NSString * alipay;
@property (nonatomic,retain)  NSString * weixin;
@property (nonatomic,retain)  UITextField * Vol_A;
@property (nonatomic,retain)  UITextField * Tatol_A;

//传参数到下一页
@property (nonatomic,retain)  NSArray * type_S;
@property (nonatomic,retain)  NSArray * car_name_S;
@property (nonatomic,retain)  NSArray * car_num_S;
@property (nonatomic,retain)  NSArray * alipay_S;
@property (nonatomic,retain)  NSArray * weixin_S;

@property (nonatomic,retain)NSString * black_A;

@end



NS_ASSUME_NONNULL_END
