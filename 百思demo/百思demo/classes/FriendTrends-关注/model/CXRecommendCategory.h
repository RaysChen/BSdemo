//
//  CXRecommendCategory.h
//  百思demo
//
//  Created by 陈曦 on 16/4/21.
//  Copyright © 2016年 chenxi. All rights reserved.
//推荐关注左边的数据模型

#import <Foundation/Foundation.h>

@interface CXRecommendCategory : NSObject
/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;


/**这个类别对应的用户数据*/
@property (nonatomic,strong) NSMutableArray *users;
/**总数*/
@property (nonatomic ,assign) NSInteger total;
/**当前页吗*/
@property (nonatomic ,assign) NSInteger currentPage;
@end
