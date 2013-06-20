//
//  AppDelegate.m
//  MKMapView-ZoomLevel-Demo
//
//  Created by Kjuly on 6/20/13.
//  Copyright (c) 2013 Kjuly. All rights reserved.
//

#import "AppDelegate.h"

#import "RootViewController.h"

@implementation AppDelegate

- (BOOL)          application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  [self.window setRootViewController:[[RootViewController alloc] init]];
  
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

@end
