//
//  Pop-ups.h
//  topbar
//
//  Created by guo feng zou on 2019/11/21.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnTextBlock)(NSString * _Nullable text);//为整个Block函数定义了一个新名字ReturnTextBlock，方便后面的使用

NS_ASSUME_NONNULL_BEGIN

@interface Pop_ups : UIView
@property (nonatomic,strong) ReturnTextBlock block;  //定义一个Block属性
@property (nonatomic,strong) UITextField * VEmail;

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
