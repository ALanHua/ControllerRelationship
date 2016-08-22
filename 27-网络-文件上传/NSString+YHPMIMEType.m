//
//  NSString+YHPMIMEType.m
//  27-网络-文件上传
//
//  Created by yhp on 16/8/23.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "NSString+YHPMIMEType.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation NSString (YHPMIMEType)

-(NSString*)MIMEType
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:self]) {
        return nil;
    }
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge  CFStringRef)[self pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)MIMEType;
}
-(NSString*)MIMEType2
{
    NSURL* url = [NSURL fileURLWithPath:self];
    NSURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    NSURLResponse* response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}
@end
