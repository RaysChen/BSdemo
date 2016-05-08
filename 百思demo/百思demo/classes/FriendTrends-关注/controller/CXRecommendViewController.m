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
#import <MJRefresh.h>

#define CXSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface CXRecommendViewController () <UITableViewDataSource , UITableViewDelegate>

/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 右边的类别数据 */
//@property (nonatomic, strong) NSArray *users;

/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 请求参数 */
@property (nonatomic ,strong)NSMutableDictionary *params;
/** AFN请求管理者 */
@property (nonatomic,strong) AFHTTPSessionManager *manager;


@end


@implementation CXRecommendViewController

static NSString * const CXCategoryId = @"category";
static NSString * const CXUserId = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件初始化
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
}


/*
 *加载左侧的类别数据
 */
-(void) loadCategories{
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
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];

        // 让用户表格进入下拉刷新状态
        [self.userTableView.header beginRefreshing];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}



/*
 *控件的初始化
 */

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



/*
 *添加刷新控件
 */
-(void)setupRefresh
{
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.footer.hidden = YES;

}

#pragma mark - 加载用户数据
- (void)loadNewUsers
{
   CXRecommendCategory *rc = CXSelectedCategory;
    
    //设置当前页为1
    rc.currentPage = 1;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    // 发送请求给服务器, 加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [CXRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除所有旧数据
        [rc.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        // 保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.userTableView.header endRefreshing];
    }];

}


- (void)loadMoreUsers
{
    CXRecommendCategory *category = CXSelectedCategory;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [CXRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.userTableView.footer endRefreshing];
    }];
}

/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    CXRecommendCategory *rc = CXSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) { // 全部数据已经加载完毕
        [self.userTableView.footer noticeNoMoreData];
    } else { // 还没有加载完毕
        [self.userTableView.footer endRefreshing];
    }
}



#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 左边的类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
    
    // 监测footer的状态
    [self checkFooterState];
    
    // 右边的用户表格
    return [CXSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        CXRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CXCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // 右边的用户表格
        CXRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:CXUserId];
        cell.user = [CXSelectedCategory users][indexPath.row];
        return cell;
    }

}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.userTableView.header endRefreshing];
    [self.userTableView.footer endRefreshing];
    
    CXRecommendCategory *c = self.categories[indexPath.row];
    if (c.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
    } else {
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        // 进入下拉刷新状态
        [self.userTableView.header beginRefreshing];
    }

   }

#pragma mark - 控制器的销毁
- (void)dealloc
{
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}


@end
