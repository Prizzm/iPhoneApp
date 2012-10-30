//
//  TopicCell.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "TopicCell.h"

@implementation TopicCell
@synthesize title;
@synthesize price;
@synthesize image;
@synthesize imageBackground;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
