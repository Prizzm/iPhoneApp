//
//  SignUpViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 10/22/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "EmailLoginViewController.h"

@interface EmailLoginViewController ()

@end

@implementation EmailLoginViewController
@synthesize emailField;
@synthesize passwordField;
@synthesize fullName;
@synthesize authToken;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[[self navigationController] navigationBar] setBackgroundImage:[[UIImage imageNamed:@"plain_nav_bar.png"] imageByScaleingToSize:CGSizeMake(320, 44)] forBarMetrics:UIBarMetricsDefault];
    [[self navigationItem] setTitle:@"Sign In With Email"];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [RKClient clientWithBaseURLString:@"https://www.mightbuy.it"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    [imageView setImage:[UIImage imageNamed:@"mainBG.png"]];
    [bgView addSubview:imageView];
    
    [[self tableView] setBackgroundView:bgView];
    
    UIBarButtonItem *bbir = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    [bbir setTitle:@"Sign In"];
    
    [[self navigationItem] setRightBarButtonItem:bbir];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    switch ([indexPath row]) {
        case 0:
            fullName = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 300, 43)];
            [fullName setPlaceholder:@"Username"];
            [fullName addTarget:self action:@selector(checkForSubmitButtonEnablement:) forControlEvents:UIControlEventEditingChanged];
            [fullName setReturnKeyType:UIReturnKeyNext];
            [fullName addTarget:self action:@selector(gotoPassword) forControlEvents:UIControlEventEditingDidEndOnExit];
            [cell addSubview:fullName];
            break;
            
        case 1:
            emailField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 300, 43)];
            [emailField setPlaceholder:@"Password"];
            [emailField setSecureTextEntry:YES];
            [emailField setReturnKeyType:UIReturnKeyGo];
            [emailField addTarget:self action:@selector(checkForSubmitButtonEnablement:) forControlEvents:UIControlEventEditingChanged];
            [emailField addTarget:self action:@selector(submit) forControlEvents:UIControlEventEditingDidEndOnExit];
            [cell addSubview:emailField];
            break;

    }
    
    return cell;
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)checkForSubmitButtonEnablement:(id)sender {

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)submit {
    NSLog(@"sub");
    
    [self loginWithUN:fullName.text andPW:emailField.text];
}

-(void)loginWithUN:(NSString *)username andPW:(NSString *)password {
    // Create Variables
    NSDictionary *dataDict;
        // If it isn't empty, post data with price
        dataDict = [NSDictionary dictionaryWithObjects:@[username, password] forKeys:@[@"email", @"password"]];
        
    [[RKClient sharedClient] post:@"/api/v1/tokens.json" params:dataDict delegate:self];
}

-(BOOL)stringIsEmpty:(NSString *)variable {
    if (variable == nil || [variable isEqualToString:@""]) {
        return true;
    } else {
        return false;
    }
}

-(void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error {
    NSLog(@"error: %@", error);
}

-(void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    NSLog(@"resp: %@", [response bodyAsString]);
    JSONDecoder *parser = [JSONDecoder new];
    // Parse the response using the parser
    NSDictionary *d = [parser objectWithData:[[response bodyAsString] dataUsingEncoding:NSUTF8StringEncoding]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([d objectForKey:@"message"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[d objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        [defaults setObject:[d objectForKey:@"token"] forKey:@"auth_token"];
        
        [self setAuthToken:[d objectForKey:@"token"]];
        
        int64_t delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self performSegueWithIdentifier:@"gotoMainApp" sender:self];
        });
    }
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

-(void)gotoPassword {
    [self gotoField:emailField];
}

             
-(void)gotoField:(UITextField *)dest {
    [dest becomeFirstResponder];
}

@end
