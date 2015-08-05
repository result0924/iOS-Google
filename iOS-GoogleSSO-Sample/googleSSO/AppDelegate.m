//
//  AppDelegate.m
//  googleSSO
//
//  Created by justin on 2015/7/30.
//  Copyright (c) 2015年 justin. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleSignIn.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
}

@end
