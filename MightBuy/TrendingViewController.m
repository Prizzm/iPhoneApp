//
//  TrendingViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 10/3/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "TrendingViewController.h"

@interface TrendingViewController ()

@end

@implementation TrendingViewController
@synthesize c1;
@synthesize c2;
@synthesize c3;
@synthesize scrollview;

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
//    [self setupC1];
//    [self setupC2];
//    [self setupC3];
/*    CGPoint c1i = CGPointMake(7, 10);
    CGPoint c2i = CGPointMake(114, 10);
    CGPoint c3i = CGPointMake(219, 10);
    
    for (int i = 0; i < 10; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(c1i.x, c1i.y, 95, 95)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [view setTag:1];
        [[self scrollview] addSubview:view];
        c1i = CGPointMake(c1i.x, c1i.y+105);
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(c2i.x, c2i.y, 95, 95)];
        [view2 setBackgroundColor:[UIColor whiteColor]];
        [view2 setTag:2];
        [[self scrollview] addSubview:view2];
        c2i = CGPointMake(c2i.x, c2i.y+105);
        
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(c3i.x, c3i.y, 95, 95)];
        [view3 setBackgroundColor:[UIColor whiteColor]];
        [view3 setTag:3];
        [[self scrollview] addSubview:view3];
        c3i = CGPointMake(c3i.x, c3i.y+105);
    }

    
    [self performSelectorInBackground:@selector(setupC1) withObject:nil]; */
    [super viewDidLoad];

}

-(void)setupC1 {
    NSArray *images = [[NSArray alloc] initWithObjects:
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIrMjAxMi8xMC8wMi8wMC8yNC8xNy80NC9LaW5nX1RyaXRvbi5qcGcGOgZFVFsIOgZwOgp0aHVtYkkiDDI1NHgyMTYGOwZG", // https://www.mightbuy.it/topics/X1389b-kiel-james-patrick-anchorwrap
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSI8MjAxMi8xMC8wMi8wNC8zNy81Ni84MjEvS1Rfc2xhdGVfMDJfbGcuX1YzODkzOTQ1MzJfLmpwZwY6BkVUWwg6BnA6CnRodW1iSSIMMjU0eDIxNgY7BkY", // https://www.mightbuy.it/topics/PYH1Qd-kindle-fire-hd-most-advanced-7-tablet-only-199
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJ7MjAxMi8xMC8wMi8wNC80MC81Ni85NDAvQkFoYkJsc0hPZ1ptU1NJNk1qQXhNaTh4TUM4d01pOHdOQzh6T1M4eU1TODBOVEl2TkRGeE9XdExUbGRXUmt3dVgxTk1OVEF3WDBGQk16QXdYeTVxY0djR09nWkZWQQY6BkVUWwg6BnA6CnRodW1iSSIMMjU0eDIxNgY7BkY", // https://www.mightbuy.it/topics/rf64NZ-amazon-com-toshiba-32c120u-32-inch-720p-60hz-lcd-hdtv-black-electronics
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJEMjAxMi8wOS8zMC8wMS80NS8zOS80Ni83QjlCQ0E1M183ODUxXzQxNENfOEIxM18xOUY5MDQ0NzRGN0UucG5nBjoGRVRbCDoGcDoKdGh1bWJJIgwyNTR4MjE2BjsGRg", // https://www.mightbuy.it/topics/61J93r-rei-awesome-tent
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJFMjAxMi8wOS8yOC8wMS8zMS8wMi85NTgvQ0FDQjNGMjNfQ0VBRF80MjVDX0E2NTBfNTlDQjgxNkM4RjM3LnBuZwY6BkVUWwg6BnA6CnRodW1iSSIMMjU0eDIxNgY7BkY", // https://www.mightbuy.it/topics/Q9Yavs-ice-watch
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIxMjAxMi8wOS8yNy8xNy8yOS8yOS8zMy9zN181MTg4ODlfaW1hZ2VzZXRfMDMGOgZFVFsIOgZwOgp0aHVtYkkiDTE4N3gxMzcjBjsGRg",
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIoMjAxMi8wOS8yNi8wMC8wOC8zOS84NTYvMjY0NjUxX21haW4GOgZFVFsIOgZwOgp0aHVtYkkiDTE4N3gxMzcjBjsGRg",
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJHMjAxMi8wOS8yNS8yMC8xNS80OS81MjQvNzkzMmExZDI0YjNhMDlhYTI0YjE5MDc3MjAwNWUzODNfbGFyZ2UuanBnBjoGRVRbCDoGcDoKdGh1bWJJIg0xODd4MTM3IwY7BkY",
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJEMjAxMi8wOS8yNC8yMS81My8xOC84Ny9ERjQ4OEY2Ml84NDBEXzQ1QjVfQjJBOF8zMzJCMjFFMTlCODEucG5nBjoGRVRbCDoGcDoKdGh1bWJJIg0xODd4MTM3IwY7BkY",
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIrMjAxMi8wOS8yNS8yMC80Ni8wNi8xNjAvbW91dGhmdWxfMi5qcGcGOgZFVFsIOgZwOgp0aHVtYkkiDDI1NHgyMTYGOwZG",
        @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSI7MjAxMi8wOS8yNC8wNS8xNy8wOC83NTAvZjE1MTNfaGlnaGxpZ2h0X3NtXzVlbmdpbmUucG5nBjoGRVRbCDoGcDoKdGh1bWJJIg0xODd4MTM3IwY7BkY", nil];
    NSMutableArray *sizeArray = [[NSMutableArray alloc] init];
    [self setC1:CGPointMake(7, 10)];
    
    for (int i = 0; i < 10; i++) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[images objectAtIndex:i]]]];
