//
//  AddItemViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 10/15/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataController.h"
#import "Libraries.h"

@interface AddItemViewController : UIViewController <UITableViewDataSource, RKRequestDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *submitButton;
@property (nonatomic, retain) UITextField *productName;
@property (nonatomic, retain) UITextField *productPrice;

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *imageURL;

- (void)checkForSubmitButtonEnablement:(id)sender;
- (IBAction)submit:(id)sender;

@end
