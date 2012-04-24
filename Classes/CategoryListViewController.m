//
//  SearchFilterViewController.m
//  cococalorie
//
//  Created by Coco on 12-4-18.
//  Copyright 2012 Coco. All rights reserved.
//

#import "CategoryListViewController.h"
#import "ProductDetailViewController.h"
#import "ProductObject.h"
#import "SQLiteOperation.h"

@interface CategoryListViewController(Private)
- (void)startSearch;
@end


@implementation CategoryListViewController

@synthesize productsListData;

- (void)dealloc{
	self.productsListData = nil;
	[super dealloc];
}

- (NSString *)iconImageName {
	return @"ICON_STAR";
}

#pragma mark Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.productsListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    ProductObject *productObject = [self.productsListData objectAtIndex:indexPath.row];
	cell.textLabel.text = productObject.name;
    cell.detailTextLabel.text = productObject.brand;
    return cell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
    ProductObject *productObject = [self.productsListData objectAtIndex:indexPath.row];
    productObject = [[SQLiteOperation shared] queryCalWithProduct:productObject];
    ProductDetailViewController *productDetailViewController = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    [productDetailViewController setProduct:productObject];
    [self.navigationController pushViewController:productDetailViewController animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [productDetailViewController release];
}

@end

