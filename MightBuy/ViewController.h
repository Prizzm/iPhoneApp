//
//  ViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/JSONKit.h>
#import <RestKit/CoreData.h>

#import "User.h"

#import "ListHelper.h"
#import "TopicCell.h"

@interface ViewController : UIViewController <RKRequestDelegate, UITableViewDataSource>
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (IBAction)gotoSettings:(id)sender;
@end
