//
//  CXEssenceViewController.m
//  百思demo
//
//  Created by 陈曦 on 16/4/14.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXEssenceViewController.h"
#import "CXRecommendTagsViewController.h"


@interface CXEssenceViewController ()
/*标签栏底部的红色指示器*/
@property (nonatomic, weak)UIView *indicatorView;
/*当前选中的按钮*/
@property (nonatomic , weak)UIButton *selectedButton;
/*顶部的所有标签*/
@property (nonatomic, weak)UIView *titlesView;
/*底部的所有内容*/
@property (nonatomic , weak)UIScrollView *contentView;
@end

@implementation CXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNav];
    [self setupTitlesView];
}


/**
 *  设置底部导航栏
 */
-(void)setupNav
{
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = CXGlobalBg;

}

/**
 *  设置顶部的标签栏
 */
-(void)setupTitlesView{

 //标签栏整体
    UIView *titlesView = [[UIView alloc]init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y= 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
//顶部标签下方的红色指示
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;






}


- (void)tagClick
{
    CXRecommendTagsViewController *vc = [[CXRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
