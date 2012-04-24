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
#import "BarcodeObject.h"
#import "ProductObject.h"

#import "SQLiteOperation.h"

@implementation AppDelegate

@synthesize window,mTabBarController;

+ (AppDelegate *)sharedDelegate{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	
    self.mTabBarController = [[[BCTabBarController alloc] init] autorelease];
//	self.mTabBarController.defaultTabIndex = 1;
	self.mTabBarController.viewControllers = [NSArray arrayWithObjects:
											  //[[[UINavigationController alloc] initWithRootViewController:[[[SearchFilterViewController alloc] initWithNibName:@"SearchViewController" bundle:nil] autorelease]] autorelease],
											  [[[UINavigationController alloc] initWithRootViewController:[[[BarcodeScannerViewController alloc] initWithNibName:@"BarcodeScannerViewController" bundle:nil] autorelease]] autorelease],
											  //[[[UINavigationController alloc] initWithRootViewController:[[[AccountViewController alloc] initWithNibName:@"AccountViewController" bundle:nil] autorelease]] autorelease],
											  nil];
	[self.window setRootViewController:self.mTabBarController];
    
    [self.window makeKeyAndVisible];
    
	[SQLiteOperation shared];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {

}

#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)applicationResourcesDirectory {
	return [[NSBundle mainBundle] resourceURL];
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

