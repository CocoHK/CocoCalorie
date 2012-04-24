//
//  SearchFilterViewController.h
//  cococalorie
//
//  Created by Coco on 12-4-18.
//  Copyright 2012 Coco. All rights reserved.
//

#import "UIViewControllerBaseClass.h"

@interface CategoryListViewController : UIViewControllerBaseClass {
	NSArray *productsListData;
}

@property (nonatomic, retain) NSArray *productsListData;

@end
