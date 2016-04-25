//
//  CXRecommendUserCell.m
//  百思demo
//
//  Created by 陈曦 on 16/4/25.
//  Copyright © 2016年 chenxi. All rights reserved.
//

#import "CXRecommendUserCell.h"
#import "CXRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface CXRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end

@implementation CXRecommendUserCell

- (void)setUser:(CXRecommendUser *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}


@end
