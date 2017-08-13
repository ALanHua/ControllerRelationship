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

@interface ViewController ()<MKMapViewDelegate>
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
    self.mapView.mapType = MKMapTypeStandard;
//    self.mapView.zoomEnabled = YES;
//    self.mapView.showsScale = YES;
//    self.mapView.showsCompass = YES;
    [self lm];
    self.mapView.showsUserLocation = YES;
//    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
}

#pragma mark - <MKMapViewDelegate>

/**
 更新到位置

 @param mapView 地图
 @param userLocation 位置对象
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    userLocation.title = @"yhp";
    userLocation.subtitle = @"andy";
    
    //  设置地图展示中心
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.055737, 0.001);
    MKCoordinateRegion reginon = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [self.mapView setRegion:reginon animated:YES];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
//    NSLog(@"%f,%f",mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta);
}


@end
