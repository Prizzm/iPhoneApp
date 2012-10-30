//
//  CommentNavTableViewViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/17/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "CommentNavTableViewViewController.h"

@interface CommentNavTableViewViewController ()

@end

@implementation CommentNavTableViewViewController
@synthesize senderVc;
@synthesize topic;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected:");
    [[[self navigationController] parentViewController] performSegueWithIdentifier:@"gotoComments" sender:self];
    return indexPath;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CommentsDetailViewController *controller = [segue destinationViewController];
    [controller setTopic:topic];
    NSLog(@"seg2");
}


@end
