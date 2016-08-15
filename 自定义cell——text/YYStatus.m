//
//  YYStatus.m
//  自定义cell——text
//
//  Created by 蒋永忠 on 16/8/2.
//  Copyright © 2016年 chinamyo. All rights reserved.
//

#import "YYStatus.h"

@implementation YYStatus
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)StatusWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
+ (NSArray *)statusList
{
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"status" ofType:@"plist"]];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        YYStatus *status = [YYStatus StatusWithDict:dict];
        [tempArr addObject:status];
    }
    return tempArr;
}
@end
