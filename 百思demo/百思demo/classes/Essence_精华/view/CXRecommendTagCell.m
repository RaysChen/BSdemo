//
//  CXRecommendTagCell.m
//  百思demo
//
//  Created by 陈曦 on 16/5/20.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXRecommendTagCell.h"
#import "CXRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface CXRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@end

@implementation CXRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendTag:(CXRecommendTag *)recommendTag{

    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
   self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel .text = subNumber;
}



- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
