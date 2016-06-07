//
//  CXTopic.h
//  百思demo
//
//  Created by 陈曦 on 16/6/7.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXTopic : NSObject

/** 名称*/
@property (nonatomic , strong ) NSString *name;
/** 头像*/
@property (nonatomic , strong ) NSString *profile_image;
/** 发帖时间*/
@property (nonatomic , strong ) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;







@end
