#import "BCTabBar.h"
#import "BCTab.h"
#define kTabMargin 2.0

@interface BCTabBar ()
@property (nonatomic, retain) UIImage *backgroundImage;

- (void)positionArrowAnimated:(BOOL)animated;
@end

@implementation BCTabBar
@synthesize tabs, selectedTab, backgroundImage, arrow, delegate;

- (id)initWithFrame:(CGRect)aFrame {

	if (self = [super initWithFrame:aFrame]) {
		self.backgroundImage = [UIImage imageNamed:@"BCTabBarController.bundle/tab-bar-background.png"];
		
		self.arrow = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BCTabBarController.bundle/tab-arrow.png"]] autorelease];
		CGRect r = self.arrow.frame;
		r.origin.y = - (r.size.height - 2);
		self.arrow.frame = r;
		[self addSubview:self.arrow];
		
		self.userInteractionEnabled = YES;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | 
		                        UIViewAutoresizingFlexibleTopMargin;
						 
	}
	
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self.backgroundImage drawAtPoint:CGPointMake(0, 0)];
	[[UIColor blackColor] set];
	CGContextFillRect(context, CGRectMake(0, self.bounds.size.height / 2.0f, self.bounds.size.width, self.bounds.size.height / 2.0f));
}

- (void)clearTabStates{
	for (BCTab *tab in tabs) {
		//if (tab == sender) continue;
		tab.selected = NO;
		tab.showGlow = NO;
	}
}

- (void)selectTab:(BCTab *)aTab{
	[aTab setSelected:YES];
	[aTab setShowGlow:YES];
	self.selectedTab = aTab;
}

- (void)selectTabAtIndex:(NSUInteger)index animated:(BOOL)isAnimated{
	if (index < tabs.count) {
		[self clearTabStates];
		[self selectTab:[tabs objectAtIndex:index]];
		[self.delegate tabBar:self didSelectTabAtIndex:index];
		[self positionArrowAnimated:isAnimated];
	}
}

- (void)setTabs:(NSArray *)array {
	for (BCTab *tab in tabs) {
		[tab removeFromSuperview];
	}
	
	[tabs release];
	tabs = [array retain];
	
	for (BCTab *tab in tabs) {
		tab.userInteractionEnabled = YES;
		[tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchDown];
	}
	[self setNeedsLayout];
}

- (void)tabSelected:(BCTab *)sender {
	[self selectTabAtIndex:[self.tabs indexOfObject:sender] animated:YES];
}

- (void)positionArrowAnimated:(BOOL)animated {
	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2f];
	}
	CGRect f = self.arrow.frame;
	f.origin.x = self.selectedTab.frame.origin.x + ((self.selectedTab.frame.size.width / 2.0f) - (f.size.width / 2.0f));
	self.arrow.frame = f;
	
	if (animated) {
		[UIView commitAnimations];
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect f = self.bounds;
	f.size.width /= self.tabs.count;
	f.size.width -= (kTabMargin * (self.tabs.count + 1)) / self.tabs.count;
	for (BCTab *tab in self.tabs) {
		f.origin.x += kTabMargin;
		tab.frame = f;
		f.origin.x += f.size.width;
		[self addSubview:tab];
	}
	
	[self positionArrowAnimated:NO];
}

- (void)dealloc {
	self.tabs = nil;
	self.selectedTab = nil;
	self.backgroundImage = nil;
	[super dealloc];
}


- (void)setFrame:(CGRect)aFrame {
	[super setFrame:aFrame];
	[self setNeedsDisplay];
}


@end
