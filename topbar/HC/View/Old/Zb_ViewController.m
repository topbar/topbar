//
//  Zb_ViewController.m
//  topbar
//
//  Created by topbar on 2019/9/25.
//  Copyright © 2019 guo feng zou. All rights reserved.
//
//主板
#import "Zb_ViewController.h"

@interface Zb_ViewController ()

@end

@implementation Zb_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.layer.contents = (id)[UIImage imageNamed:@"test.jpeg"].CGImage;
    // Do any additional setup after loading the view.
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
