//
//  Default_ViewController.h
//  topbar
//
//  Created by guo feng zou on 2019/9/17.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJExtension.h"
#import "Global_News_NS.h"
#import "Global_News_TableViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface Default_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    
    
        
        MBProgressHUD * HUD;//提示器

   
}
@property (nonatomic,strong) UITableView *tableV;

@property (strong,nonatomic)NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END
