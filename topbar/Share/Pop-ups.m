//
//  Pop-ups.m
//  topbar
//
//  Created by guo feng zou on 2019/11/21.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "Pop-ups.h"
@interface Pop_ups()
{
    UIView * popup;
    MBProgressHUD * HUD;//提示器
   
}
@end
@implementation Pop_ups

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initview];
    }
    return self;
}


-(void)initview{
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)]];
    if (popup == nil) {
        popup = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
     
        popup.backgroundColor = [UIColor whiteColor];
        [self addSubview:popup];
        [self Email_Web];
               
    }
}
-(void)Email_Web
{

    
    _VEmail = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-80, 40)];
    _VEmail.backgroundColor = [UIColor whiteColor];
    //[_VEmail becomeFirstResponder];//呼出键盘
    _VEmail.placeholder = @"Messages";
    //_VEmail.layer.cornerRadius = 5.0;//圆角
    //_VEmail.layer.masksToBounds = NO;
    //左空格
    _VEmail.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 60)];
    _VEmail.leftViewMode = UITextFieldViewModeAlways;
    [popup addSubview:_VEmail];

     
    UIButton *SURE  = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth/3, 0, 40, 40)];
    [SURE setTitle:@"提交" forState:(UIControlStateNormal)];
    [SURE setTitleColor:[UIColor colorWithRed:5.0/255 green:33.1/255 blue:89.0/255 alpha:1] forState:UIControlStateNormal];
    SURE.backgroundColor = [UIColor whiteColor];
    [SURE addTarget:self action:@selector(btn_chick) forControlEvents:UIControlEventTouchUpInside];
    [popup addSubview:SURE];
 

}
-(void)btn_chick
{
    if ([_VEmail.text isEqualToString:@""]) {
        HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
        HUD.mode = MBProgressHUDModeText;//只显示文字没有动画效果,去掉会显示动画
        HUD.label.text = @"Messages不能为空";
        //HUD.minSize = CGSizeMake(100, 10);
        HUD.offset = CGPointMake(0, -200);
        HUD.contentColor = [UIColor whiteColor];
        HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
    [MBProgressHUD hideHUDForView:self animated:YES];
        
     
    return;
    }
    
     _block(_VEmail.text);//传递block值到上一级
    [self dismissView];
   
}

//弹窗显示一
- (void)coutomshowInView:(UIView *)view{
    if (!view){
        return;
    }
    [view addSubview:self];
    [popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 216)];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [self->popup setFrame:CGRectMake(0, ScreenHeight - 216, ScreenWidth, 216)];
    } completion:nil];
}
//弹窗显示二
- (void)showInView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:popup];
    [popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 200)];
    popup.backgroundColor = [UIColor colorWithRed:5.0/255 green:86.1/255 blue:198.0/255 alpha:0.7];;
    popup.layer.cornerRadius = 9.0;//圆角
    popup.layer.masksToBounds = NO;
    [UIView animateWithDuration:0.3 animations:^{
    self.alpha = 1.0;
    [self->popup setFrame:CGRectMake(40, ScreenHeight/2-160, ScreenWidth-80, 200)];
        } completion:nil];

    
}

- (void)dismissView{
    [popup setFrame:CGRectMake(40, ScreenHeight/2-160, ScreenWidth-80, 200)];
       [UIView animateWithDuration:0.4f
                        animations:^{
                            self.alpha = 0.0;
                            
                            [self->popup setFrame:CGRectMake(40, ScreenHeight, ScreenWidth-80, 200)];
                        }
                        completion:^(BOOL finished){
                            [self removeFromSuperview];
                            [self->popup removeFromSuperview];
                            
                        }];
     
          
  
}

@end
