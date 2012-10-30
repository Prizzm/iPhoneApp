//
//  ProductDetailViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/17/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
@synthesize navBar;
@synthesize productName;
@synthesize productImage;
@synthesize productPrice;

@synthesize productNameLabel;
@synthesize productImageView;
@synthesize ProductUIImageView;
@synthesize productPriceLabel;
@synthesize commentsButtonContainer;
@synthesize mainScroll;
@synthesize topic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [[self navBar] setBackgroundImage:[[UIImage imageNamed:@"texture_navigation_bar_detail.png"] imageByScaleingToSize:CGSizeMake(320, 43)] forBarMetrics:UIBarMetricsDefault];
    [[[self navBar] topItem] setTitle:productName];
    
    [[self productNameLabel] setText:productName];
    [[self productNameLabel] setFont:[UIFont fontWithName:@"Museo-300" size:15]];
    
    [[self productPriceLabel] setText:productPrice];
    [[self productPriceLabel] setFont:[UIFont fontWithName:@"Museo-300" size:15]];
    
    [[self ProductUIImageView] setImage:productImage];
    if ([[UIScreen mainScreen] bounds].size.height == 568.0) {
        [[self mainScroll] setContentSize:CGSizeMake(320, 474)];
    } else {
        [[self mainScroll] setContentSize:CGSizeMake(320, 400)];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setProductNameLabel:nil];
    [self setNavBar:nil];
    [self setProductImageView:nil];
    [self setProductUIImageView:nil];
    [self setProductPriceLabel:nil];
    [self setCommentsButtonContainer:nil];
    [self setMainScroll:nil];
    [super viewDidUnload];
}

- (IBAction)goBack {
    NSLog(@"back");
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)share:(id)sender {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CommentsDetailViewController *controller = [segue destinationViewController];
    [controller setTopic:topic];
    
    NSLog(@"ct: %@", controller.topic);
}

@end
