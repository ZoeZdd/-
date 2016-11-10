//
//  AppDelegate.m
//  微博客户端
//
//  Created by 庄丹丹 on 2016/10/28.
//  Copyright © 2016年 庄丹丹. All rights reserved.
//

#import "AppDelegate.h"


#import "WBOAuthViewController.h"

#import "WBAccountTool.h"
#import "WBRootTool.h"

#import "UIImageView+WebCache.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
//@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
//    WBNewFeatureControllerViewController *newFeatureControllerVC = [[WBNewFeatureControllerViewController alloc] init];
//    
//    self.window.rootViewController = newFeatureControllerVC;

    
    // 选择根控制器
    // 判断下有没有授权
    if ([WBAccountTool account]) { // 已经授权
        
        // 选择根控制器
        [WBRootTool chooseRootViewController:self.window];
        
    }else{ // 进行授权
        WBOAuthViewController *oauthVc = [[WBOAuthViewController alloc] init];
        
        // 设置窗口的根控制器
        self.window.rootViewController = oauthVc;
        
    }
        
    // 显示窗口
    [self.window makeKeyAndVisible];

    return YES;
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

// 失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // 开启一个后台任务,时间不确定，优先级比较低，假如系统要关闭应用，首先就考虑
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 当后台任务结束的时候调用
        [application endBackgroundTask:ID];
    }];
    
    // 如何提高后台任务的优先级,欺骗苹果,我们是后台播放程序
    
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    
    // 微博：在程序即将失去焦点的时候播放静音音乐
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"爸比我要喝奶奶.mp3" withExtension:nil];
//    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//    [player prepareToPlay];
//    // 无限播放
//    player.numberOfLoops = -1;
//    
//    [player play];
//    _player = player;
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"_____"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
