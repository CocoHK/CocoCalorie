// 
//  ProductsManagedObject.m
//  cococalorie
//
//  Created by Coco on 12-4-3.
//  Copyright 2012 Coco. All rights reserved.
//

#import "ProductObject.h"


@implementation ProductObject 

@synthesize productID;
@synthesize brand;
@synthesize name;
@synthesize desc;
@synthesize cals;
@synthesize hasValue;

+ (ProductObject *)product {
    ProductObject *oneProduct = [ProductObject new];
    oneProduct.brand = @"";
    oneProduct.name = @"";
    oneProduct.desc = @"";
    oneProduct.cals = @"";
    oneProduct.hasValue = [NSNumber numberWithBool:NO];
    return [oneProduct autorelease];
}

@end
