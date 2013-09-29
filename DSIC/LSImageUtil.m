//
//  LSImageUtil.m
//  security
//
//  Created by 孟 智 on 13-9-24.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSImageUtil.h"

@implementation LSImageUtil


+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}
@end
