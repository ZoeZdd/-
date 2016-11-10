//
//  WBStatus.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/30.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBStatus.h"
#import "WBPhoto.h"
#import "NSDate+MJ.h"

@implementation WBStatus

// 实现这个方法,就会自动把数组中的字典转换成对应的模型

+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[WBPhoto class]};
}

-(NSString *)created_at
{
    // Tue Mar 10 17:32:22 +0800 2015
    // 字符串转换NSDate
    //  _created_at = @"Tue Mar 10 17:32:22 +0800 2015";
    
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 新浪微博日期格式转化
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    
    // 设置格式本地化,日期格式字符串知道是哪个国家的日期
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_us"];
    
    NSDate *created_at = [fmt dateFromString:_created_at];
    
    if ([created_at isThisYear]) { // 今年
        
        if ([created_at isToday]) { // 今天
            
            // 计算跟当前时间差距
            NSDateComponents *cmp = [created_at deltaWithNow];
            
            if (cmp.hour >= 1) {
                
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
                
            }else if (cmp.minute > 1){
                
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
                
            }else{
                return @"刚刚";
            }
        } else { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            
            return [fmt stringFromDate:created_at];
        }
    }else{ // 不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        
        return [fmt stringFromDate:created_at];
        
    }
    
    return _created_at;
}

- (void)setSource:(NSString *)source
{
    
    // <a href="http://app.weibo.com/t/feed/6e3owN" rel="nofollow">iPhone 7 Plus</a>
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自%@",source];
    
    _source = source;
//    WBLog(@"%@",source);
}

-(void)setRetweeted_status:(WBStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    _retweetName = [NSString stringWithFormat:@"@ %@",_retweeted_status.user.name];
}
@end
