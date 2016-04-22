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
#import "CXRecommendCategory.h"
#import "CXRecommendCategoryCell.h"
#import "MJExtension.h"


@interface CXRecommendViewController () <UITableViewDataSource , UITableViewDelegate>
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@end

@implementation CXRecommendViewController

static NSString * const CXCategoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CXRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:CXCategoryId];
    
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
        
        //服务器返回的json数据
       self.categories = [CXRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];

}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CXCategoryId];
    
    cell.category = self.categories[indexPath.row];
    
    return cell;
}


@end
