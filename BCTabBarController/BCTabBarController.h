#import "BCTabBar.h"
@class BCTabBarView;

@interface BCTabBarController : UIViewController <BCTabBarDelegate> {
	NSArray *viewControllers;
	UIViewController *selectedViewController;
	BCTabBar *tabBar;
	BCTabBarView *tabBarView;
	NSUInteger defaultTabIndex;
}

@property (nonatomic, assign) NSUInteger defaultTabIndex;
@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, retain) BCTabBar *tabBar;
@property (nonatomic, retain) UIViewController *selectedViewController;
@property (nonatomic, retain) BCTabBarView *tabBarView;

@end
