//
//  ProductDetailViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/17/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"
#import "Topic.h"
#import "CommentsDetailViewController.h"

@interface ProductDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet NSString *productName;
@property (strong, nonatomic) IBOutlet NSString *productPrice;
@property (strong, nonatomic) IBOutlet UIImage *productImage;
@property (strong, nonatomic) Topic *topic;

@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UIView *productImageView;
@property (strong, nonatomic) IBOutlet UIImageView *ProductUIImageView;
@property (strong, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (strong, nonatomic) IBOutlet UIView *commentsButtonContainer;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScroll;

- (IBAction)goBack;
- (IBAction)share:(id)sender;

@end
