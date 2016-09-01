//
//  NSObject+YHPExtension.m
//  39-网络-网页相关
//
//  Created by yhp on 16/8/31.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "NSObject+YHPExtension.h"

@implementation NSObject (YHPExtension)
-(id)performSelector:(SEL)selector withObjects:(NSArray*)objects
{
    //    NSInvocation : 利用一个NSInvocation对象包装方法调用
    NSMethodSignature* signature = [[self class] instanceMethodSignatureForSelector:selector];
    
    if (signature == nil) {
        // 抛异常
//       @throw [NSException exceptionWithName:@"error" reason:@"方法找不到" userInfo:nil];
        [NSException raise:@"error" format:@"%@",NSStringFromSelector(selector)];
    }
    
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    NSInteger paramsCount = signature.numberOfArguments-2;
    paramsCount = MIN(paramsCount, objects.count);
    // 设置参数
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) {
            continue;
        }
        [invocation setArgument:&object atIndex:i+2];
    }
    // 调用方法
    [invocation invoke];
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) {
        [invocation getReturnValue:&returnValue];
    }

    return returnValue;
}
@end
