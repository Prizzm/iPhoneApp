//
//  CommentNavViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/17/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"
#import "Topic.h"

@interface CommentNavViewController : UINavigationController
@property (strong, nonatomic) Topic *topic;

@end
