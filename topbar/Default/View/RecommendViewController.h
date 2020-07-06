//
//  RecommendViewController.h
//  topbar
//
//  Created by guo feng zou on 2020/2/26.
//  Copyright © 2020 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "Global_News_NS.h"
#import "Global_News_TableViewCell.h"
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    
        
        MBProgressHUD * HUD;//提示器

   
}
@property (nonatomic,strong) UITableView *tableV;

@property (strong,nonatomic)NSMutableArray *dataArr;

@property (nonatomic,strong) NSString *Key_BTC;

@end

NS_ASSUME_NONNULL_END
