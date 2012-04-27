//
//  PTKConflictEntry.m
//  PhotoKeeper
//
//  Created by Ray Wenderlich on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PTKConflictEntry.h"

@implementation PTKConflictEntry
@synthesize version = _version;
@synthesize metadata = _metadata;

- (id)initWithFileVersion:(NSFileVersion *)version metadata:(PTKMetadata *)metadata {
    if ((self = [super init])) {
        self.version = version;
        self.metadata = metadata;
    }
    return self;
}

@end
