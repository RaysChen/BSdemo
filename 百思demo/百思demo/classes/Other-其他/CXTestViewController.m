//
//  CXTestViewController.m
//  百思demo
//
//  Created by 陈曦 on 16/4/18.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXTestViewController.h"

@interface CXTestViewController ()

@end

@implementation CXTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"CXTestViewController";
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = CXRGBColor(200, 100, 50);
    [self.navigationController pushViewController:vc animated:YES];
}



@end
