//
//  CXRecommendTagsViewController.m
//  百思demo
//
//  Created by 陈曦 on 16/5/20.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXRecommendTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "CXRecommendTag.h"
#import "CXRecommendTagCell.h"

@interface CXRecommendTagsViewController ()
//推荐标签的数据
@property (nonatomic,strong)NSArray *tags;

@end

static NSString *const CXTagsId = @"tag";

@implementation CXRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTags];
    
    [self setupTableView];
    
    
}


- (void)loadTags
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        self.tags = [CXRecommendTag objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

- (void)setupTableView
{
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CXRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:CXTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = CXGlobalBg;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CXRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:CXTagsId];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end


