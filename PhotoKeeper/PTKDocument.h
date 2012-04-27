//
//  PTKDocument.h
//  PhotoKeeper
//
//  Created by Ray Wenderlich on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTKData;
@class PTKMetadata;

#define PTK_EXTENSION @"ptk"

@interface PTKDocument : UIDocument

// Data
- (UIImage *)photo;
- (void)setPhoto:(UIImage *)photo;

// Metadata
@property (nonatomic, strong) PTKMetadata * metadata;
- (NSString *) description;

@end
