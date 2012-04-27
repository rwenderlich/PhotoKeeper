//
//  PTKData.m
//  PhotoKeeper
//
//  Created by Ray Wenderlich on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PTKData.h"

@implementation PTKData
@synthesize photo = _photo;

- (id)initWithPhoto:(UIImage *)photo {
    if ((self = [super init])) {
        self.photo = photo;
    }
    return self;
}

- (id)init {
    return [self initWithPhoto:nil];
}

#pragma mark NSCoding

#define kVersionKey @"Version"
#define kPhotoKey @"Photo"

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:1 forKey:kVersionKey];
    NSData * photoData = UIImagePNGRepresentation(self.photo);
    [encoder encodeObject:photoData forKey:kPhotoKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    [decoder decodeIntForKey:kVersionKey];
    NSData * photoData = [decoder decodeObjectForKey:kPhotoKey];
    UIImage * photo = [UIImage imageWithData:photoData];
    return [self initWithPhoto:photo];
}

@end
