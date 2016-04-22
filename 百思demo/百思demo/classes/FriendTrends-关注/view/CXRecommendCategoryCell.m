//
//  CXRecommendCategoryCell.m
//  百思demo
//
//  Created by 陈曦 on 16/4/22.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXRecommendCategoryCell.h"
#import "CXRecommendCategory.h"

@implementation CXRecommendCategoryCell



- (void)awakeFromNib {
    
    self.backgroundColor = CXRGBColor(244, 244, 244);
    //self.selectedIndicator.backgroundColor = CXRGBColor(219, 21, 26);

}



- (void)setCategory:(CXRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}


@end
