//
//  Pop_rz.h
//  topbar
//
//  Created by guo feng zou on 2020/3/17.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

typedef void(^ReturnTextBlock)(NSString * _Nullable text);//为整个Block函数定义了一个新名字ReturnTextBlock，方便后面的使用
typedef void(^callBackBlock) (NSArray * _Nullable NSArray_text);//传数组的 Block
NS_ASSUME_NONNULL_BEGIN

@interface Pop_rz : UIView

@property (nonatomic,strong) ReturnTextBlock block;  //定义一个Block属性
@property(nonatomic,copy)callBackBlock callBcakBlock; //定义一个Block属性（数组）

@property (nonatomic,strong) UITextField *password;

@property (nonatomic,strong) UITextField * VEmail;

@property (nonatomic,strong) NSString * type;//传值，到底是认证时间还是认证等级，因为调用同一个窗口 0 认证等级（默认）  、1 认证时间
//取上一页数据
@property (nonatomic,retain)  NSArray * type_S;
@property (nonatomic,retain)  NSArray * car_name_S;
@property (nonatomic,retain)  NSArray * car_num_S;
@property (nonatomic,retain)  NSArray * alipay_S;
@property (nonatomic,retain)  NSArray * weixin_S;
@property (nonatomic,strong)  NSString * currentTime;//传时间过来


@property (nonatomic,strong)  NSString * AD_URL;//启动图片地址
@property (nonatomic,strong)  NSString * AD_id;//启动图片地址,对应ID内容
/**
    自己选择显示在那个view展示从底部向上弹出的UIView（包含遮罩）
    @param view self.view OR [UIApplication sharedApplication].keyWindow
 */
-(void)coutomshowInView:(UIView *)view;
/**
    展示从底部向上弹出的UIView（包含遮罩）
 */
-(void)showInView;
/**
 移除从底部向上弹出的UIView（包含遮罩）
 */
-(void)dismissView;
@end

NS_ASSUME_NONNULL_END
