//
//  CXRecommendCategory.m
//  百思demo
//
//  Created by 陈曦 on 16/4/21.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXRecommendCategory.h"

@implementation CXRecommendCategory
-(NSMutableArray *)users
{

    if (!_users) {
        _users = [NSMutableArray array];
        
    }
    return  _users;

}

@end
