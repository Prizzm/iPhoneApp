//
//  CommentNavViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/17/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "CommentNavViewController.h"
#import "ProductDetailViewController.h"

@interface CommentNavViewController ()

@end

@implementation CommentNavViewController
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
    self.navigationBar.hidden = YES;
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

-(void)viewDidAppear:(BOOL)animated {
    [self performSelector:@selector(log) withObject:nil afterDelay:0.01];
    [super viewDidAppear:animated];
}

-(void)log {
    [self setTopic:[(ProductDetailViewController *)[self parentViewController] topic]];
    [[[self viewControllers] objectAtIndex:0] setTopic:topic];

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CommentsDetailViewController *controller = [segue destinationViewController];
    [controller setTopic:topic];
    NSLog(@"seg");
}

@end
