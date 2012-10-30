//
//  TabBarViewController.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController
@synthesize authToken;
@synthesize parent;
@synthesize image;
@synthesize imageURL;

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
    UIImage *buttonImage = [UIImage imageNamed:@"center_tab_bar_icon.png"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(promptForType) forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    [self.view addSubview:button];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)promptForType {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
        [sheet showFromTabBar:self.tabBar];
    } else {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose Photo", nil];
        [sheet showFromTabBar:self.tabBar];
    }
}

-(void)openPhotoPicker:(UIImagePickerControllerSourceType)source {
    
    // Set up the camera
    UIImagePickerController *cameraController = [[UIImagePickerController alloc] init];
    cameraController.sourceType = source;
    cameraController.delegate = (id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>)self;
    
    [self presentModalViewController:cameraController animated:YES];
}

// User took an image
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)inImage
                  editingInfo:(NSDictionary *)editingInfo {
    //        </===================================================/>
    //       </ *          WARNING MULTI-THREADING            *   />
    //      </  *  BE CAREFUL, ALWAYS TEST ON COMPUTER FIRST  *  />
    //     </   *             COULD BRICK IPHONE              * />
    //    </===================================================/>
    
    // Upload Image to S3
    [NSThread detachNewThreadSelector:@selector(uploadImage:) toTarget:self withObject:[inImage thumbnailImage:400 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationDefault]];
    
    //        </===================================================/>
    //       </  *                    Done                      * />
    //      </===================================================/>
    
    // Get rid of the picker interface
    [[picker parentViewController]
     dismissModalViewControllerAnimated:YES];
    [picker dismissModalViewControllerAnimated:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    image = inImage;
}


-(NSString *)GetUUID{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString *nsstring = (__bridge NSString *)string;
    CFRelease(string);
    return nsstring;
}

-(NSString *)uploadS3Image:(UIImage *)imagee {
    // Setup S3 Access Keys
    [ASIS3Request setSharedAccessKey:@"AKIAJATKGAWCCDNFZN6Q"];
    [ASIS3Request setSharedSecretAccessKey:@"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"];
    
    // Take UIImage and convert it to a PNG and convert that to NSData
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(imagee)];
    
    // Make a path for the image using the UUID Generator
    NSString *key = [NSString stringWithFormat:@"images/%@.png", [self GetUUID]];
    
    // Create ASIS3ObjectRequest (Request to upload to S3
    ASIS3ObjectRequest *request = [ASIS3ObjectRequest PUTRequestForData:imageData withBucket:@"prizzm-invites" key:key];
    
    // Set access policy (permissions)
    [request setAccessPolicy:@"public-read"];
    
    // VERY IMPORTANT, DO NOT CHANGE
    // Set MIME type (data format)
    [request setMimeType:@"image/png"];
    
    // Start request synchronously (on another thread so it's actually async).  In other words it's running in the background even though its synchronous
    [request startSynchronous];
    
    // Check if there is a error
    if ([request error]) {
        // If there is log it
        NSLog(@"%@",[[request error] localizedDescription]);
        
        // Also return the url as @""
        return @"";
    } else {
        // If it succeeded return the file url
        [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
        return [NSString stringWithFormat:@"https://s3.amazonaws.com/prizzm-invites/%@", key];
    }
}

-(void)uploadImage:(UIImage *)imagea {
    // Upload to S3 and get url
    NSString *url = [self uploadS3Image:imagea];
    
    // set the image url on the main thread
    NSLog(@"url: %@", url);
    imageURL = url;
    [self performSegueWithIdentifier:@"gotoAddItemDetail" sender:self];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = url;

}
#pragma -mark HUD Methods
-(void)dismissProg {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

// Open Success HUD at the end
-(void)openSuccess {
    // Create hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure hud
    [hud setLabelText:@"Success"];
    [hud setMode:MBProgressHUDModeText];
    
    // dismiss hud after 2 seconds
    [self performSelector:@selector(dismissProg) withObject:nil afterDelay:2.0];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self openPhotoPicker:(UIImagePickerControllerSourceType)UIImagePickerControllerSourceTypeCamera];
        } else {
            [self openPhotoPicker:(UIImagePickerControllerSourceType)UIImagePickerControllerSourceTypePhotoLibrary];
        }
    } else if (buttonIndex == 1 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self openPhotoPicker:(UIImagePickerControllerSourceType)UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destination = [segue destinationViewController];
    if (![[segue identifier] isEqualToString:@"gobacktologin"]) {
        [(AddItemViewController *)destination setImage:image];
        [(AddItemViewController *)destination setImageURL:imageURL];
    }
}

@end
