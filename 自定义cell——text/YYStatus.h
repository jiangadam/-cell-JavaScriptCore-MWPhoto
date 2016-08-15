//
//  YYStatus.h
//  自定义cell——text
//
//  Created by 蒋永忠 on 16/8/2.
//  Copyright © 2016年 chinamyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYStatus : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)StatusWithDict:(NSDictionary *)dict;
+ (NSArray *)statusList;
@end
