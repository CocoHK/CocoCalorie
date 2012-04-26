//
//  ProductDetailViewController.h
//  cococalorie
//
//  Created by Coco on 12-4-12.
//  Copyright 2012 Coco. All rights reserved.
//

#import "ProductObject.h"

@interface ProductDetailViewController : UITableViewController {
	NSMutableDictionary *mProductDetailDic;
    NSArray *mKeysInOrder;
}

@property (nonatomic, retain) NSMutableDictionary *mProductDetailDic;
@property (nonatomic, retain) ProductObject *product;
@property (nonatomic, retain) NSArray *mKeysInOrder;

@end
