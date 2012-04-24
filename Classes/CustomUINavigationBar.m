//
//  CustomUINavigationBar.m
//  cococalorie
//
//  Created by Coco on 12-4-10.
//  Copyright 2012 Coco. All rights reserved.
//

#import "CustomUINavigationBar.h"

@implementation UINavigationBar (MyCustomNavBar)

- (UIColor *)tintColor{
	return [UIColor colorWithRed:266.0f/255.0f green:266.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
}

//- (void) drawRect:(CGRect)rect {
//	[super drawRect:rect];
//    UIImage *barImage = [UIImage imageNamed:@"BGNavigationBar.png"];
//    [barImage drawInRect:rect];
//}

@end
