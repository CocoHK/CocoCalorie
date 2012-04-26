//
//  SQLiteOperation.m
//  cococalorie
//
//  Created by Coco on 12-4-10.
//  Copyright 2012 Coco. All rights reserved.
//

#import "SQLiteOperation.h"

#define databaseName @"database.sqlite"

@interface SQLiteOperation()

@property (nonatomic, assign) sqlite3 *mDatabase;

#define create _creates
-(BOOL)_creates;
-(NSString*)_getDataSourcePath;

@end

@implementation SQLiteOperation

@synthesize mDatabase;

static SQLiteOperation *mSharedSQLiteOperation;

+ (SQLiteOperation *)shared {
	@synchronized(self) {
		if (mSharedSQLiteOperation == nil) {
			mSharedSQLiteOperation = [[self alloc] init];
			if (![mSharedSQLiteOperation create]) {
				return nil;
			}
		}
	}
	return mSharedSQLiteOperation;
}

- (BOOL)_creates {
	NSString *databasePath = [mSharedSQLiteOperation _getDataSourcePath];
	if (sqlite3_open([databasePath UTF8String], &mDatabase)!=SQLITE_OK) {
		sqlite3_close(mDatabase);
		if ([[NSFileManager defaultManager] copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"database.sqlite"] toPath:databasePath error:nil]) {
#warning TODO:Check why the copy is failed
			if (sqlite3_open([databasePath UTF8String], &mDatabase)!=SQLITE_OK) {
				sqlite3_close(mDatabase);
				return NO;
			}
		}
		else {
			return NO;
		}

	}

	return YES;
}

- (NSString*)_getDataSourcePath{
	return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"database.sqlite"];
	NSArray* fileDictory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);\
	NSString *path =  [[fileDictory objectAtIndex:0] stringByAppendingPathComponent:databaseName];
	return path;
}

+ (id)allocWithZone:(NSZone *)zone{
	@synchronized(self)	{
		if (mSharedSQLiteOperation == nil) {
			mSharedSQLiteOperation = [super allocWithZone:zone];
			return mSharedSQLiteOperation;
		}
	}
	return nil;
}

#pragma mark Select Statement

- (BarcodeObject *)queryOneBarcode:(NSString *)barcode{
	BarcodeObject *barcodeObject = [[BarcodeObject alloc] init];
	sqlite3_stmt *query_stmt = nil;
	NSString *select_SQL = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE ZEAN like '%@'",@"ZBARCODE",barcode];
	if (sqlite3_prepare_v2(mDatabase, [select_SQL UTF8String], -1,&query_stmt, nil)==SQLITE_OK) {
		while (sqlite3_step(query_stmt)) {
			if (sqlite3_column_count(query_stmt) > 0) {
				char *barcodeValue = (char*)sqlite3_column_text(query_stmt, 5);
				char *productIDValue = (char*)sqlite3_column_text(query_stmt, 4);
				if (barcodeValue){
					[barcodeObject setHasValue:[NSNumber numberWithBool:YES]];
					barcodeObject.barcode = [NSString stringWithUTF8String:barcodeValue];
				}
				if (productIDValue){
					[barcodeObject setHasValue:[NSNumber numberWithBool:YES]];
					barcodeObject.productid = [NSString stringWithUTF8String:productIDValue];
				}
				break;
#warning TODO:Check if there are more results
			}
		}
	}
	sqlite3_close(mDatabase);
    if ([[barcodeObject hasValue] boolValue]) {
        return [barcodeObject autorelease];
    }
    else {
        [barcodeObject release];
        barcodeObject = nil;
    }
    return nil;
}

