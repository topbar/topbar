//
//  TopbarTimerPickerView.m
//  topbar
//
//  Created by guo feng zou on 2019/11/17.
//  Copyright © 2019 guo feng zou. All rights reserved.
//时间选择器

#import "TopbarTimerPickerView.h"
#define ToobarHeight 44
#define RED_COLOR [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:1]
//
//#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface TopbarTimerPickerView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *defaulDate;
@property (nonatomic, assign) BOOL isHaveNavControler;
@property (nonatomic, assign) NSInteger pickeviewHeight;
@property (nonatomic, copy) NSString *resultString;
@property (nonatomic, assign) NSInteger indexRow;
@property (nonatomic, strong) NSDateFormatter *dateFormatterNew;

@end

@implementation TopbarTimerPickerView

- (instancetype)initDatePickWithDate:(NSDate *)defaulDate
                      datePickerMode:(UIDatePickerMode)datePickerMode
                  isHaveNavControler:(BOOL)isHaveNavControler
                        toolbarTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        _defaulDate = defaulDate;
        [self setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode];
        [self setUpToolBar];
        [self setFrameWith:isHaveNavControler];
        [self setToolBarLabel:title];
    }
    return self;
}

- (void)setToolBarLabel:(NSString *)title
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, ScreenWidth-100, ToobarHeight-0.5)];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textAlignment = 1;
    [_toolbar addSubview:label];
}
//阴影
- (void)setFrameWith:(BOOL)isHaveNavControler
{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
   // self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disTapGesture)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    
}

- (void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode
{
    _dateFormatterNew = [[NSDateFormatter alloc] init];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.datePickerMode = datePickerMode;
    
    datePicker.backgroundColor = [UIColor whiteColor];
    if (_defaulDate) {
        [datePicker setDate:_defaulDate];
    }
    _datePicker = datePicker;
    
    datePicker.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 216);
    
    [UIView animateWithDuration:0.5 animations:^{//由上至上弹出
    CGFloat toolViewW = ScreenWidth;
    datePicker.frame = CGRectMake(0, ScreenHeight-datePicker.frame.size.height, toolViewW, datePicker.frame.size.height);
        self->_pickeviewHeight = datePicker.frame.size.height;
          } completion:nil];
    //NSLog(@"%ld", (long)_pickeviewHeight);
    [self addSubview:datePicker];
}

- (void)setUpToolBar
{
    _toolbar = [self setToolbarStyle];
    [self setToolbarWithPickViewFrame];
    
    _toolbar.barTintColor = RED_COLOR;
    _toolbar.tintColor = [UIColor whiteColor];
    
    [self addSubview:_toolbar];
}

- (UIToolbar *)setToolbarStyle
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    
    UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定  " style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    toolbar.items = @[lefttem, centerSpace, right];
    return toolbar;
}

- (void)setToolbarWithPickViewFrame
{
    [_toolbar setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 216)];
    [UIView animateWithDuration:0.5 animations:^{//由上至上弹出
    CGFloat toolViewX = 0;
    CGFloat toolViewH = ToobarHeight;
    CGFloat toolViewY = ScreenHeight - (self->_pickeviewHeight + ToobarHeight);
    CGFloat toolViewW = ScreenWidth;
    self->_toolbar.frame = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);
       
    } completion:nil];
}

- (void)remove
{
    
    [_toolbar setFrame:CGRectMake(0, ScreenHeight - 216, ScreenWidth, 216)];
    [UIView animateWithDuration:0.1f  animations:^{
         self.alpha = 0.0;
         [self->_toolbar setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 216)];
          }
      completion:^(BOOL finished){
       [self removeFromSuperview];
       
    }];
}

- (void)show
{
   
 
    [[UIApplication sharedApplication].keyWindow addSubview:self];
  
}

- (void)doneClick
{
    [_dateFormatterNew setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
    _resultString = [NSString stringWithFormat:@"%@",[_dateFormatterNew stringFromDate:_datePicker.date]];
    if ([self.delegate respondsToSelector:@selector(toobarDonBtnHaveClick:resultString:atIndexof:)]) {
        [self.delegate toobarDonBtnHaveClick:self resultString:_resultString atIndexof:_indexRow];
    }
    [self removeFromSuperview];
}

- (void)setDatePickerDateFormat:(NSString *)dateString {
    [_dateFormatterNew setDateFormat:dateString];
}

- (void)disTapGesture
{
    [self remove];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:_toolbar]) {
        return NO;
    }
    return YES;
}


@end
