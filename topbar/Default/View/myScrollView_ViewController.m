//
//  myScrollView_ViewController.m
//  topbar
//
//  Created by guo feng zou on 2020/3/4.
//  Copyright © 2020 guo feng zou. All rights reserved.
// 学习ScrollView

#import "myScrollView_ViewController.h"
#import "MJRefresh.h"

@interface myScrollView_ViewController ()<UIScrollViewDelegate>

//声明全局变量：
@property (nonatomic, strong) UIScrollView *myScrollView;//滚动视图
@property (nonatomic, assign) NSInteger page;//当前页数

@end

@implementation myScrollView_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self myScrollView];
    [self.view addSubview:self.myScrollView];
    //self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}

- (UIScrollView *) myScrollView{


if (!_myScrollView) {

  

UIScrollView *myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];



myScrollView.backgroundColor = [UIColor orangeColor];

myScrollView.delegate = self;
    
    //如果你导入的MJRefresh库不是最新的库，就用下面的方法创建下拉刷新和上拉加载事件

//myScrollView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
//
//myScrollView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];



    //如果你导入的MJRefresh库是最新的库，就用下面的方法创建下拉刷新和上拉加载事件
//myScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
     
     // 设置自动切换透明度(在导航栏下面自动隐藏)
     header.automaticallyChangeAlpha = YES;
     // 隐藏时间
     header.lastUpdatedTimeLabel.hidden = YES;
     // 马上进入刷新状态
     //[header beginRefreshing];
     // 设置header
     myScrollView.mj_header = header;
    



//myScrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];

self.myScrollView = myScrollView;


}

return _myScrollView;

    }





    #pragma mark - 下拉刷新

    - (void)headRefresh{

self.page = 1;

[self getData];
     //   NSLog(@"123");


    }

//
//
//    #pragma mark - 上拉加载
//
//    - (void)footerRefresh{
//
//
//self.page ++;
//
//[self getData];
//
//}





    #pragma mark - 请求数据

    - (void)getData{

//当请求数据成功或失败后，如果你导入的MJRefresh库不是最新的库，就用下面的方法结束下拉刷新和上拉加载事件

//[self.myScrollView.mj_header endRefreshing];
//
//[self.myScrollView.mj_footer endRefreshing];
//
////如果已经加载到最后一页
//
//[self.myScrollView.mj_footer noticeNoMoreData];


        //当请求数据成功或失败后，如果你导入的MJRefresh库是最新的库，就用下面的方法结束下拉刷新和上拉加载事件

[self.myScrollView.mj_header endRefreshing];

[self.myScrollView.mj_footer endRefreshing];


        //如果已经加载到最后一页

[self.myScrollView.mj_footer endRefreshingWithNoMoreData];

    }

@end
