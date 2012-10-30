//
//  CommentsViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"
#import "Topic.h"
#import "UIPView.h"

@interface CommentsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) Topic *topic;

- (IBAction)goBack:(id)sender;

@end
