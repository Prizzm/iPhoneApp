//
//  LoginTypeSelectorViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/11/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"
#import "TabBarViewController.h"

@interface LoginTypeSelectorViewController : UIViewController <RKRequestDelegate, SA_OAuthTwitterControllerDelegate>
@property (nonatomic, retain) SA_OAuthTwitterEngine *engine;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (retain, nonatomic) NSString *authToken;
@property (nonatomic, retain) UIViewController *parent;
- (IBAction)loginWithFacebook:(id)sender;
- (IBAction)loginWithTwitter:(id)sender;

@end
