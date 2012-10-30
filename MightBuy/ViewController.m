//
//  ViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "ViewController.h"
#import "TabBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize tvc;
@synthesize productTitle;
@synthesize wpopoverController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create a local variable for managedObjectContext
    NSManagedObjectContext *context = [[CoreDataController sharedManager] managedObjectContext];
    // Create a fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Create a NSEntityDescription for the fetch request
    NSEntityDescription *obj = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    // Set the NSEntityDescription as the fetch request's entity
    [fetchRequest setEntity:obj];
    
    // Check if a user exists
    if ([[context executeFetchRequest:fetchRequest error:nil] count] > 0) {
        // If it does ...
        // Create a new User instance with the contents of that db record
//        User *user = (User *)[[context executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
        // Add processing code here
    }
    
    // Set the base URL for all the requests
    [RKClient clientWithBaseURLString:@"https://www.mightbuy.it"];
    
    // Call getUserData to start retrieving the user's information
    [self getUserData];
    
    tvc = [[TopicsTableViewController alloc] init];
    if ([[UIScreen mainScreen] bounds].size.height == 568.0) {
        [[tvc view] setFrame:CGRectMake(0, 45, 320, 502)];
    } else {
        [[tvc view] setFrame:CGRectMake(0, 45, 320, 415)];
    }
    [tvc setSenderVC:self];
    [self addChildViewController:tvc];
    [self.view addSubview:tvc.view];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self getUserData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma -mark Helpers

-(void)getUserData {
    // This makes a request to the MightBuy API to get the users information
    [[RKClient sharedClient] get:[NSString stringWithFormat:@"/api/v1/user/info.json?auth_token=%@", [(TabBarViewController *)[self tabBarController] authToken]] delegate:self];
}

#pragma -mark RKRequestDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    // Create a JSON Parser to parse the response
    JSONDecoder *parser = [JSONDecoder new];
    // Parse the response using the parser
    NSDictionary *d = [[parser objectWithData:[[response bodyAsString] dataUsingEncoding:NSUTF8StringEncoding]] objectForKey:@"user"];
        NSLog(@"d: %@", [response bodyAsString]);
        // If a user record does exist ...
        // Find the user
        NSLog(@"refresh:::");
        // This helper method validates the data and puts it into the user record (see ListHelper.m)
        [ListHelper updateUserFields:nil andData:d andAuthToken:[(TabBarViewController *)[self tabBarController] authToken] andContect:[[CoreDataController sharedManager] managedObjectContext]];
        
        [[CoreDataController sharedManager] saveContext];
    [tvc endRef];
}

#pragma -mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topiccell"];

    [[cell title] setText:@"iPhone 4S"];
    [[cell title] setFont:[UIFont fontWithName:@"Museo-300" size:15]];
    
    [[cell price] setText:@"$199"];
    [[cell price] setTextColor:[UIColor colorWithRed:0.0 green:137.0/255.0 blue:200.0/255.0 alpha:1.0]];
    [[cell price] setFont:[UIFont fontWithName:@"Museo-300" size:13]];
    
    return cell;
}

#pragma -mark - Actions

- (IBAction)gotoSettings:(id)sender {
    settingsPopoverViewController *secondView = [[settingsPopoverViewController alloc] init];
    [secondView setParent:self];
    [secondView setContentSizeForViewInPopover:CGSizeMake(160, 41)];
     wpopoverController = [[WEPopoverController alloc] initWithContentViewController:secondView];
    [wpopoverController setDelegate:self];
    [wpopoverController presentPopoverFromRect:[sender frame] inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [wpopoverController setPopoverContentSize:CGSizeMake(330, 225)];
    
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSSortDescriptor *lastNameSorter = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO selector:@selector(localizedStandardCompare:)];
    NSArray *userD = [[[[tvc user] topics] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:lastNameSorter]];
    [(ProductDetailViewController *)segue.destinationViewController setProductName:[[userD objectAtIndex:[[tvc selectedIndexPath] row]] subject]];

    [(ProductDetailViewController *)segue.destinationViewController setTopic:[userD objectAtIndex:[[tvc selectedIndexPath] row]]];
    
    [(ProductDetailViewController *)segue.destinationViewController setProductPrice:[NSString stringWithFormat:@"$%.02f", [[(Topic *)[userD objectAtIndex:[[tvc selectedIndexPath] row]] price] floatValue]]];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[userD objectAtIndex:[[tvc selectedIndexPath] row]] image_url]]];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [(ProductDetailViewController *)segue.destinationViewController setProductImage:[UIImage imageWithData:imageData]];
}

#pragma -mark WEPopoverControllerDelegate
-(void)popoverControllerDidDismissPopover:(WEPopoverController *)popoverController {
    
}

-(BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)popoverController {
    return TRUE;
}

@end
