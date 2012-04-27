//
//  NSDate+FormattedStrings.m
//  PhotoCaptioner
//
//  Created by Ray Wenderlich on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDate+FormattedStrings.h"

@implementation NSDate (FormattedStrings)

- (NSString *)mediumString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDoesRelativeDateFormatting:YES];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    return [dateFormatter stringFromDate:self];
}

@end