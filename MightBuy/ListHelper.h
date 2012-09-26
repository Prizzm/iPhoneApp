//
//  ListHelper.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/CoreData.h>

#import "User.h"

@interface ListHelper : NSObject

+(void)insertNewRecordFields:(NSManagedObject *)userObj andData:(NSDictionary *)d andAuthToken:(NSString *)authToken;
+(void)updateUserFields:(User *)user andData:(NSDictionary *)d andAuthToken:(NSString *)authToken;
@end
