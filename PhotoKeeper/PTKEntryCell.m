//
//  PTKEntryCell.m
//  PhotoKeeper
//
//  Created by Ray Wenderlich on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PTKEntryCell.h"

@implementation PTKEntryCell
@synthesize photoImageView;
@synthesize titleTextField;
@synthesize subtitleLabel;
@synthesize warningImageView;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [UIView animateWithDuration:0.1 animations:^{
        if(editing){
            titleTextField.enabled = YES;
            titleTextField.borderStyle = UITextBorderStyleRoundedRect;
        }else{
            titleTextField.enabled = NO;
            titleTextField.borderStyle = UITextBorderStyleNone;
        }
    }];
    
}

@end
