//
//  ViewController.m
//  82-MapKit框架
//
//  Created by yhp on 2017/8/3.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
/** 位置管理者 */
@property(nonatomic,strong)CLLocationManager* lm;
@end

@implementation ViewController


- (CLLocationManager *)lm
{
    if (!_lm) {
        _lm = [[CLLocationManager alloc]init];
        if ([_lm respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_lm requestAlwaysAuthorization];
        }
    }
    return _lm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.mapView.mapType = MKMapTypeHybridFlyover;
//    self.mapView.zoomEnabled = YES;
//    self.mapView.showsScale = YES;
//    self.mapView.showsCompass = YES;
    [self lm];
//    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
}


@end
