//
//  CXRecommendViewController.m
//  百思demo
//
//  Created by 陈曦 on 16/4/21.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface CXRecommendViewController ()

@end

@implementation CXRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    
    //设置背景颜色
    self.view.backgroundColor = CXGlobalBg;
    
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        //
        CXLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];

}


@end
