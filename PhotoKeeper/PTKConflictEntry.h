//
//  PTKConflictEntry.h
//  PhotoKeeper
//
//  Created by Ray Wenderlich on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTKMetadata;

@interface PTKConflictEntry : NSObject

@property (strong) NSFileVersion * version;
@property (strong) PTKMetadata * metadata;

- (id)initWithFileVersion:(NSFileVersion *)version metadata:(PTKMetadata *)metadata;

@end
