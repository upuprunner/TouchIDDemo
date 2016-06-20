//
//  ViewController.m
//  TouchIDDemo
//
//  Created by jianglei on 16/6/20.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor =[UIColor yellowColor];
    UILabel *welcomeLab =[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2.0 -100, self.view.frame.size.height/2.0 -30, 200, 60)];
    welcomeLab.text =@"这是欢迎页";
    welcomeLab.textColor =[UIColor redColor];
    welcomeLab.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:welcomeLab];
    
    LAContext *context =[[LAContext alloc]init];
    NSError *error =nil;
    NSString *localReponseString =@"通过Home键验证已有手机指纹";
    
    //用户开启了指纹识别
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localReponseString reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                
                NSLog(@"------验证成功");
                [self goToMain];
                
            }else{
                
                NSLog(@"------验证失败");
            }
        }];
        
    }else{
        
        NSLog(@"-----------用户未开启指纹识别");
    }

}

- (void)goToMain{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MainViewController *mainVC =[[MainViewController alloc]init];
        UINavigationController *mainNav =[[UINavigationController alloc]initWithRootViewController:mainVC];
        
        AppDelegate *delegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        UIWindow *window =delegate.window;
        window.rootViewController =mainNav;
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
