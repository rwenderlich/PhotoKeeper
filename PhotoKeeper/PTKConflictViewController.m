//
//  PTKConflictViewController.m
//  PhotoKeeper
//
//  Created by Ray Wenderlich on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PTKConflictViewController.h"
#import "PTKConflictEntry.h"
#import "PTKDocument.h"
#import "PTKMetadata.h"
#import "NSDate+FormattedStrings.h"

@interface PTKConflictViewController ()

@end

@implementation PTKConflictViewController {
    NSMutableArray * _entries;
}

@synthesize fileURL;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _entries = [NSMutableArray array];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [_entries removeAllObjects];    
    NSMutableArray * fileVersions = [NSMutableArray array];
    
    NSFileVersion * currentVersion = [NSFileVersion currentVersionOfItemAtURL:self.fileURL];
    [fileVersions addObject:currentVersion];
    
    NSArray * otherVersions = [NSFileVersion otherVersionsOfItemAtURL:self.fileURL];
    [fileVersions addObjectsFromArray:otherVersions];
    
    for (NSFileVersion * fileVersion in fileVersions) {
        
        // Create a resolve entry and add to entries
        PTKConflictEntry * entry = [[PTKConflictEntry alloc] initWithFileVersion:fileVersion metadata:nil];
        [_entries addObject:entry];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:_entries.count-1 inSection:0];
        
        // Open doc and get metadata - when done, reload row so we can get thumbnail
        PTKDocument * doc = [[PTKDocument alloc] initWithFileURL:fileVersion.URL];
        NSLog(@"Opening URL: %@", fileVersion.URL);
        [doc openWithCompletionHandler:^(BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    entry.metadata = doc.metadata;
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                });
                [doc closeWithCompletionHandler:nil];
            }
        }];
    }
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d rows", _entries.count);
    return _entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    UIImageView * imageView = (UIImageView *) [cell viewWithTag:1];
    UILabel * titleLabel = (UILabel *) [cell viewWithTag:2];
    UILabel * subtitleLabel = (UILabel *) [cell viewWithTag:3];
    PTKConflictEntry * entry = [_entries objectAtIndex:indexPath.row];
    
    if (entry.metadata) {
        imageView.image = entry.metadata.thumbnail;
    }
    titleLabel.text = [NSString stringWithFormat:@"Modified on %@", entry.version.localizedNameOfSavingComputer];
    subtitleLabel.text = [entry.version.modificationDate mediumString];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PTKConflictEntry * entry = [_entries objectAtIndex:indexPath.row];
    
    if (![entry.version isEqual:[NSFileVersion currentVersionOfItemAtURL:self.fileURL]]) {
        [entry.version replaceItemAtURL:self.fileURL options:0 error:nil];    
    }
    [NSFileVersion removeOtherVersionsOfItemAtURL:self.fileURL error:nil];
    NSArray* conflictVersions = [NSFileVersion unresolvedConflictVersionsOfItemAtURL:self.fileURL];
    for (NSFileVersion* fileVersion in conflictVersions) {
        fileVersion.resolved = YES;
    }
    
    [self.navigationController popViewControllerAnimated:YES];    
    
}

@end
