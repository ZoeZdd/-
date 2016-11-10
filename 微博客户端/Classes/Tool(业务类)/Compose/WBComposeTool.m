//
//  WBComposeTool.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/11/3.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "WBComposeTool.h"
#import "WBHttpTool.h"
#import "MJExtension.h"
#import "WBComposeParam.h"
#import "WBUploadParam.h"

@implementation WBComposeTool

+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    WBComposeParam *params = [WBComposeParam param];
    params.status = status;
    
    [WBHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    WBComposeParam *params = [WBComposeParam param];
    params.status = status;
    
    // 创建上传的模型
    WBUploadParam *uploadParam = [[WBUploadParam alloc] init];
    uploadParam.data = UIImagePNGRepresentation(image);
    uploadParam.name = @"pic";
    uploadParam.fileName = @"image.png";
    uploadParam.mimeType = @"image/png";
    
    // 注意: 以后如果一个方法, 要传很多参数, 就把参数包装成一个模型
    [WBHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params.keyValues uploadParam:uploadParam success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
