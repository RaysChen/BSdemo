//
//  CXWordViewController.m
//  百思demo
//
//  Created by 陈曦 on 16/6/6.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXWordViewController.h"
#import <AFNetworking.H>
#import <UIImageView+WebCache.h>

@interface CXWordViewController ()
/**
 *  帖子数据
 */
@property (nonatomic , strong ) NSArray *topics;

@end

@implementation CXWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        self.topics = responseObject[@"list"];
        
        [self.tableView reloadData];
        //        [responseObject writeToFile:@"/Users/xiaomage/Desktop/duanzi.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    NSDictionary *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic[@"name"];
    cell.detailTextLabel.text = topic[@"text"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic[@"profile_image"]] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
}


@end
