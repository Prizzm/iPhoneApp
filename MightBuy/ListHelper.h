//
//  ListHelper.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/CoreData.h>
#import "Libraries.h"

#import "User.h"
#import "Topic.h"

@interface ListHelper : NSObject

+(void)insertNewRecordFields:(NSManagedObject *)userObj andData:(NSDictionary *)d andAuthToken:(NSString *)authToken andContect:(NSManagedObjectContext *)context;
+(void)updateUserFields:(User *)user andData:(NSDictionary *)d andAuthToken:(NSString *)authToken andContect:(NSManagedObjectContext *)context;
+(void)deleteUsersWithContext:(NSManagedObjectContext *)context;
+(void)deleteTopicsWithContext:(NSManagedObjectContext *)context;

@end
