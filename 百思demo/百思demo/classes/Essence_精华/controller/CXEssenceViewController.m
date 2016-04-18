//
//  CXEssenceViewController.m
//  百思demo
//
//  Created by 陈曦 on 16/4/14.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXEssenceViewController.h"
#import "CXTestViewController.h"

@interface CXEssenceViewController ()

@end

@implementation CXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = CXGlobalBg;
    
}


- (void)tagClick
{
    CXLogFunc;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CXTestViewController *vc = [[CXTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
