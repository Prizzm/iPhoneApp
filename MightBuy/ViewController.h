//
//  ViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"

#import "User.h"

#import "TopicsTableViewController.h"
#import "ProductDetailViewController.h"
#import "settingsPopoverViewController.h"

#import "ListHelper.h"
#import "CoreDataController.h"

#import "TopicCell.h"

@interface ViewController : UIViewController <RKRequestDelegate, UITableViewDataSource, WEPopoverControllerDelegate>

@property (nonatomic, retain) NSString *productTitle;

@property (nonatomic, retain) TopicsTableViewController *tvc;
@property (nonatomic, retain) WEPopoverController *wpopoverController;

-(void)getUserData;

- (IBAction)gotoSettings:(id)sender;
@end
