//
//  LoginSelectorViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/11/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "LoginSelectorViewController.h"
#import "TabBarViewController.h"

@interface LoginSelectorViewController ()

@end

@implementation LoginSelectorViewController
@synthesize signUpButton;
@synthesize signInButton;

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
    [[signUpButton titleLabel] setFont:[UIFont fontWithName:@"Museo-300" size:25]];
    [[signUpButton titleLabel] setTextColor:[UIColor whiteColor]];
    
    [[signInButton titleLabel] setFont:[UIFont fontWithName:@"Museo-300" size:25]];
    [[signInButton titleLabel] setTextColor:[UIColor blackColor]];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self performSelector:@selector(checkForTrans) withObject:nil afterDelay:.1];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

-(void)checkForTrans {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"tst: %@", [defaults stringForKey:@"auth_token"]);
    if ([defaults stringForKey:@"auth_token"] != nil && ![(NSString *)[defaults stringArrayForKey:@"auth_token"] isEqualToString:@""]) {
        NSLog(@"g");
        [self performSegueWithIdentifier:@"gotoMainApp" sender:self];
    }
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
    [self setSignUpButton:nil];
    [self setSignInButton:nil];
    [super viewDidUnload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    /*
     When a row is selected, the segue creates the detail view controller as the destination.
     Set the detail view controller's detail item to the item associated with the selected row.
     */
    if ([[segue identifier] isEqualToString:@"gotoMainApp"]) {
        TabBarViewController *detailViewController = [segue destinationViewController];
        [detailViewController setAuthToken:[[NSUserDefaults standardUserDefaults] stringForKey:@"auth_token"]];
        [detailViewController setParent:self];
    }
}
@end
