//
//  ViewController.m
//  60-获取通讯录
//
//  Created by yhp on 2017/6/28.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1，判断授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    // 2，如果用户已经授权了才能获取
    if (status != kABAuthorizationStatusAuthorized) {
        return;
    }
    // 3，创建通讯录对象
    ABAddressBookRef adressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    // 4,copy 联系人
    CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(adressBook);
    CFIndex peopleCount = CFArrayGetCount(peopleArray);
    // 遍历所有联系人
    for (CFIndex i = 0; i < peopleCount; i++) {
        // 获取联系人
        ABRecordRef person = CFArrayGetValueAtIndex(peopleArray, i);
        // 获取姓名
        NSString* lastname = (__bridge_transfer NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        NSString* firstname = (__bridge_transfer NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSLog(@"%@,%@",lastname,firstname);
        // 获取电话号码
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        for (CFIndex j = 0; j < phoneCount; j++) {
            NSString* phoneLabel = (__bridge_transfer NSString *)(ABMultiValueCopyLabelAtIndex(phones, j));
            NSString *phoneValue = (__bridge_transfer NSString *)(ABMultiValueCopyValueAtIndex(phones, i));
            NSLog(@"label : %@ value : %@", phoneLabel, phoneValue);
        }
        CFRelease(phones);
    }
    // 释放对象
    CFRelease(peopleArray);
    CFRelease(adressBook);
}


@end
