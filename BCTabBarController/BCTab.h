#define TAB_BAR_HEIGHT 44
#define TAB_BAR_IMAGE_OFFSET UIEdgeInsetsMake(2,0,1,0)

@interface BCTab : UIButton {
	UIImage *bgImage;
	UIImage *rightBorder;
	UIImage *glowImage;
	BOOL showGlow;
}

@property (nonatomic,assign) BOOL showGlow;

- (id)initWithIconImageName:(NSString *)imageName;

@end
