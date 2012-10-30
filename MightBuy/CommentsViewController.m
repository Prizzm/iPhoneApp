//
//  CommentsViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "CommentsViewController.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController
@synthesize navBar;
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
    [navBar setBackgroundImage:[[UIImage imageNamed:@"texture_navbar_comments_bg.png"] imageByScaleingToSize:CGSizeMake(320, 44)] forBarMetrics:UIBarMetricsDefault];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
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
    [self setNavBar:nil];
    [super viewDidUnload];
}
- (IBAction)goBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[segue destinationViewController] setTopic:topic];
}
@end
