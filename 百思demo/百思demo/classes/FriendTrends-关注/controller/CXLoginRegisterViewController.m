//
//  CXLoginRegisterViewController.m
//  百思demo
//
//  Created by 陈曦 on 16/5/21.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXLoginRegisterViewController.h"

@interface CXLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@end

@implementation CXLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.bgView atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}
@end
