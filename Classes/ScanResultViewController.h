//
//  ScanResultViewController.h
//  cococalorie
//
//  Created by Coco on 12-4-17.
//  Copyright 2012 Coco. All rights reserved.
//


@interface ScanResultViewController : UIViewController {
    IBOutlet UIImageView *resultImage;
    IBOutlet UITextView *resultText;
}

@property (nonatomic, retain) UIImageView *resultImage;
@property (nonatomic, retain) UITextView *resultText;

@end