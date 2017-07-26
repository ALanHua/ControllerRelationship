//
//  ViewController.m
//  80-地理编码及反地理编码
//
//  Created by yhp on 2017/7/25.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *addressTV;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTF;
@property (weak, nonatomic) IBOutlet UITextField *longtitudeTF;

/** 地理编码 */
@property(nonatomic,strong)CLGeocoder* geoC;
@end

@implementation ViewController

#pragma mark - 懒加载
- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc]init];
    }
    
    return _geoC;
}
- (IBAction)geoCoder {
    
    NSString* addressName = self.addressTV.text;
    if ([addressName isEqualToString:@""]) {
        return;
    }
    // 地理编码
    [self.geoC geocodeAddressString:addressName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        /**
         *  CLPlacemark
            location: 位置对象
            addressDictionary 地址字典
            name 地址全称
         */
        
        if (error == nil) {
            
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                self.latitudeTF.text = @(obj.location.coordinate.latitude).stringValue;
                self.longtitudeTF.text = @(obj.location.coordinate.longitude).stringValue;
            }];
        }else{
            NSLog(@"error:%@",error);
        }
        
    }];
}
- (IBAction)reverseGeoCoder {
    
    double ratitude   = self.latitudeTF.text.doubleValue;
    double longtitude = self.longtitudeTF.text.doubleValue;
    
    if (ratitude == 0 || longtitude == 0) {
        return;
    }
    
    CLLocation* loc = [[CLLocation alloc]initWithLatitude: ratitude   longitude:longtitude];
    
    [self.geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil) {
            
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                self.addressTV.text = obj.name;
            }];
        }else{
            NSLog(@"error:%@",error);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}


@end
