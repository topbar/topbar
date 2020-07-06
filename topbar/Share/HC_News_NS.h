//
//  News_NS.h
//  topbar
//
//  Created by topbar on 2019/9/27.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HC_News_NS : NSObject
@property (nonatomic, strong) NSString *id; //ID

@property (nonatomic,retain)  NSString * high;  //最高价
@property (nonatomic,retain)  NSString * low;   //最低价
@property (nonatomic, strong) NSString * buy;   //买一价
@property (nonatomic,retain)  NSString * sell;  //卖一价
@property (nonatomic,retain)  NSString * last;  //实时价/最新成交价
@property (nonatomic,retain)  NSString * vol;   //成交量（24小是时）
@property (nonatomic,retain)  NSString * keys;   //货币名称

@end

NS_ASSUME_NONNULL_END
