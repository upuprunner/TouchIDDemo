//
//  AppDelegate.m
//  TouchIDDemo
//
//  Created by jianglei on 16/6/20.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "AppDelegate.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //存入一个当前延迟五分钟的日期
    NSDate *currentDate =[NSDate date];
    NSTimeInterval interval =60;
    NSDate *delyDate =[NSDate dateWithTimeInterval:interval sinceDate:currentDate];
    //存储起来
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:delyDate forKey:@"delayDate"];
    [defaults synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //取出进入后台的时间
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSDate *currentDate =[NSDate date];
    NSDate *beforeDate =[defaults objectForKey:@"delayDate"];
    
    //过了五分钟的时间,进行指纹验证
    if ([currentDate compare:beforeDate] == NSOrderedDescending) {
        
        LAContext *context =[[LAContext alloc]init];
        NSError *error =nil;
        NSString *localReponseString =@"通过Home键验证已有手机指纹";
        
        //用户开启了指纹识别
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localReponseString reply:^(BOOL success, NSError * _Nullable error) {
                
                if (success) {
                    
                    NSLog(@"------验证成功");
                    
                }else{
                    
                    NSLog(@"------验证失败");
                }
            }];
            
        }else{
            
            NSLog(@"-----------用户未开启指纹识别");
        }
        
    }
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
