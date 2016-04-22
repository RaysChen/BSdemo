//
//  CXRecommendCategoryCell.h
//  百思demo
//
//  Created by 陈曦 on 16/4/22.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXRecommendCategory.h"
@class CXRecommendCategory;

@interface CXRecommendCategoryCell : UITableViewCell
/** 类别模型 */
@property (nonatomic, strong) CXRecommendCategory *category;

@end
