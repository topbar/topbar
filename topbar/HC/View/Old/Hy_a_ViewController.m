//
//  Hy_a_ViewController.m
//  topbar
//
//  Created by topbar on 2019/9/25.
//  Copyright © 2019 guo feng zou. All rights reserved.
//合约

#import "Hy_a_ViewController.h"

@interface Hy_a_ViewController ()

@end

@implementation Hy_a_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.contents = (id)[UIImage imageNamed:@"WechatIMG91.jpeg"].CGImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
