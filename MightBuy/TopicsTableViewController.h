//
//  TopicsTableViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"
#import "CoreDataController.h"

#import "TopicCell.h"

#import "User.h"
#import "Topic.h"

@interface TopicsTableViewController : UITableViewController {
    NSTimer *timer;
}

@property (nonatomic, retain) id senderVC;

@property (readonly, strong, nonatomic) NSNumber *countF;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;

-(void)endRef;

@end
