//
//  CXTabBarController.m
//  百思demo
//
//  Created by 陈曦 on 16/4/14.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXTabBarController.h"
#import "CXEssenceViewController.h"
#import "CXNewViewController.h"
#import "CXFriendTrendsViewController.h"
#import "CXMeViewController.h"
#import "CXTabBar.h"




@implementation CXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UINavigationBar appearance];
    
    //通过appearance统一设置所有UITabBarIterm的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    //添加子控制器
    [self setupChildVc:[[CXEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon"  selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[CXNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[CXFriendTrendsViewController alloc]init] title:@"关注" image: @"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVc:[[CXMeViewController alloc]init] title:@"我的" image:@"tabBar_me_icon"  selectedImage:@"tabBar_me_click_icon"];
    
    //更换tabbar
    [self setValue:[[CXTabBar alloc]init] forKeyPath:@"tabBar"];


}
    
    

    
    
//初始化子控制器
    
    - (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
    {
        // 设置文字和图片
        vc.navigationItem.title = title;
        vc.tabBarItem.title = title;
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
        
        // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];

    }



@end
