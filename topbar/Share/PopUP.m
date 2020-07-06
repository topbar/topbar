//
//  PopUP.m
//  topbar
//
//  Created by topbar on 2019/11/19.
//  Copyright © 2019 guo feng zou. All rights reserved.
//由底部向上弹出窗口

#import "PopUP.h"
@interface PopUP()
{
    UIView * popup;
    MBProgressHUD * HUD;//提示器
   
}
@end

@implementation PopUP

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

    
    _VEmail = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    _VEmail.backgroundColor = [UIColor whiteColor];
    [_VEmail becomeFirstResponder];//呼出键盘
    _VEmail.placeholder = @"@www.com";
    //左空格
    _VEmail.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 60)];
    _VEmail.leftViewMode = UITextFieldViewModeAlways;
    [popup addSubview:_VEmail];

     
    UIButton *SURE  = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth/6, 0, 40, 60)];
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
        HUD.label.text = @"邮箱不能为空";
        //HUD.minSize = CGSizeMake(100, 10);
        HUD.offset = CGPointMake(0, -100);
        HUD.contentColor = [UIColor whiteColor];
        HUD.minShowTime= 1;/*指示器停留的时间/以秒为做单位*/
    [MBProgressHUD hideHUDForView:self animated:YES];
     
    return;
    }
    

    //打开沙盒
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [array lastObject];
    NSString *documnetPath = [documents stringByAppendingPathComponent:@"UserMesg.plist"];
    NSMutableDictionary *dic_notice = [NSMutableDictionary dictionaryWithContentsOfFile:documnetPath];
    [dic_notice setObject:_VEmail.text forKey:@"Email"];
    _block(_VEmail.text);//传递block值到上一级
    
    //准备要添加存入的字典
    [dic_notice writeToFile:documnetPath atomically:YES];
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
    [popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 216)];
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0;
        [self->popup setFrame:CGRectMake(0, ScreenHeight/2, ScreenWidth, ScreenHeight-216)];
    } completion:nil];
    
}

- (void)dismissView{
    [popup setFrame:CGRectMake(0, ScreenHeight - 216, ScreenWidth, 216)];
    [UIView animateWithDuration:0.1f
                     animations:^{
                         self.alpha = 0.0;
                         
                         [self->popup setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 216)];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [self->popup removeFromSuperview];
                         
                     }];
  
}


@end
