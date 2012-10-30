//
//  settingsPopoverViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 10/21/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListHelper.h"
#import "CoreDataController.h"
#import "TabBarViewController.h"
#import "LoginTypeSelectorViewController.h"

@interface settingsPopoverViewController : UITableViewController
@property (nonatomic, retain) UIViewController *parent;
@end
