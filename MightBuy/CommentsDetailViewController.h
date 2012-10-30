//
//  CommentsDetailViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"
#import "Topic.h"
#import "CommentsViewController.h"

@interface CommentsDetailViewController : UITableViewController <RKRequestDelegate>
@property (strong, nonatomic) Topic *topic;
@property (nonatomic, retain) NSArray *comments;
@property (nonatomic, retain) CommentsViewController *parent;
- (IBAction)filterCommentsPress:(UIButton *)sender;

@end
