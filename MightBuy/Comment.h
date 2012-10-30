//
//  Comment.h
//  MightBuy
//
//  Created by Sam Baumgarten on 10/12/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Topic, User;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) Topic *topic;
@property (nonatomic, retain) User *user;

@end
