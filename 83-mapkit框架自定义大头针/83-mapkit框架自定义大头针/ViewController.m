//
//  ViewController.m
//  83-mapkit框架自定义大头针
//
//  Created by yhp on 2017/8/20.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "YHPAnno.h"

@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

/** 编码 */
@property(nonatomic,strong)CLGeocoder* geoC;
@end

@implementation ViewController


-(CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc]init];
    }
    return _geoC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    1，获取当前触摸点
    CGPoint point = [[touches anyObject]locationInView:self.mapView];
//    2，转换成经纬度
    CLLocationCoordinate2D pt = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
//    3，添加大头针
    [self addAnnoWithPt:pt];
}

-(void)addAnnoWithPt:(CLLocationCoordinate2D)pt
{
    __block YHPAnno* anno = [[YHPAnno alloc]init];
    anno.coordinate = pt;
    anno.title = @"Andy";
    anno.subtitle = @"yhp";
    anno.type = arc4random_uniform(5);
    [self.mapView addAnnotation:anno];
    
    CLLocation* loc = [[CLLocation alloc]initWithLatitude:anno.coordinate.latitude longitude:anno.coordinate.longitude];
    
    [self.geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * pl = [placemarks firstObject];
        anno.title = pl.locality;
        anno.subtitle = pl.thoroughfare;
    }];
    
//    添加多个大头针
//    self.mapView addAnnotations:<#(nonnull NSArray<id<MKAnnotation>> *)#>
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    移除大头针
//    NSArray* annos = self.mapView.annotations;
//    [self.mapView removeAnnotations:annos];
}

#pragma mark - <MKMapViewDelegate>
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    static NSString* inden = @"datouzzhen";
    MKAnnotationView* pin =  [mapView dequeueReusableAnnotationViewWithIdentifier:inden];
    
    if (pin == nil) {
        pin = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:inden];
    }
    
    pin.annotation = annotation;
    // 设置是否弹出标注
    pin.canShowCallout = YES;
    
    YHPAnno *anno = (YHPAnno*)annotation;
    NSString* imageName = [NSString stringWithFormat:@"category_%zd",anno.type + 1];
    pin.image = [UIImage imageNamed:imageName];
    pin.draggable = YES;
    
    UIImageView* iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    iv.image = [UIImage imageNamed:@"htl"];
    pin.leftCalloutAccessoryView = iv;
    
    UIImageView *ivR = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    ivR.image = [UIImage imageNamed:@"eason"];
    pin.rightCalloutAccessoryView = ivR;
    
   if( [[[UIDevice currentDevice]systemVersion]floatValue] >= 9.0)
   {
       pin.detailCalloutAccessoryView = [[UISwitch alloc]init];
   }
    
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
   NSLog(@"选中");
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"不选中");
}


-(MKPinAnnotationView*)systemAnnoWithMapView:(MKMapView*)mapView andAnnotation:(id<MKAnnotation>)annotation
{
    //    return nil;
    static NSString* inden = @"datouzzhen";
    MKPinAnnotationView* pin = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:inden];
    
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:inden];
    }
    
    pin.annotation = annotation;
    // 设置是否弹出标注
    pin.canShowCallout = YES;
    pin.pinTintColor = [UIColor orangeColor];
    pin.animatesDrop = YES;
    //    系统大头针无效
    //    pin.image = [UIImage imageNamed:@"category_2"];
    pin.draggable = YES;
    
    return pin;
}

@end
