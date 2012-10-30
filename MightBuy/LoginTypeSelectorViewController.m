//
//  LoginTypeSelectorViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/11/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "LoginTypeSelectorViewController.h"

@interface LoginTypeSelectorViewController ()

@end

@implementation LoginTypeSelectorViewController
@synthesize navBar;
@synthesize authToken;
@synthesize engine;
@synthesize parent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [[[self navigationController] navigationBar] setBackgroundImage:[[UIImage imageNamed:@"plain_nav_bar.png"] imageByScaleingToSize:CGSizeMake(320, 44)] forBarMetrics:UIBarMetricsDefault];
    [[self navigationItem] setTitle:@"Login"];
}

- (void)viewDidLoad
{
    [RKClient clientWithBaseURLString:@"https://www.mightbuy.it"];
    
    // Set the background image of the navigation bar to texture_navigation_bar.png (Assets/Images/Textures/)
    
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
    [self setNavBar:nil];
    [super viewDidUnload];
}

#pragma -mark Helpers

- (IBAction)loginWithFacebook:(id)sender {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [FBSession openActiveSessionWithPermissions:nil allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState status,
                                                      NSError *error) {
                                      if (session.isOpen) {
                                          FBRequest *me = [[FBRequest alloc] initWithSession:session graphPath:@"me"];
                                          
                                          [me startWithCompletionHandler: ^(FBRequestConnection *connection, 
                                                                            NSDictionary<FBGraphUser> *my,
                                                                            NSError *error) {
                                              NSLog(@"Login Success: %@", my);
                                              [[RKClient sharedClient] get:[NSString stringWithFormat:@"/tokens/facebook?token=%@", [my objectForKey:@"id"]] delegate:self];
                                          }];
                                      }
                                  }];
}

- (IBAction)loginWithTwitter:(id)sender {
    [[RKClient sharedClient] get:@"/tokens/twitter?token=617502137" delegate:self];

////    [[RKClient sharedClient] get:[NSString stringWithFormat:@"/tokens/twitter?token=%@", @"703866404"] delegate:self];
//        if (!engine) {
//            engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
//            engine.consumerKey    = kOAuthConsumerKey;
//            engine.consumerSecret = kOAuthConsumerSecret;    
//    }  
//      
//    UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:engine delegate:self];  
//      
//    if (controller){  
//        [self presentModalViewController: controller animated: YES];
//    }
}

#pragma mark SA_OAuthTwitterEngineDelegate  
- (void) storeCachedTwitterOAuthData:(NSString *)data forUsername:(NSString *)username {        
    NSLog(@"data: %@", [data componentsSeparatedByString:@"&"]);
    [[RKClient sharedClient] get:[NSString stringWithFormat:@"/tokens/twitter?token=%@&oauth_token=%@&oauth_secret=%@&name=%@", [[[data componentsSeparatedByString:@"&"] objectAtIndex:2] stringByReplacingOccurrencesOfString:@"user_id=" withString:@""], [[[data componentsSeparatedByString:@"&"] objectAtIndex:0] stringByReplacingOccurrencesOfString:@"oauth_token=" withString:@""], [[[data componentsSeparatedByString:@"&"] objectAtIndex:1] stringByReplacingOccurrencesOfString:@"oauth_token_secret=" withString:@""], [[[data componentsSeparatedByString:@"&"] objectAtIndex:3] stringByReplacingOccurrencesOfString:@"screen_name=" withString:@""]] delegate:self];
}  
  
- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
    return @"";
}

-(void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    // Create a JSON Parser to parse the response
    JSONDecoder *parser = [JSONDecoder new];
    // Parse the response using the parser
    NSDictionary *d = [parser objectWithData:[[response bodyAsString] dataUsingEncoding:NSUTF8StringEncoding]];

    NSLog(@"d: %@", d);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[d objectForKey:@"token"] forKey:@"auth_token"];
    
    [self setAuthToken:[d objectForKey:@"token"]];
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self performSegueWithIdentifier:@"gotoMainApp" sender:self]; 
    });
}

-(void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error {
    NSLog(@"e: %@", [error debugDescription]);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    /*
     When a row is selected, the segue creates the detail view controller as the destination.
     Set the detail view controller's detail item to the item associated with the selected row.
     */
    if ([[segue identifier] isEqualToString:@"gotoMainApp"]) {
        TabBarViewController *detailViewController = [segue destinationViewController];
        [detailViewController setAuthToken:authToken];
        [detailViewController setParent:self];
    }
}
@end