- (NSArray *)queryProductsWithProductID:(NSString *)productID withCategoryID:(NSString *)categoryID withName:(NSString *)name {
    NSMutableArray *productsArray = [[NSMutableArray alloc] init];
    
    NSString *select_SQL;
    if (productID) {
        select_SQL = [NSString stringWithFormat:@"SELECT * FROM ZPRODUCT WHERE Z_PK like '%@'",productID];
    }
    else if (categoryID) {
        select_SQL = [NSString stringWithFormat:@"SELECT * FROM ZPRODUCT WHERE ZCATEGORY like '%@'",categoryID];
    }
    else if (name) {
        select_SQL = [NSString stringWithFormat:@"SELECT * FROM ZPRODUCT WHERE ZNAME like '%@'",name];
    }
    else {
        select_SQL = [NSString stringWithFormat:@"SELECT * FROM ZPRODUCT"];
    }
    
    sqlite3_stmt *query_stmt = nil;
    NSInteger countLimit = 200;
    if (sqlite3_prepare_v2(mDatabase, [select_SQL UTF8String], -1,&query_stmt, nil)==SQLITE_OK) {
		while (sqlite3_step(query_stmt) && countLimit > 0) {
			if (sqlite3_column_count(query_stmt) > 0) {
                ProductObject *productObject = [ProductObject product];
                
				char *productID = (char*)sqlite3_column_text(query_stmt, 0);
				char *brand = (char*)sqlite3_column_text(query_stmt, 20);
				char *name = (char*)sqlite3_column_text(query_stmt, 28);
				char *desc = (char*)sqlite3_column_text(query_stmt, 26);
				
                if (productID != NULL) {
					productObject.productID = [NSString stringWithUTF8String:productID];
                }
				if (brand != NULL) {
					[productObject setHasValue:[NSNumber numberWithBool:YES]];
					productObject.brand = [NSString stringWithUTF8String:brand];
				}
				if (desc != NULL) {
					[productObject setHasValue:[NSNumber numberWithBool:YES]];
					productObject.desc = [NSString stringWithUTF8String:desc];
				}
				if (name != NULL) {
					[productObject setHasValue:[NSNumber numberWithBool:YES]];
					productObject.name = [NSString stringWithUTF8String:name];
				}
                
                if ([productObject hasValue]) {
                    [productsArray addObject:productObject];
                }
                countLimit -= 1;
			}
		}
	}
	sqlite3_close(mDatabase);
	return [productsArray autorelease];
}

- (ProductObject *)queryCalWithProduct:(ProductObject *)oneProduct {
    if (oneProduct) {
        NSString *select_SQL = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE ZNUTRITIONTOPRODUCT like '%@'",@"ZNUTRITION",oneProduct.productID];
        sqlite3_stmt *query_stmt = nil;
        if (sqlite3_prepare_v2(mDatabase, [select_SQL UTF8String], -1,&query_stmt, nil)==SQLITE_OK) {
            while (sqlite3_step(query_stmt)) {
                if (sqlite3_column_count(query_stmt) > 0) {
                    char *cals = (char*)sqlite3_column_text(query_stmt, 16);
                    
                    if (cals) {
                        [oneProduct setHasValue:[NSNumber numberWithBool:YES]];
                        CGFloat calorieValue = [[NSString stringWithUTF8String:cals] floatValue];
                        oneProduct.cals = [NSString stringWithFormat:@"%.1f Cals",calorieValue];
                    }
                    break;
                }
            }
        }
        else {
            oneProduct.cals = @"No Data";
        }
        sqlite3_close(mDatabase);
    }
    
	return oneProduct;
}

- (ProductObject *)queryOneProduct:(NSString *)productID {
	NSArray *productsArray = [self queryProductsWithProductID:productID withCategoryID:nil withName:nil];
    ProductObject *productObject = nil;
    if ([productsArray count] > 0) {
        productObject = [productsArray objectAtIndex:0];
    }
    if (productObject) {
        return [self queryCalWithProduct:productObject];
    }
    return nil;
}

- (NSArray *)queryCategoryProducts:(NSString *)categoryID {
    return [self queryProductsWithProductID:nil withCategoryID:categoryID withName:nil];
}

@end
