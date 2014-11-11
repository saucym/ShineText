//
//  AppDelegate.m
//  ShineText
//
//  Created by QinMingChuan on 14/11/11.
//  Copyright (c) 2014年 413132340@qq.com. All rights reserved.
//

#import "AppDelegate.h"
#import "STShineLabel.h"

#define kTime 0.05

@interface AppDelegate ()

@property (nonatomic, readonly) STShineLabel *contLabel;

@property (nonatomic, readonly) NSTimer *timer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    _contLabel = [[STShineLabel alloc] initWithFrame:CGRectInset(self.window.bounds, 10, 10)];
    _contLabel.numberOfLines = 0;
    _contLabel.text = @"星空中。\n\t\"这颗星球，通体土黄色，没有任何生命存在，直径21000公里，咦，竟然蕴含‘星泪金’矿脉，真是天助我也，将这颗星球吞噬掉后，我的实力应该能恢复到受伤前的80％。”脸色苍白的罗峰盘膝坐在一颗飞行的陨石上，遥看远处的一颗无生命存在的行星。这颗星球，通体土黄色，没有任何生命存在，直径21000公里，咦，竟然蕴含‘星泪金’矿脉，真是天助我也，将这颗星球吞噬掉后，我的实力应该能恢复到受伤前的80％。”脸色苍白的罗峰盘膝坐在一颗飞行的陨石上，遥看远处的一颗无生命存在的行星这颗星球，通体土黄色，没有任何生命存在，直径21000公里，咦，竟然蕴含‘星泪金’矿脉，真是天助我也，将这颗星球吞噬掉后，我的实力应该能恢复到受伤前的80％。”脸色苍白的罗峰盘膝坐在一颗飞行的陨石上，遥看远处的一颗无生命存在的行星这颗星球，通体土黄色，没有任何生命存在，直径21000公里，咦，竟然蕴含‘星泪金’矿脉，真是天助我也，将这颗星球吞噬掉后，我的实力应该能恢复到受伤前的80％。";
    _contLabel.textColor = [UIColor darkGrayColor];
    _contLabel.font = [UIFont boldSystemFontOfSize:22];
    _contLabel.starPoint = CGPointMake(-0.5, -0.5);
    [self.window addSubview:_contLabel];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:kTime target:self selector:@selector(changeGridentColos) userInfo:nil repeats:YES];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)changeGridentColos//随机渐变方向
{
    static CGFloat ddd = 0.1;
    
    CGFloat d_y = self.contLabel.endPoint.y + ddd;
    if(d_y > 2.5)
    {
        ddd = -0.1;
    }
    else if (d_y <= 0.1)
    {
        ddd = 0.1;
    }
    
    self.contLabel.endPoint = CGPointMake(d_y, d_y);
    [self.contLabel setNeedsDisplay];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
