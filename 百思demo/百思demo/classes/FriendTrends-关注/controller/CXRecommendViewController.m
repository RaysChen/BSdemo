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
#import "CXRecommendUserCell.h"
#import "CXRecommendUser.h"

@interface CXRecommendViewController () <UITableViewDataSource , UITableViewDelegate>

/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 右边的类别数据 */
@property (nonatomic, strong) NSArray *users;

/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end


@implementation CXRecommendViewController

static NSString * const CXCategoryId = @"category";
static NSString * const CXUserId = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件初始化
    [self setupTableView];
    
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


- (void)setupTableView{

    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CXRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:CXCategoryId];
    
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CXRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:CXUserId];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    

    //设置标题
    self.title = @"推荐关注";
    
    //设置背景颜色
    self.view.backgroundColor = CXGlobalBg;




}



#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        return self.categories.count;
    } else { // 右边的用户表格
        return self.users.count;
    }}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        CXRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CXCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // 右边的用户表格
        CXRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:CXUserId];
        cell.user = self.users[indexPath.row];
        return cell;
    }

}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXRecommendCategory *c = self.categories[indexPath.row];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 发送请求给服务器, 加载右侧的数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            self.users = [CXRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            // 刷新右边的表格
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            CXLog(@"%@", error);
        }];
    });
}



@end
