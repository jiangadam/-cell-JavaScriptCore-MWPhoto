//
//  YYMainCell.h
//  自定义cell——text
//
//  Created by 蒋永忠 on 16/8/2.
//  Copyright © 2016年 chinamyo. All rights reserved.
//
#define Identifier @"CELL"

#import <UIKit/UIKit.h>
@class YYStatus;
@interface YYMainCell : UITableViewCell

@property (nonatomic, strong) YYStatus *status;
+ (instancetype) cellWithTableView:(UITableView *)tableView;

@end
