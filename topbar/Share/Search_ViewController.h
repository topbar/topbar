//
//  Search_ViewController.h
//  topbar
//
//  Created by topbar on 2019/10/9.
//  Copyright © 2019 guo feng zou. All rights reserved.
//搜索

#import <UIKit/UIKit.h>
#import "News_NS.h"
#import "MJExtension.h"
#import "News_TableViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"


NS_ASSUME_NONNULL_BEGIN

@interface Search_ViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate,NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>
{
    

    NSInteger currentPage;//分页
    
    
}
@property (nonatomic,retain) UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *dataArr;
@property (strong,nonatomic)NSString * titlea;
@property (strong,nonatomic)NSString * Get_Url_StringaA;
@property (nonatomic,strong)   UISearchBar * searchBar;
//@property (nonatomic,strong)    UITextField *searchField;//搜索关键字
@end

NS_ASSUME_NONNULL_END
