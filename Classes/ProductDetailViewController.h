//
//  ProductDetailViewController.h
//  cococalorie
//
//  Created by Coco on 12-4-12.
//  Copyright 2012 Coco. All rights reserved.
//

#import "UITableViewControllerBaseClass.h"
#import "ProductObject.h"

@interface ProductDetailViewController : UITableViewControllerBaseClass {
	NSMutableDictionary *mProductDetailDic;
    NSArray *mKeysInOrder;
}

@property (nonatomic, retain) NSMutableDictionary *mProductDetailDic;
@property (nonatomic, retain) ProductObject *product;
@property (nonatomic, retain) NSArray *mKeysInOrder;

@end
