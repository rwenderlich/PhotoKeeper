//
//  PTKDetailViewController.h
//  PhotoKeeper
//
//  Created by Ray Wenderlich on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTKDocument;
@class PTKDetailViewController;

@protocol PTKDetailViewControllerDelegate 
- (void)detailViewControllerDidClose:(PTKDetailViewController *)detailViewController;
@end

@interface PTKDetailViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) PTKDocument * doc;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak) id <PTKDetailViewControllerDelegate> delegate;

@end
