//
//  UIImage+YHPExtension.h
//  56-二维码
//
//  Created by yhp on 2017/6/21.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YHPExtension)

+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

@end