//        int height = arc4random() %200;
        int height = image.size.height*(95/image.size.width);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(c1.x, c1.y, 95, height)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [[self scrollview] addSubview:view];
        [sizeArray addObject:[NSNumber numberWithInt:height]];
        [self setC1:CGPointMake(c1.x, c1.y+height+10)];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setFrame:CGRectMake(5, 5, 85, height-10)];
        [imageView setImage:image];        
        [view addSubview:imageView];
    }
    
    int total_height = 10;
    for (NSNumber *num in sizeArray) {
        total_height = total_height+num.intValue+10;
    }
    NSLog(@"th: %i", total_height);
    [[self scrollview] setContentSize:CGSizeMake(320, total_height)];
    
    for (UIView *view in self.scrollview.subviews) {
        if (view.tag == 1) {
            [view removeFromSuperview];
        }
    }
    
    [self performSelectorInBackground:@selector(setupC2) withObject:nil];
}

-(void)setupC2 {
    NSArray *images = [[NSArray alloc] initWithObjects:@"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJFMjAxMi8wOS8yNC8xNi80MC80Mi81ODAvMUJERDcwMDVfRjM0NF80MDA1XzgyM0FfMkU4MTA2NDA5MjQzLnBuZwY6BkVUWwg6BnA6CnRodW1iSSIMMjU0eDIxNgY7BkY", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSImMjAxMi8wOS8yNS8xOS80MS8wMC84Mi9iYWtlcnkuanBnBjoGRVRbCDoGcDoKdGh1bWJJIgwyNTR4MjE2BjsGRg", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSI+MjAxMi8wOS8yNC8yMS8zNS80NS8zOTUvMTc5MDYxXzI3ODA2MTQ1X2Nhc2VpcGhvbmU1X2IuanBnBjoGRVRbCDoGcDoKdGh1bWJJIgwyNTR4MjE2BjsGRg", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIzMjAxMi8wOS8yNC8yMS8xNy80OC81NjcvaWxfNTcweE4uMzMyODI4MTIxLmpwZwY6BkVUWwg6BnA6CnRodW1iSSIMMjU0eDIxNgY7BkY", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSI8MjAxMi8wOS8yNC8xNy81NC80My80NzYvS0pfc2xhdGVfMDJfbGcuX1YzODk2OTE0NzhfLmpwZwY6BkVUWwg6BnA6CnRodW1iSSINMTg3eDEzNyMGOwZG", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSInMjAxMi8wOS8yNC8xNy8xNC81OS80MDAvT05FQ09MLmpwZwY6BkVUWwg6BnA6CnRodW1iSSINMTg3eDEzNyMGOwZG", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSInMjAxMi8wOS8yNC8xNy8xNC81OS80MDAvT05FQ09MLmpwZwY6BkVUWwg6BnA6CnRodW1iSSINMTg3eDEzNyMGOwZG", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIpMjAxMi8wOS8yNS8yMC8wNy81OC81NC9pbWFnZTF4eGwuanBnBjoGRVRbCDoGcDoKdGh1bWJJIg0xODd4MTM3IwY7BkY", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSI7MjAxMi8wOS8yNS8yMC8zMy8xOS8xNDQvTmlrZV9GdWVsQmFuZF9XTTAxMDVfMDAxX0EuanBnBjoGRVRbCDoGcDoKdGh1bWJJIg0xODd4MTM3IwY7BkY", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIxMjAxMi8wOS8yNC8yMC81NS81MC84MTcvNzc5MjU3MDgwMF8xXzFfMy5qcGcGOgZFVFsIOgZwOgp0aHVtYkkiDTE4N3gxMzcjBjsGRg", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSI8MjAxMi8wOS8yNC8xNy81NC8wOS81MzkvbG91cGVfZ2FsbGVyeV9zdGlsbF9ub2hpcmVzLmpwZwY6BkVUWwg6BnA6CnRodW1iSSINMTg3eDEzNyMGOwZG", nil];
    NSMutableArray *sizeArray = [[NSMutableArray alloc] init];
    [self setC2:CGPointMake(114, 10)];
    
    for (int i = 0; i < 10; i++) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[images objectAtIndex:i]]]];
        //        int height = arc4random() %200;
        int height = image.size.height*(95/image.size.width);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(c2.x, c2.y, 95, height)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [[self scrollview] addSubview:view];
        [sizeArray addObject:[NSNumber numberWithInt:height]];
        [self setC2:CGPointMake(c2.x, c2.y+height+10)];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setFrame:CGRectMake(5, 5, 85, height-10)];
        [imageView setImage:image];
        [view addSubview:imageView];
    }
    
    int total_height = 10;
    for (NSNumber *num in sizeArray) {
        total_height = total_height+num.intValue+10;
    }
    NSLog(@"th: %i", total_height);
    if (scrollview.contentSize.height < total_height) {
        [[self scrollview] setContentSize:CGSizeMake(320, total_height)];
    }
    for (UIView *view in self.scrollview.subviews) {
        if (view.tag == 2) {
            [view removeFromSuperview];
        }
    }
    [self performSelectorInBackground:@selector(setupC3) withObject:nil];
}

