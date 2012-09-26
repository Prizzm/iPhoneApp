//
//  ViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;
@synthesize navBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create a local variable for managedObjectContext
    NSManagedObjectContext *context = [self managedObjectContext];
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
        User *user = (User *)[[context executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];

        // Add processing code here
    }
    
    // Set the background image of the navigation bar to texture_navigation_bar.png (Assets/Images/Textures/)
    [navBar setBackgroundImage:[self imageWithImage:[UIImage imageNamed:@"texture_navigation_bar.png"] scaledToSize:CGSizeMake(320, 44)] forBarMetrics:UIBarMetricsDefault];
    
    // Set the base URL for all the requests
    [RKClient clientWithBaseURLString:@"http://mightbuy.it"];
    
    // Call getUserData to start retrieving the user's information
    [self getUserData];
}

- (void)viewDidUnload
{
    [self setNavBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)saveContext
{
    // Create a NSError and set it to nil
    NSError *error = nil;
    // Check if managedObjectContext exists
    if (managedObjectContext != nil) {
        // If it does check if it has changed and if there are any errors when it is saved
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // If there is a error when saving, this is called
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    // check if managedObjectContext exists
    if (managedObjectContext != nil) {
        // If it does return it and complete the method
        return managedObjectContext;
    }
    // Create a local variable for persistentStoreCoordinator
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    // Check if it exists
    if (coordinator != nil) {
        // If it does set it to a new allocated version of it
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        // Set the new managedObjectContext's Persistent Store Coordinator
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    // Return the managedObjectContext
    return managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    // check if managedObjectModel exists
    if (managedObjectModel != nil) {
        // If it does return it and complete the method
        return managedObjectModel;
    }
    // Create a url for the datastore
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataStore" withExtension:@"momd"];
    // Create a managedObjectModel from the datastore
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    // Return the managedObjectModel
    return managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    // Check if persistentStoreCoordinator exists
    if (persistentStoreCoordinator != nil) {
        // If it does return it and complete the method
        return persistentStoreCoordinator;
    }
    // Creates a URL by taking the documents directory in the app sandbox and getting the sqlite database file
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DataStore.sqlite"];
    // Creates a NSError and sets it to nil
    NSError *error = nil;
    // Sets persistentStoreCoordinator to a new NSPersistentStoreCoordinator with the User Model
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    // Try and add the NSPersistentStoreCoordinator to the coordinator
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // If it fails, this will be called
        /*                  
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    // Returns persistentStoreCoordinator
    return persistentStoreCoordinator;
}

#pragma -mark Helpers

-(void)getUserData {
    // This makes a request to the MightBuy API to get the users information
    [[RKClient sharedClient] get:@"/api/v1/user/info.json?auth_token=nTsCeycm4WQpMBcGbnwP" delegate:self];
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    // Returns a NSURL to the path of the app's sandbox
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    // Creates a new image context with the new size
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    // Calls drawInRect on the image
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    // Creates a new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image
    return newImage;
}

#pragma -mark RKRequestDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    // Create a JSON Parser to parse the response
    JSONDecoder *parser = [JSONDecoder new];
    // Parse the response using the parser
    NSDictionary *d = [[parser objectWithData:[[response bodyAsString] dataUsingEncoding:NSUTF8StringEncoding]] objectForKey:@"user"];
    
    // Set local variable (context) to managedObjectContext
    NSManagedObjectContext *context = [self managedObjectContext];
    // Create a fetch request to see if User exists
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Create a NSEntityDescription so the fetch request knows where to look
    NSEntityDescription *obj = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    // Set the NSEntityDescription as the entity of the fetch request
    [fetchRequest setEntity:obj];
    
    // Check if a user record exists
    if (![[context executeFetchRequest:fetchRequest error:nil] count] > 0) {
        // If it doesn't create a new User record
        NSManagedObject *userObj = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"User"
                                    inManagedObjectContext:context];
        // This helper method validates the data and puts it into the entity (see ListHelper.m)
        [ListHelper insertNewRecordFields:userObj andData:d andAuthToken:@"nTsCeycm4WQpMBcGbnwP"];
        // Saves the User Record
        [self saveContext];
    } else {
        // If a user record does exist ...
        // Find the user
        User *user = (User *)[[context executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
        // This helper method validates the data and puts it into the user record (see ListHelper.m)
        [ListHelper updateUserFields:user andData:d andAuthToken:@"nTsCeycm4WQpMBcGbnwP"];
    }
}

#pragma -mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topiccell"];
    [[cell title] setText:@"Test"];
    [[cell title] setFont:[UIFont fontWithName:@"Museo-700" size:15]];
    return cell;
}

#pragma -mark - Actions

- (IBAction)gotoSettings:(id)sender {

}

@end
