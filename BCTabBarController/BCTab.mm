#import "BCTab.h"

@interface BCTab ()
@property (nonatomic, retain) UIImage *glowImage;
@property (nonatomic, retain) UIImage *rightBorder;
@property (nonatomic, retain) UIImage *bgImage;
@end

@implementation BCTab
@synthesize rightBorder, bgImage, glowImage, showGlow;

- (id)initWithIconImageName:(NSString *)imageName {
	if (self = [super init]) {
		self.glowImage = [UIImage imageNamed:@"BCTabBarController.bundle/tab-glow"];
		self.adjustsImageWhenHighlighted = NO;
		self.bgImage = [UIImage imageNamed:@"BCTabBarController.bundle/tab-background"];
		self.rightBorder = [UIImage imageNamed:@"BCTabBarController.bundle/tab-right-border"];
		self.backgroundColor = [UIColor clearColor];
		NSString *selectedName = [NSString stringWithFormat:@"%@_HL",
								   imageName];
		
		[self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
		[self setImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
	}
	return self;
}

- (void)dealloc {
	self.rightBorder = nil;
	self.bgImage = nil;
	self.glowImage = nil;
	[super dealloc];
}

- (void)setHighlighted:(BOOL)aBool {
	// no highlight state
}

- (void)drawRect:(CGRect)rect {
	if (self.selected) {
		[self.bgImage drawAtPoint:CGPointMake(0, 2)];
		[self.rightBorder drawAtPoint:CGPointMake(self.bounds.size.width - rightBorder.size.width, 2)];
		
		CGContextRef c = UIGraphicsGetCurrentContext();
		[RGBCOLOR(24, 24, 24) set]; 
		CGContextFillRect(c, CGRectMake(0, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height / 2));
		[RGBCOLOR(14, 14, 14) set];		
		CGContextFillRect(c, CGRectMake(0, self.bounds.size.height / 2, 0.5, self.bounds.size.height / 2));
		CGContextFillRect(c, CGRectMake(self.bounds.size.width - 0.5, self.bounds.size.height / 2, 0.5, self.bounds.size.height / 2));
	}
	if (self.showGlow) {
		[self.glowImage drawAtPoint:CGPointMake((rect.size.width / 2) - (self.glowImage.size.width / 2),
												TAB_BAR_HEIGHT - (self.glowImage.size.height - 4))];
	}
}

- (void)setFrame:(CGRect)aFrame {
	[super setFrame:aFrame];
	[self setNeedsDisplay];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.imageEdgeInsets = TAB_BAR_IMAGE_OFFSET;
}

@end
