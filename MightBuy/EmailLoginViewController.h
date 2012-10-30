//
//  SignUpViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 10/22/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"

#import "TabBarViewController.h"

@interface EmailLoginViewController : UITableViewController <RKRequestDelegate>
@property (nonatomic, retain) UITextField *fullName;
@property (nonatomic, retain) UITextField *emailField;
@property (nonatomic, retain) UITextField *passwordField;

@property (retain, nonatomic) NSString *authToken;

@end
