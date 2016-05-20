//
//  CXRecommendTag.h
//  百思demo
//
//  Created by 陈曦 on 16/5/20.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXRecommendTag : NSObject

//图片
@property (nonatomic, copy) NSString *image_list;

//名字
@property (nonatomic,copy) NSString *theme_name;

//订阅数
@property (nonatomic,assign) NSInteger sub_number;

@end
