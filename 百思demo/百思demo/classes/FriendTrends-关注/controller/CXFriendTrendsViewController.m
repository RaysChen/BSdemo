//
//  CXFriendTrendsViewController.m
//  百思demo
//
//  Created by 陈曦 on 16/4/14.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXFriendTrendsViewController.h"

@interface CXFriendTrendsViewController ()

@end

@implementation CXFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    //    self.title = @"我的关注";
    //    self.navigationItem.title = @"我的关注";
    //    self.tabBarItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];

    // 设置背景色
    self.view.backgroundColor = CXGlobalBg;
    



}

- (void)friendsClick
{
    CXLogFunc;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = CXRGBColor(200, 100, 50);
    [self.navigationController pushViewController:vc animated:YES];
}

@end
