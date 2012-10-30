//
//  TopicsTableViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "TopicsTableViewController.h"
#import "ViewController.h"

@interface TopicsTableViewController ()

@end

@implementation TopicsTableViewController
@synthesize senderVC;
@synthesize countF;
@synthesize user;

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
    
    [[self tableView] setBackgroundColor:[UIColor clearColor]];
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    [rc setEnabled:YES];
    [rc addTarget:self action:@selector(refreshController) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:rc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[user topics] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topiccelll"];
//    
//    NSLog(@"cell: %@", cell);
//    
//    [[cell title] setText:@"iPhone 4S"];
//    [[cell title] setFont:[UIFont fontWithName:@"Museo-300" size:15]];
//    
//    [[cell price] setText:@"$199"];
//    [[cell price] setTextColor:[UIColor colorWithRed:0.0 green:137.0/255.0 blue:200.0/255.0 alpha:1.0]];
//    [[cell price] setFont:[UIFont fontWithName:@"Museo-300" size:13]];
//
//    return cell;

    NSSortDescriptor *lastNameSorter = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO selector:@selector(localizedStandardCompare:)];
    NSArray *userD = [[[user topics] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:lastNameSorter]];
    
    static NSString *CellIdentifier = @"topiccelll";
    
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setTitle:[[UILabel alloc] initWithFrame:CGRectMake(86, 22, 214, 20)]];
        [cell setPrice:[[UILabel alloc] initWithFrame:CGRectMake(86, 39, 214, 25)]];
        [cell setImageBackground:[[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 72, 72)]];
        [cell setImage:[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 64, 64)]];
        
        if ([[[user topics] allObjects] objectAtIndex:indexPath.row]) {
            
            [[cell title] setText:[(Topic *)[userD objectAtIndex:indexPath.row] subject]];
        } else {
            [[cell title] setText:@"Error"];
        }
        [[cell title] setFont:[UIFont fontWithName:@"Museo-300" size:15]];
        [[cell title] setBackgroundColor:[UIColor clearColor]];
        
        [[cell price] setText:[NSString stringWithFormat:@"$%.02f", [[(Topic *)[userD objectAtIndex:[indexPath row]] price] floatValue]]];
        [[cell price] setTextColor:[UIColor colorWithRed:0.0 green:137.0/255.0 blue:200.0/255.0 alpha:1.0]];
        [[cell price] setFont:[UIFont fontWithName:@"Museo-300" size:13]];
        [[cell price] setBackgroundColor:[UIColor clearColor]];
        
        [[cell image] setContentMode:UIViewContentModeScaleAspectFit];
        
        [[cell imageBackground] setImage:[UIImage imageNamed:@"topic_image_background.png"]];

        [cell addSubview:[cell title]];
        [cell addSubview:[cell price]];
        [cell addSubview:[cell imageBackground]];
        [cell addSubview:[cell image]];

    } else {
        [[cell title] setText:[(Topic *)[userD objectAtIndex:indexPath.row] subject]];
        [[cell title] setFont:[UIFont fontWithName:@"Museo-300" size:15]];
        
        [[cell price] setText:[NSString stringWithFormat:@"$%.02f", [[(Topic *)[userD objectAtIndex:[indexPath row]] price] floatValue]]];
        [[cell price] setTextColor:[UIColor colorWithRed:0.0 green:137.0/255.0 blue:200.0/255.0 alpha:1.0]];
        [[cell price] setFont:[UIFont fontWithName:@"Museo-300" size:13]];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSURL *imageURL = [NSURL URLWithString:[[userD objectAtIndex:indexPath.row] image_url]];
    
    //this will set the image when loading is finished
    [cell.image setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showHUDAddedTo:[(ViewController *)senderVC view] animated:YES];
    
    [self performSelector:@selector(gotoDetailView:) withObject:indexPath afterDelay:.5];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)gotoDetailView:(NSIndexPath *)indexPath {
    [self setSelectedIndexPath:indexPath];
    [senderVC performSegueWithIdentifier:@"gotoDetail" sender:self];
}

#pragma -mark UIRefreshController Callbacks
-(void)refreshController {
    [(ViewController *)senderVC getUserData];
}

-(void)endRef {
    [self updateTV];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(updateTV) userInfo:nil repeats:YES];
    
    [[self tableView] reloadData];
    [[self refreshControl] endRefreshing];
    
}

-(void)updateTV {
    NSManagedObjectContext *context = [[CoreDataController sharedManager] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Create a NSEntityDescription for the fetch request
    NSEntityDescription *obj = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    // Set the NSEntityDescription as the fetch request's entity
    [fetchRequest setEntity:obj];
    
    user = nil;
    user = (User *)[[context executeFetchRequest:fetchRequest error:nil] lastObject];
    countF = [NSNumber numberWithInt:[[user topics] count]];
        
    [[self tableView] reloadData];

}


@end
