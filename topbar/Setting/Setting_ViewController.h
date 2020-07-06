//
//  Setting_ViewController.h
//  topbar
//
//  Created by topbar on 2019/9/25.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AFNetworking.h>
#import "UIImageView+WebCache.h"
#import <CoreLocation/CoreLocation.h>//地图定位
#import "ClearCacheTool.h"





NS_ASSUME_NONNULL_BEGIN

@interface Setting_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>
{
     UIImagePickerController *imagePickerController;//调用相册
     NSString *username;//沙盒用户名
     NSString *Sex;//沙盒性别
     NSString *pic;//沙盒头像文件名
     NSString *Currency;//沙盒计价方式
     NSString *Language;//沙盒计价方式
     NSString *Netstatus;//网络状态监听
     NSString *City;//网络状态监听
     NSString *Another;//呢称
    
   
     //UIImage *Face_img;//沙盒头像文件名,单独一个图片文件
     
     MBProgressHUD * HUD;//提示器
    

    
}
@property (nonatomic,strong)  UITableView *tableVA;
@property (nonatomic, strong) UIImage *urlimg;//拍摄/本地相机图片上传到服务器
@property (nonatomic, strong) NSString *urlVideo;//视频上传到服务器
@property(nonatomic,strong)   CLLocationManager *locationManager;//定位

@property (nonatomic, strong) NSString *cachesSize;//计算缓存大小
@property (nonatomic, strong) NSString * Document;//Document文件夹-缓存
@property (nonatomic, strong) NSString * Library; //Library文件夹-缓存
@property (nonatomic, strong) NSString * Caches;//Library/Caches-缓存



@end

NS_ASSUME_NONNULL_END
