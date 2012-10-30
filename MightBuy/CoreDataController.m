//
//  CoreDataController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/28/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "CoreDataController.h"

@implementation CoreDataController
@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;

+ (id)sharedManager {
    static CoreDataController *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Core Data stack

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

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
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

- (NSURL *)applicationDocumentsDirectory {
    // Returns a NSURL to the path of the app's sandbox
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
