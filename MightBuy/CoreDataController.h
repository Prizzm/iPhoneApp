//
//  CoreDataController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/28/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataController : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(id)sharedManager;

- (NSManagedObjectContext *)managedObjectContext;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end