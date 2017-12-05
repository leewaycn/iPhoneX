//
//  viewTableViewCell.m
//  pan
//
//  Created by 于海涛 on 2017/12/1.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "viewTableViewCell.h"

@interface viewTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@end


@implementation viewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)sendMessage:(viewModel *)model{
    self.nameLab.text = [NSString stringWithFormat:@"%@",model.name];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
