//
//  Topic.h
//  MightBuy
//
//  Created by Sam Baumgarten on 10/12/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, User;

@interface Topic : NSManagedObject

@property (nonatomic, retain) NSString * access;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSString * shortcode;
@property (nonatomic, retain) NSString * sort_id;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) User *user;
@end

@interface Topic (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
