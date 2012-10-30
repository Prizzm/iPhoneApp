//
//  UIImage+scale.m
//  MightBuy
//
//  Created by Sam Baumgarten on 9/28/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "UIImage+scale.h"

@implementation UIImage (scale)
- (UIImage *)imageByScaleingToSize:(CGSize)newSize {
    // Creates a new image context with the new size
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    // Calls drawInRect on the image
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    // Creates a new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image
    return newImage;
}
@end
