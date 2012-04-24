//
//  SQLiteOperation.h
//  cococalorie
//
//  Created by Coco on 12-4-10.
//  Copyright 2012 Coco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"
#import "BarcodeObject.h"
#import "ProductObject.h"

@interface SQLiteOperation : NSObject {
	sqlite3 *mDatabase;
}

+ (SQLiteOperation *)shared;
- (BarcodeObject *)queryOneBarcode:(NSString *)barcode;
- (ProductObject *)queryCalWithProduct:(ProductObject *)oneProduct;
- (ProductObject *)queryOneProduct:(NSString *)productID;
- (NSArray *)queryCategoryProducts:(NSString *)categoryID;

@end
