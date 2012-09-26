//
//  Topic.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/8/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Topic : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * access;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * shortcode;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) User *users;

@end
