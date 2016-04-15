//
//  UIBarButtonItem+CXExtension.h
//  百思demo
//
//  Created by 陈曦 on 16/4/15.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CXExtension)

+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
