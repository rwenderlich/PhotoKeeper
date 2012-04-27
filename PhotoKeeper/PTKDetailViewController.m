//
//  PTKDetailViewController.m
//  PhotoKeeper
//
//  Created by Ray Wenderlich on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PTKDetailViewController.h"
#import "PTKDocument.h"
#import "PTKData.h"
#import "UIImageExtras.h"

@interface PTKDetailViewController ()
- (void)configureView;
@end

@implementation PTKDetailViewController {
    UIImagePickerController * _picker;
}

@synthesize doc = _doc;
@synthesize imageView = _imageView;
@synthesize delegate = _delegate;

#pragma mark - Managing the detail item

- (void)setDoc:(id)newDoc
{
    if (_doc != newDoc) {
        _doc = newDoc;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    self.title = [self.doc description];
    if (self.doc.photo) {
        self.imageView.image = self.doc.photo;
    } else {
        self.imageView.image = [UIImage imageNamed:@"defaultImage.png"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTapped:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    [self configureView];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(documentStateChanged:)
                                                 name:UIDocumentStateChangedNotification 
                                               object:self.doc];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)documentStateChanged:(NSNotification *)notificaiton {
    
    [self configureView];
    
}


#pragma mark Callbacks

- (void)imageTapped:(UITapGestureRecognizer *)recognizer {
    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.allowsEditing = NO;
    }
    
    [self presentModalViewController:_picker animated:YES];
}

- (void)doneTapped:(id)sender {
        
    NSLog(@"Closing %@...", self.doc.fileURL);
    
    [self.doc saveToURL:self.doc.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        [self.doc closeWithCompletionHandler:^(BOOL success) {
            dispatch_async(dispatch_get_main_queue(), ^{                        
                if (!success) {
                    NSLog(@"Failed to close %@", self.doc.fileURL);
                    // Continue anyway...
                }
                
                [self.delegate detailViewControllerDidClose:self];
            });
        }];
    }];
    
}

#pragma mark UIImagePickeerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {    
    
    UIImage *image = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGSize mainSize = self.imageView.bounds.size;
    UIImage *sImage = [image imageByBestFitForSize:mainSize]; //[image scaleToFitSize:mainSize];
    
    self.doc.photo = sImage;
    self.imageView.image = sImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
