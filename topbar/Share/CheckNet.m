//
//  CheckNet.m
//  topbar
//
//  Created by topbar on 2019/11/13.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "CheckNet.h"

@implementation CheckNet
#pragma mark----网络检测
+(void)netWorkState:(netStateBlock)block;
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    //检测的结果
    __block typeof(self) bself = self;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //                   AFNetworkReachabilityStatusUnknown          = -1, NSLog(@"未知");
        //                   AFNetworkReachabilityStatusNotReachable     = 0,  NSLog(@"没有网络");
        //                   AFNetworkReachabilityStatusReachableViaWWAN = 1,  NSLog(@"3G|4G");
        //                   AFNetworkReachabilityStatusReachableViaWiFi = 2,  NSLog(@"WiFi");
        if (status == -1) {
            //弹出提示框
            //[bself showWarningView];
            NSLog(@"%@",bself);
            //将netState值传入block中
            block(status);
        }
        if (status == 0) {
            //将netState值传入block中
            block(status);
        }
        if (status == 1) {
            //将netState值传入block中
             block(status);
        }
        if (status == 2) {
            //将netState值传入block中
            block(status);
              
        }
    }];
}


//------------------
//#pragma mark---网络断开时弹出提示框
//+(void)showWarningView
//{
//    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络断开，请检查网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
//    [alter show];
//}
//+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==0) {
//        NSLog(@"取消");
//    }else{
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    }
//}

//------------------另一方法

//            AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
//            [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//              /*
//                   AFNetworkReachabilityStatusUnknown          = -1,
//                   AFNetworkReachabilityStatusNotReachable     = 0,
//                   AFNetworkReachabilityStatusReachableViaWWAN = 1,
//                   AFNetworkReachabilityStatusReachableViaWiFi = 2,
//               */
//                  switch (status) {
//                      case AFNetworkReachabilityStatusUnknown:
//                         // NSLog(@"未知");
//                          self->Netstatus = @"未知";
//                          break;
//                      case AFNetworkReachabilityStatusNotReachable:
//                         // NSLog(@"没有网络");
//                          self->Netstatus = @"没有网络";
//                          break;
//                      case AFNetworkReachabilityStatusReachableViaWWAN:
//                         // NSLog(@"3G|4G");
//                          self->Netstatus = @"4G";
//                          break;
//                      case AFNetworkReachabilityStatusReachableViaWiFi:
//                         // NSLog(@"WiFi");
//                          self->Netstatus = @"WiFi";
//                          break;
//                      default:
//                          break;
//                  }
//
//
//              }];
//           //网络状态监听调用
//           [manger startMonitoring];
@end
