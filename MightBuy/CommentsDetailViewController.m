//
//  CommentsDetailViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "CommentsDetailViewController.h"

@interface CommentsDetailViewController ()

@end

@implementation CommentsDetailViewController
@synthesize topic;
@synthesize comments;
@synthesize parent;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [MBProgressHUD showHUDAddedTo:[self view] animated:YES];
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[RKClient sharedClient] get:[NSString stringWithFormat:@"http://www.mightbuy.it/api/v1/comments?topic_shortcode=%@", [topic shortcode]] delegate:self];
    });
}

- (void)viewDidLoad
{
    [[self tableView] setBackgroundView:nil];
    [[self tableView] setBackgroundColor:[UIColor colorWithRed:237.0/255.0 green:231.0/255.0 blue:222.0/255.0 alpha:1]];
    
    [super viewDidLoad];

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)filterCommentsPress:(UIButton *)sender {
    [self performSelector:@selector(setButtonHighlighted:) withObject:sender afterDelay:0.1];
}

-(void)setButtonHighlighted:(UIButton *)button {
    [button setHighlighted:YES];
}

#pragma -mark RKRequestDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    // Create a JSON Parser to parse the response
    JSONDecoder *parser = [JSONDecoder new];
    // Parse the response using the parser
    NSArray *d = [parser objectWithData:[[response bodyAsString] dataUsingEncoding:NSUTF8StringEncoding]];
    [self setComments:d];
    int i = 0;
    if ([d count] == 0) {
        [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
    }
    for (NSDictionary *comment in d) {
        NSLog(@"UN: %@", [self getUserInfo:comment withCompleted:[NSNumber numberWithInt:i] withCount:[NSNumber numberWithInt:[d count]]]);
        i++;
    }
    [[self tableView] reloadData];
}

-(NSString *)getUserInfo:(NSDictionary *)comment withCompleted:(NSNumber *)completed withCount:(NSNumber *)count {
    JSONDecoder *parser = [JSONDecoder new];
    NSString *resp = [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mightbuy.it/api/v1/user/info.json?user_id=%@", [comment objectForKey:@"user_id"]]]] encoding:NSUTF8StringEncoding];
    NSDictionary *d = [parser objectWithData:[resp dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"civ: %i", [count intValue]);
    if ([completed intValue]+1 == [count intValue] || [count intValue] == 0) {
        [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
    }
    
    return [[d objectForKey:@"user"] objectForKey:@"name"];
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
    return [comments count];
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 85;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"t"];
//    [[cell textLabel] setText:[[comments objectAtIndex:indexPath.row] objectForKey:@"description"]];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(73, 9, 160, 21)];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(73, 34, 227, 65)];
    
    [name setBackgroundColor:[UIColor clearColor]];
    [name setText:[[[comments objectAtIndex:indexPath.row] objectForKey:@"user"] objectForKey:@"name"]];
    
    [textView setEditable:FALSE];
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setText:[[comments objectAtIndex:indexPath.row] objectForKey:@"description"]];
    
    [cell addSubview:name];
    [cell addSubview:textView];
    
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

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [MBProgressHUD showHUDAddedTo:[(ViewController *)senderVC view] animated:YES];
//    
//    [self performSelector:@selector(gotoDetailView:) withObject:indexPath afterDelay:.5];
//    
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}
@end
