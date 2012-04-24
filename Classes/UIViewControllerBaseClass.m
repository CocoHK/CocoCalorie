    //
//  CustomUIViewController.m
//  cococalorie
//
//  Created by Coco on 12-4-10.
//  Copyright 2012 Coco. All rights reserved.
//

#import "UIViewControllerBaseClass.h"


@implementation UIViewControllerBaseClass

- (void)awakeFromNib{
}

- (void)viewDidLoad{
	//self.navigationController.navigationBar.tintColor = NAVIGATION_BAR_TINT_COLOR;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	//Codes
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	//Codes
}

- (void)dealloc {
	//Codes
    [super dealloc];
}

@end
