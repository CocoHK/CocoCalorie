//
//  cococalorieAppDelegate.h
//  cococalorie
//
//  Created by Coco on 12-3-31.
//  Copyright 2012 Coco. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BCTabBarController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	BCTabBarController *mTabBarController;
    UIWindow *window;
}

@property (nonatomic, retain) BCTabBarController *mTabBarController;
@property (nonatomic, retain) IBOutlet UIWindow *window;

+ (AppDelegate *)shared;

@end
