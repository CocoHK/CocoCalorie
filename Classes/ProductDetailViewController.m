//
//  ProductDetailViewController.m
//  cococalorie
//
//  Created by Coco on 12-4-12.
//  Copyright 2012 Coco. All rights reserved.
//


#import "ProductDetailViewController.h"


@implementation ProductDetailViewController

@synthesize mProductDetailDic,product,mKeysInOrder;

#pragma mark -

- (void)setProduct:(ProductObject *)aProduct{
	if (!self.mProductDetailDic) {
		self.mProductDetailDic = [NSMutableDictionary dictionary];
	}
    
    self.mKeysInOrder = [NSArray arrayWithObjects:@"Name",@"Brand",@"Calories",@"Description",nil];
	
	[self.mProductDetailDic setObject:aProduct.name forKey:@"Name"];
	[self.mProductDetailDic setObject:aProduct.brand forKey:@"Brand"];
	[self.mProductDetailDic setObject:aProduct.desc forKey:@"Description"];
	[self.mProductDetailDic setObject:aProduct.cals forKey:@"Calories"];
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mProductDetailDic count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"Basic Info";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    NSString *key = [self.mKeysInOrder objectAtIndex:indexPath.row];
    cell.textLabel.text = key;
    NSUInteger keyIndex = [[self.mProductDetailDic allKeys] indexOfObject:key];
    cell.detailTextLabel.text = [[self.mProductDetailDic allValues] objectAtIndex:keyIndex];
    
    return cell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = [self.mKeysInOrder objectAtIndex:indexPath.row];
    NSUInteger keyIndex = [[self.mProductDetailDic allKeys] indexOfObject:key];
    NSString *message = [[self.mProductDetailDic allValues] objectAtIndex:keyIndex];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

@end

