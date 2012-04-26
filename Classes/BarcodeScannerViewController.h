//
//  BarcodeScannerViewController.h
//  cococalorie
//
//  Created by Coco on 12-3-31.
//  Copyright 2012 Coco. All rights reserved.
//

#import "ZBarSDK.h"

@interface BarcodeScannerViewController : UIViewController <ZBarReaderDelegate,UISearchBarDelegate>{
	IBOutlet UIButton *btnBevrages;
	IBOutlet UIButton *btnBox;
	IBOutlet UIButton *btnBreakfast;
	IBOutlet UIButton *btnFrozen;
	IBOutlet UIButton *btnMeat;
	IBOutlet UIButton *btnMilk;
}

- (IBAction)showScanner;
- (IBAction)searchCategory:(id)sender;

@end
