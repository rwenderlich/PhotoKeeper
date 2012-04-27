//
//  PTKEntryCell.h
//  PhotoKeeper
//
//  Created by Ray Wenderlich on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTKEntryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView * photoImageView;
@property (weak, nonatomic) IBOutlet UITextField * titleTextField;
@property (weak, nonatomic) IBOutlet UILabel * subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView * warningImageView;

@end
