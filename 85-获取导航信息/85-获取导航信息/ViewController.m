//
//  ViewController.m
//  85-获取导航信息
//
//  Created by yhp on 2017/8/23.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()


/** CLGeocoder */
@property(nonatomic,strong)CLGeocoder* geoC;
@end

@implementation ViewController

- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc]init];
    }
    return _geoC;
}


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.geoC geocodeAddressString:@"广州" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark* gzP = [placemarks firstObject];
        
        [self.geoC geocodeAddressString:@"杭州" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark* hzP = [placemarks firstObject];
            
            [self getRouteWithBeginPL:gzP andEndPL:hzP];
            
        }];
        
    }];
    
}

-(void)getRouteWithBeginPL:(CLPlacemark*)beginP andEndPL:(CLPlacemark*)endP
{
    MKDirectionsRequest* request = [[MKDirectionsRequest alloc]init];
    //    起点
    CLPlacemark* clP = beginP;
    MKPlacemark* mkP = [[MKPlacemark alloc]initWithPlacemark:clP];
    MKMapItem* sourceItem = [[MKMapItem alloc]initWithPlacemark:mkP];
    request.source = sourceItem;
    
    //   终点
    CLPlacemark* clP2 = endP;
    MKPlacemark* mkP2 = [[MKPlacemark alloc]initWithPlacemark:clP2];
    MKMapItem* sourceItem2 = [[MKMapItem alloc]initWithPlacemark:mkP2];
    request.destination = sourceItem2;
    
    MKDirections* direction = [[MKDirections alloc]initWithRequest:request];
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        /*
        NSArray<MKRoute *> *routes
        name: 路线名称
        distance: 距离 
        expectedTravelTime:预期时间
        polyline: 折线(数据模型)
        NSArray<MKRouteStep *> *steps;
            instructions: 行走提示
        */
        [response.routes enumerateObjectsUsingBlock:^(MKRoute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@",obj.name);
            [obj.steps enumerateObjectsUsingBlock:^(MKRouteStep * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@",obj.instructions);
            }];
        }];
        
    }];
}


@end
