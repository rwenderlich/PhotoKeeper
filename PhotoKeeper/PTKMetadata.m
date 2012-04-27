//
//  PTKMetadata.m
//  PhotoKeeper
//
//  Created by Ray Wenderlich on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PTKMetadata.h"

@implementation PTKMetadata
@synthesize thumbnail = _thumbnail;

- (id)initWithThumbnail:(UIImage *)thumbnail {
    if ((self = [super init])) {
        self.thumbnail = thumbnail;
    }
    return self;
}

- (id)init {
    return [self initWithThumbnail:nil];
}

#pragma mark NSCoding

#define kVersionKey @"Version"
#define kThumbnailKey @"Thumbnail"

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:1 forKey:kVersionKey];
    NSData * thumbnailData = UIImagePNGRepresentation(self.thumbnail);
    [encoder encodeObject:thumbnailData forKey:kThumbnailKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    [decoder decodeIntForKey:kVersionKey];
    NSData * thumbnailData = [decoder decodeObjectForKey:kThumbnailKey];
    UIImage * thumbnail = [UIImage imageWithData:thumbnailData];
    return [self initWithThumbnail:thumbnail];
}

@end
