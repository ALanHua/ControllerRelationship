//
//  ViewController.m
//  61-第三方框架获取通讯录
//
//  Created by yhp on 2017/6/28.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <RHAddressBook/AddressBook.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    RHAuthorizationStatus status = [RHAddressBook authorizationStatus];
    if (status != RHAuthorizationStatusAuthorized) {
        return;
    }
    
    // 创建通讯录
    RHAddressBook* addressBook = [[RHAddressBook alloc]init];
    NSArray* people =  addressBook.people;
    for (RHPerson* person in people) {
        // 获取联系人的姓名
        NSLog(@"%@,%@\n",person.firstName,person.lastName);
        // 获取电话号码
        RHMultiValue* phones = person.phoneNumbers;
        for (int i = 0; i < phones.count; i++) {
            // 获取电话号码
            NSString* phoneLabel = [phones labelAtIndex:i];
            NSString* phoneValue = [phones valueAtIndex:i];
            NSLog(@"phoneLabel:%@,phoneValue:%@\n",phoneLabel,phoneValue);
        }
    }
    
}


@end
