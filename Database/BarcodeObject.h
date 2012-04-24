//
//  BarcodesManagedObject.h
//  cococalorie
//
//  Created by Coco on 12-4-3.
//  Copyright 2012 Coco. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface BarcodeObject :  NSObject  
{
}

@property (nonatomic, retain) NSString * barcode;
@property (nonatomic, retain) NSString * productid;
@property (nonatomic, retain) NSNumber * hasValue;

@end



