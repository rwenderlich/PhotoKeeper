//
//  UIImageExtras.h
//  BattleMap
//
//  Created by Ray Wenderlich on 5/27/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (Extras)

- (UIImage*)imageByBestFitForSize:(CGSize)targetSize;
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
