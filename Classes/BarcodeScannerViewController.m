//
//  BarcodeScannerViewController.m
//  cococalorie
//
//  Created by Coco on 12-3-31.
//  Copyright 2012 Coco. All rights reserved.
//

#import "BarcodeScannerViewController.h"
#import "AppDelegate.h"
#import "ProductObject.h"
#import "BarcodeObject.h"
#import "SQLiteOperation.h"
#import "ProductDetailViewController.h"
#import "ScanResultViewController.h"
#import "CategoryListViewController.h"

@implementation BarcodeScannerViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"Search & Scan";
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
	if (!self.navigationController.navigationBarHidden) {
		[self.navigationController setNavigationBarHidden:YES animated:YES];
	}
}

//- (void)viewDidAppear:(BOOL)animated {
//    BarcodeObject *oneBarcodeObject = [[SQLiteOperation shared] queryOneBarcode:@"3174660032316"];
//    ProductObject *oneProduct = nil;
//    if (oneBarcodeObject) {
//        oneProduct = [[SQLiteOperation shared] queryOneProduct:oneBarcodeObject.productid];
//    }
//    
//    if (oneBarcodeObject && oneProduct) {
//        ProductDetailViewController *productDetailViewController = [[ProductDetailViewController alloc] init];
//        [productDetailViewController setProduct:oneProduct];
//        [self.navigationController pushViewController:productDetailViewController animated:YES];
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        [productDetailViewController release];
//    }
//}

- (NSString *)iconImageName {
	return @"ICON_CAMERA";
}

#pragma mark ZBar delegate

- (void)imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info{
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
	
    // EXAMPLE: do something useful with the barcode data
    //resultText.text = symbol.data;
	
    // EXAMPLE: do something useful with the barcode image
    //resultImage.image =	[info objectForKey: UIImagePickerControllerOriginalImage];
	
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: NO];
	
	BarcodeObject *oneBarcodeObject = [[SQLiteOperation shared] queryOneBarcode:symbol.data];
    ProductObject *oneProduct = nil;
	if (oneBarcodeObject) {
		oneProduct = [[SQLiteOperation shared] queryOneProduct:oneBarcodeObject.productid];
	}
    
    if (oneBarcodeObject && oneProduct) {
        ProductDetailViewController *productDetailViewController = [[ProductDetailViewController alloc] init];
        [productDetailViewController setProduct:oneProduct];
        [self.navigationController pushViewController:productDetailViewController animated:YES];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [productDetailViewController release];
    }
	else {
		ScanResultViewController *scanResultViewController = [[ScanResultViewController alloc] initWithNibName:@"ScanResultViewController" bundle:nil];
		[self.navigationController pushViewController:scanResultViewController animated:YES];
		[scanResultViewController.resultText setText:symbol.data];
		[scanResultViewController.resultImage setImage:[info objectForKey: UIImagePickerControllerOriginalImage]];
		[self.navigationController setNavigationBarHidden:NO animated:YES];
		[scanResultViewController release];
	}
}

#pragma mark UISearchBar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
	[searchBar setShowsCancelButton:YES animated:YES];
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
	[searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	CategoryListViewController *searchResultListViewController = [[CategoryListViewController alloc] initWithNibName:@"CategoryListViewController" bundle:nil];
	[self.navigationController pushViewController:searchResultListViewController animated:YES];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[searchResultListViewController release];
}

#pragma mark Actions

- (IBAction)showScanner{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
	UIView *overlayView = [[UIView alloc] initWithFrame:reader.view.bounds];
	UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
	[cancelButton setFrame:CGRectMake(40, 400, 240, 52)];
	[cancelButton addTarget:reader action:@selector(dismissModalViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
	[overlayView addSubview:cancelButton];
	reader.cameraOverlayView = overlayView;
	reader.showsZBarControls = NO;
    reader.readerDelegate = self;
	
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
	
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
				   config: ZBAR_CFG_ENABLE
					   to: 0];
	
    // present and release the controller
    [[[AppDelegate shared] mTabBarController] presentModalViewController: reader animated: YES];
	//[self.navigationController pushViewController:reader animated:YES];
    [reader release];
}

- (IBAction)searchCategory:(id)sender{
	CategoryListViewController *searchResultListViewController = [[CategoryListViewController alloc] initWithNibName:@"SearchResultListViewController" bundle:nil];
	if (sender == btnBevrages) {
        searchResultListViewController.productsListData = [[SQLiteOperation shared] queryCategoryProducts:@"LAIT"];
	}
	else if (sender == btnBox) {
        searchResultListViewController.productsListData = [[SQLiteOperation shared] queryCategoryProducts:@"VIAN"];
	}
	else if (sender == btnBreakfast) {
        searchResultListViewController.productsListData = [[SQLiteOperation shared] queryCategoryProducts:@"GLAC"];
	}
	else if (sender == btnFrozen) {
        searchResultListViewController.productsListData = [[SQLiteOperation shared] queryCategoryProducts:@"GRAI"];
	}
	else if (sender == btnMeat) {
        searchResultListViewController.productsListData = [[SQLiteOperation shared] queryCategoryProducts:@"BOUL"];
	}
	else if (sender == btnMilk) {
        searchResultListViewController.productsListData = [[SQLiteOperation shared] queryCategoryProducts:@"BOIF"];
	}
	[self.navigationController pushViewController:searchResultListViewController animated:YES];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[searchResultListViewController release];
}

@end
