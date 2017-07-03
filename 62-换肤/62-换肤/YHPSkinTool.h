//
//  YHPSkinTool.h
//  62-换肤
//
//  Created by yhp on 2017/6/30.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPSkinTool : NSObject

+(void)setSkinColor:(NSString*)skinColor;
+(UIImage*)skinToolWithImageName:(NSString*)imageName;
+(UIColor*)skinToolWithabelColor;

@end
