//
//  DSAppDelegate.m
//  devinsantos
//
//  Created by Fernando Bass on 10/18/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import "DSAppDelegate.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)

@implementation DSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIStoryboard *mainStoryboard = nil;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")) {
//        mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryBoard" bundle:nil];
    } else {
        mainStoryboard = [UIStoryboard storyboardWithName:@"iOS5StoryBoard" bundle:nil];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = [mainStoryboard instantiateInitialViewController];
        [self.window makeKeyAndVisible];
    }
    
    [self customComponents];
    
    return YES;
}

- (void)customComponents
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBar"] forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"backButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
