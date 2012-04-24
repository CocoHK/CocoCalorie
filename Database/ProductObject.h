//
//  ProductsManagedObject.h
//  cococalorie
//
//  Created by Coco on 12-4-3.
//  Copyright 2012 Coco. All rights reserved.
//

@interface ProductObject :  NSObject

@property (nonatomic, retain) NSString * productID;
@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * cals;
@property (nonatomic, retain) NSNumber * hasValue;

+ (ProductObject *)product;

@end



