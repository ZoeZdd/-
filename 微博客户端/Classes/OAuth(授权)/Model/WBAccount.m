//
//  WBAccount.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/29.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBAccount.h"

#import "MJExtension.h"

#define WBAccountTokenKey @"token"
#define WBUidKey @"uid"
#define WBExpires_inKey @"exoires"
#define WBExpires_dateKey @"date"
#define WBNameKey @"name"

@implementation WBAccount
// 底层遍历当前的类的所有属性,一个一个归档和解档
//MJCodingImplementation
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    WBAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}
- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}
// 归档的时候调用：告诉系统哪个属性需要归档，如何归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:WBAccountTokenKey];
    [aCoder encodeObject:_expires_in forKey:WBExpires_inKey];
    [aCoder encodeObject:_uid forKey:WBUidKey];
    [aCoder encodeObject:_expires_date forKey:WBExpires_dateKey];
    [aCoder encodeObject:_name forKey:WBNameKey];
}
// 解档的时候调用：告诉系统哪个属性需要解档，如何解档

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        // 一定要记得赋值
        _access_token =  [aDecoder decodeObjectForKey:WBAccountTokenKey];
        _expires_in = [aDecoder decodeObjectForKey:WBExpires_inKey];
        _uid = [aDecoder decodeObjectForKey:WBUidKey];
        _expires_date = [aDecoder decodeObjectForKey:WBExpires_dateKey];
        _name = [aDecoder decodeObjectForKey:WBNameKey];
    }
    return self;
}


@end
