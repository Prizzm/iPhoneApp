//
//  AddItemViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 10/15/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController
@synthesize image;
@synthesize imageURL;
@synthesize productName;
@synthesize productPrice;
@synthesize haveSwitch;
@synthesize submitButton;
@synthesize tableView;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[RKClient sharedClient] setBaseURL:[RKURL URLWithBaseURLString:@"https://www.mightbuy.it"]];
    
    [[self tableView] setBackgroundView:nil];
    
    image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 218, 300, 300)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [[self view] addSubview:bgView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 218, 280, 300)];
    [imageView setImage:image];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [[self view] addSubview:imageView];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        
    switch ([indexPath row]) {
        case 0:
            productName = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 300, 43)];
            [productName setPlaceholder:@"Product's Name"];
            [productName addTarget:self action:@selector(checkForSubmitButtonEnablement:) forControlEvents:UIControlEventEditingChanged];
            [cell addSubview:productName];
            break;
        
        case 1:
            productPrice = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 300, 43)];
            [productPrice setPlaceholder:@"Price"];
            [productPrice setKeyboardType:UIKeyboardTypeDecimalPad];
            [productPrice addTarget:self action:@selector(checkForSubmitButtonEnablement:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:productPrice];
            break;
        case 2:
            [[cell textLabel] setText:@"I have"];
            [[cell textLabel] setFont:[UIFont systemFontOfSize:16]];
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

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

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 2) {
        if ([[tableview cellForRowAtIndexPath:indexPath] accessoryType] ==  UITableViewCellAccessoryCheckmark) {
            [[tableview cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
        } else {
            [[tableview cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
}

-(BOOL)hasItemChecked {
    if ([[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]] accessoryType] ==  UITableViewCellAccessoryCheckmark) {
        return true;
    } else {
        return false;
    }
}


- (void)viewDidUnload {
    [self setTableView:nil];
    [self setSubmitButton:nil];
    [super viewDidUnload];
}
- (void)checkForSubmitButtonEnablement:(id)sender {
    if ([[productName text] isEqualToString:@""] || [productName text] == nil) {
        [submitButton setEnabled:NO];
    } else {
        [submitButton setEnabled:YES];
    }
}

- (IBAction)submit:(id)sender {
    // Create Variables
    NSDictionary *rootDict;
    NSDictionary *dataDict;
    
    NSLog(@"haveSwitch.selected: %i", [self hasItemChecked]);
    NSLog(@"price: %@", productPrice.text);
    // Check if price is empty
    if ([productPrice.text isEqualToString:@""] || productPrice.text == nil) {
        // If so post data without price
        dataDict = [NSDictionary dictionaryWithObjects:@[productName.text, @"private", imageURL,@"recommendation", @"true", ([self hasItemChecked]) ? @"ihave" : @"imightbuy"] forKeys:@[@"subject", @"access", @"mobile_image_url", @"form", @"recommendable", @"status"]];
        
    } else {
        // If it isn't empty, post data with price
        dataDict = [NSDictionary dictionaryWithObjects:@[productName.text, productPrice.text, @"private", imageURL, @"recommendation", @"true", ([self hasItemChecked]) ? @"ihave" : @"imightbuy"] forKeys:@[@"subject", @"price", @"access", @"mobile_image_url", @"form", @"recommendable", @"status"]];
    }
    
    // Create topic dictionary to hold the data
    rootDict = [NSDictionary dictionaryWithObjects:@[dataDict] forKeys:@[@"topic"]];

    [[RKClient sharedClient] post:[NSString stringWithFormat:@"/topics?auth_token=%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"auth_token"]] params:rootDict delegate:self];
    
    [MBProgressHUD showHUDAddedTo:[self view] animated:YES];
}

#pragma -mark RKRequestDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    [self dismissModalViewControllerAnimated:YES];
    [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
    
}

-(void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error {
    NSLog(@"error: %@", error);
}
@end
