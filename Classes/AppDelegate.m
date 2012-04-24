//
//  cococalorieAppDelegate.m
//  cococalorie
//
//  Created by Coco on 12-3-31.
//  Copyright 2012 Coco. All rights reserved.
//

#import "BCTabBar.h"
#import "AppDelegate.h"
#import "BarcodeScannerViewController.h"
#import "CategoryListViewController.h"
#import "BarcodeObject.h"
#import "ProductObject.h"

#import "SQLiteOperation.h"

@implementation AppDelegate

@synthesize window,mTabBarController;

+ (AppDelegate *)shared{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Create my tab bar controller
    self.mTabBarController = [[[BCTabBarController alloc] init] autorelease];

    // Create some view controllers
    BarcodeScannerViewController *firstViewController = [[BarcodeScannerViewController alloc] init];
    CategoryListViewController *secondViewController = [[CategoryListViewController alloc] init];

	self.mTabBarController.viewControllers = [NSArray arrayWithObjects:firstViewController,secondViewController,nil];
    
    [firstViewController release];
    [secondViewController release];
    
    // Set the root view controller
	[self.window setRootViewController:self.mTabBarController];
    
    // Display the window
    [self.window makeKeyAndVisible];
    
    // Initialse the SQLite database
	[SQLiteOperation shared];
    
    return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc {
	self.mTabBarController = nil;
    [window release];
    [super dealloc];
}

@end

