//
//  CheckNet.h
//  topbar
//
//  Created by topbar on 2019/11/13.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


NS_ASSUME_NONNULL_BEGIN
typedef void(^netStateBlock)(NSInteger netState);
@interface CheckNet : NSObject



/**
 *  网络监测
 *
 *  param block 判断结果回调
 *
 *  return 网络监测
 */
+(void)netWorkState:(netStateBlock)block;

@end

NS_ASSUME_NONNULL_END
