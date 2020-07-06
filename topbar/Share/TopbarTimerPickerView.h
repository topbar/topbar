//
//  TopbarTimerPickerView.h
//  topbar
//
//  Created by guo feng zou on 2019/11/17.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TopbarTimerPickerView;

@protocol TopbarTimerPickerViewDelegate <NSObject>
@optional
- (void)toobarDonBtnHaveClick:(TopbarTimerPickerView *)pickView
                 resultString:(NSString *)resultString
                    atIndexof:(NSInteger)indexRow;
- (void)toobarCancelBtn;

@end

@interface TopbarTimerPickerView : UIView

@property (nonatomic, weak) id <TopbarTimerPickerViewDelegate> delegate;

/**
 *  通过时间创建一个DatePicker
 *
 *  @param defaulDate               默认选中时间
 *  @param isHaveNavControler       是否在NavControler之内
 *
 *  @return 带有toolbar的datePicker
 */
- (instancetype)initDatePickWithDate:(NSDate *)defaulDate
                      datePickerMode:(UIDatePickerMode)datePickerMode
                  isHaveNavControler:(BOOL)isHaveNavControler
                        toolbarTitle:(NSString *)title;

/**
 *   移除本控件
 */
- (void)remove;

/**
 *  显示本控件
 */
- (void)show;

/*
 * 设置日期格式
 */
- (void)setDatePickerDateFormat:(NSString *)dateString;
@end

NS_ASSUME_NONNULL_END
