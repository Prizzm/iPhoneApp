//
//  TabBarViewController.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"
#import "SidebarViewController.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "CoreDataController.h"
#import "AddItemViewController.h"

@interface TabBarViewController : UITabBarController <UIImagePickerControllerDelegate, UIActionSheetDelegate, JTRevealSidebarV2Delegate, UITableViewDelegate> {
    
    BOOL isTakingPhoto;
}

@property (retain, nonatomic) NSString *authToken;
@property (nonatomic, strong) SidebarViewController *leftSidebarViewController;
@property (nonatomic, strong) UITableView *rightSidebarView;
@property (nonatomic, strong) NSIndexPath *leftSelectedIndexPath;
@property (nonatomic, strong) UILabel     *label;
@property (nonatomic, retain) UIViewController *parent;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *imageURL;

-(void)openPhotoPicker;

@end
