//
//  CommentNavTableViewViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/17/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"
#import "Topic.h"
#import "CoreDataController.h"
#import "ListHelper.h"
#import "CommentsDetailViewController.h"

@interface CommentNavTableViewViewController : UITableViewController <UITableViewDelegate>
@property (nonatomic, retain) id senderVc;
@property (strong, nonatomic) Topic *topic;

@end
