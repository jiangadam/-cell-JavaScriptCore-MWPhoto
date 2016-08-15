//
//  YYMainCell.m
//  自定义cell——text
//
//  Created by 蒋永忠 on 16/8/2.
//  Copyright © 2016年 chinamyo. All rights reserved.
//

#import "YYMainCell.h"
#import "YYStatus.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface YYMainCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UILabel *descriptionView;
@end

@implementation YYMainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 标题
        UILabel *titleView = [[UILabel alloc] init];
        titleView.font = [UIFont systemFontOfSize:14];
        titleView.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        [self.contentView addSubview:titleView];
        self.titleView = titleView;
        
        // 描述
        UILabel *descView = [[UILabel alloc] init];
        descView.font = [UIFont systemFontOfSize:11];
        descView.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
        descView.numberOfLines = 0;
        [descView sizeToFit];
        [self.contentView addSubview:descView];
        self.descriptionView = descView;
        
        // icon
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.width.mas_equalTo(100);
        }];
        
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.iconView.mas_left).offset(-10);
            make.height.mas_equalTo(14);
        }];
        
        [self.descriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_top).offset(18);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.iconView.mas_left).offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        
        self.layer.shadowColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 1.0;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        //    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
        self.layer.shadowOpacity = 0.3;
    }
    
    return self;
}

- (void)setStatus:(YYStatus *)status
{
    _status = status;
    
    self.titleView.text = status.title;
    self.descriptionView.text = status.desc;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:status.icon]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype) cellWithTableView:(UITableView *)tableView
{
    YYMainCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[YYMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return cell;
}

@end
