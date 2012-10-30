//
//  TopicCell.h
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libraries.h"

@interface TopicCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *price;
@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UIImageView *imageBackground;
@end