-(void)setupC3 {
    NSArray *images = [[NSArray alloc] initWithObjects:@"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIsMjAxMi8xMC8wMi8wMi8wNS8yMC83NzUvS2luZ19Ucml0b24uanBnBjoGRVRbCDoGcDoKdGh1bWJJIg0xODd4MTM3IwY7BkY", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSI8MjAxMi8xMC8wMi8wNC8zNy81Ni84MjEvS1Rfc2xhdGVfMDJfbGcuX1YzODkzOTQ1MzJfLmpwZwY6BkVUWwg6BnA6CnRodW1iSSINMTg3eDEzNyMGOwZG", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJ7MjAxMi8xMC8wMi8wNC80MC81Ni85NDAvQkFoYkJsc0hPZ1ptU1NJNk1qQXhNaTh4TUM4d01pOHdOQzh6T1M4eU1TODBOVEl2TkRGeE9XdExUbGRXUmt3dVgxTk1OVEF3WDBGQk16QXdYeTVxY0djR09nWkZWQQY6BkVUWwg6BnA6CnRodW1iSSINMTg3eDEzNyMGOwZG", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJEMjAxMi8wOS8zMC8wMS80NS8zOS80Ni83QjlCQ0E1M183ODUxXzQxNENfOEIxM18xOUY5MDQ0NzRGN0UucG5nBjoGRVRbCDoGcDoKdGh1bWJJIg0xODd4MTM3IwY7BkY", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJFMjAxMi8wOS8yOC8wMS8zMS8wMi85NTgvQ0FDQjNGMjNfQ0VBRF80MjVDX0E2NTBfNTlDQjgxNkM4RjM3LnBuZwY6BkVUWwg6BnA6CnRodW1iSSINMTg3eDEzNyMGOwZG", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIxMjAxMi8wOS8yNy8xNy8yOS8yOS8zMy9zN181MTg4ODlfaW1hZ2VzZXRfMDMGOgZFVFsIOgZwOgp0aHVtYkkiDTE4N3gxMzcjBjsGRg", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIoMjAxMi8wOS8yNi8wMC8wOC8zOS84NTYvMjY0NjUxX21haW4GOgZFVFsIOgZwOgp0aHVtYkkiDTE4N3gxMzcjBjsGRg", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJHMjAxMi8wOS8yNS8yMC8xNS80OS81MjQvNzkzMmExZDI0YjNhMDlhYTI0YjE5MDc3MjAwNWUzODNfbGFyZ2UuanBnBjoGRVRbCDoGcDoKdGh1bWJJIg0xODd4MTM3IwY7BkY", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSJEMjAxMi8wOS8yNC8yMS81My8xOC84Ny9ERjQ4OEY2Ml84NDBEXzQ1QjVfQjJBOF8zMzJCMjFFMTlCODEucG5nBjoGRVRbCDoGcDoKdGh1bWJJIg0xODd4MTM3IwY7BkY", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSIrMjAxMi8wOS8yNS8yMC80Ni8wNi8xNjAvbW91dGhmdWxfMi5qcGcGOgZFVFsIOgZwOgp0aHVtYkkiDDI1NHgyMTYGOwZG", @"https://www.mightbuy.it/media/BAhbB1sHOgZmSSI7MjAxMi8wOS8yNC8wNS8xNy8wOC83NTAvZjE1MTNfaGlnaGxpZ2h0X3NtXzVlbmdpbmUucG5nBjoGRVRbCDoGcDoKdGh1bWJJIg0xODd4MTM3IwY7BkY", nil];
    NSMutableArray *sizeArray = [[NSMutableArray alloc] init];
    [self setC3:CGPointMake(219, 10)];
    
    for (int i = 0; i < 10; i++) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[images objectAtIndex:i]]]];
        //        int height = arc4random() %200;
        int height = image.size.height*(95/image.size.width);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(c3.x, c3.y, 95, height)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [[self scrollview] addSubview:view];
        [sizeArray addObject:[NSNumber numberWithInt:height]];
        [self setC3:CGPointMake(c3.x, c3.y+height+10)];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setFrame:CGRectMake(5, 5, 85, height-10)];
        [imageView setImage:image];
        [view addSubview:imageView];
    }
    
    int total_height = 10;
    for (NSNumber *num in sizeArray) {
        total_height = total_height+num.intValue+10;
    }
    NSLog(@"th: %i", total_height);
    if (scrollview.contentSize.height < total_height) {
        [[self scrollview] setContentSize:CGSizeMake(320, total_height)];
    }
    for (UIView *view in self.scrollview.subviews) {
        if (view.tag == 3) {
            [view removeFromSuperview];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollview:nil];
    [super viewDidUnload];
}
@end
