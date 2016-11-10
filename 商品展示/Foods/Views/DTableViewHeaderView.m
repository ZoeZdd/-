//
//  DTableViewHeaderView.m
//  商品展示
//
//  Created by 庄丹丹 on 16/10/17.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "DTableViewHeaderView.h"

@implementation DTableViewHeaderView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =rgba(240, 240, 240, 0.8);
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 20)];
        self.name.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.name];
        
    }
    return self;
}

@end
