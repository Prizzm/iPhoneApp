//
//  User.h
//  MightBuy
//
//  Created by Sam Baumgarten on 10/12/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Topic;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * authentication_token;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSString * current_sign_in_at;
@property (nonatomic, retain) NSString * current_sign_in_ip;
@property (nonatomic, retain) NSString * description_s;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * email_address;
@property (nonatomic, retain) NSString * facebook;
@property (nonatomic, retain) NSString * facebook_oauth_token;
@property (nonatomic, retain) NSString * facebook_uid;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * image_uid;
@property (nonatomic, retain) NSString * last_seen;
@property (nonatomic, retain) NSString * last_sign_in_at;
@property (nonatomic, retain) NSString * last_sign_in_ip;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * remember_created_at;
@property (nonatomic, retain) NSString * reset_password_sent_at;
@property (nonatomic, retain) NSString * reset_password_token;
@property (nonatomic, retain) NSNumber * sign_in_count;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * twitter_oauth_secret;
@property (nonatomic, retain) NSString * twitter_oauth_token;
@property (nonatomic, retain) NSString * twitter_uid;
@property (nonatomic, retain) NSString * updated_at;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *topics;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addTopicsObject:(Topic *)value;
- (void)removeTopicsObject:(Topic *)value;
- (void)addTopics:(NSSet *)values;
- (void)removeTopics:(NSSet *)values;

@end
