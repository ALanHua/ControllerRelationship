//
//  ViewController.m
//  59-获取通讯录
//
//  Created by yhp on 2017/6/27.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController ()<ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 创建选择联系人的界面
    ABPeoplePickerNavigationController* ppnc = [[ABPeoplePickerNavigationController alloc]init];
    // 设置代码
    ppnc.peoplePickerDelegate = self;
    // 弹出选择联系人界面
    [self presentViewController:ppnc animated:YES completion:nil];
    
}

#pragma mark - <ABPeoplePickerNavigationControllerDelegate>
// 选择某一个联系人的时候,如果实现了该方法就不会进入联系人的详细界面啦
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    /*
     __bridge NSString* 将CoreFoundation框架的对象所有权交给Foundation框架来使用,但是Foundation框架中的对象并不能管理该对象内存
     __bridge_transfer* 将CoreFoundation框架的对象所有权交给Foundation来管理,如果Foundation中对象销毁,那么我们之前的对象(CoreFoundation)会一起销毁
     */
    // 获取联系人的姓名
    CFStringRef firstname = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef lastname = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    NSString* firstName = (__bridge_transfer NSString*)(firstname);
    NSString* lastName  = (__bridge_transfer NSString*)(lastname);
    NSLog(@"-00---%@,%@",firstName,lastName);
    // 获取电话号码
    ABMultiValueRef phones = ABRecordCopyValue(person,kABPersonPhoneProperty);
    CFIndex count =  ABMultiValueGetCount(phones);
    for (CFIndex i = 0; i < count; i++) {
      NSString* phoneLabel = (__bridge_transfer NSString *)(ABMultiValueCopyLabelAtIndex(phones, i));
       NSString* phoneValue = (__bridge_transfer NSString *)(ABMultiValueCopyValueAtIndex(phones, i));
        
      NSLog(@"-11--%@,%@",phoneLabel,phoneValue);
    }
    // 释放不在用得对象
    CFRelease(phones);
}
// 联系人的摸一个属性
// property 选中的属性
// identifier 对应标识
// 如果实现该方法，如果选中某一个联系人就会推出
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
     NSLog(@"选择某一个联系人的标识");
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    
}

@end
