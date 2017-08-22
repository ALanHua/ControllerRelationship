//
//  ViewController.m
//  84-利用系统app导航
//
//  Created by yhp on 2017/8/22.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
/**  */
@property(nonatomic,strong)CLGeocoder* goC;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (CLGeocoder *)goC
{
    if (!_goC) {
        _goC = [[CLGeocoder alloc]init];
    }
    return _goC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    MKMapSnapshotOptions * option = [[MKMapSnapshotOptions alloc]init];
//    针对地图
    option.region = self.mapView.region;
    option.showsBuildings = YES;
//    针对输出图片
    option.size = CGSizeMake(1000, 2000);
    option.scale = [UIScreen mainScreen].scale;
    
    MKMapSnapshotter* snap = [[MKMapSnapshotter alloc]initWithOptions:option];
    [snap startWithCompletionHandler:^(MKMapSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        UIImage* image = snapshot.image;
        if (error == nil) {
            NSData* data = UIImagePNGRepresentation(image);
            [data writeToFile:@"/Users/smartwater/Downloads/snap.png" atomically:YES];
        }else{
            NSLog(@"---%@",error.localizedDescription);
        }
        
    }];
}

-(void)setUp3DCamera
{
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:CLLocationCoordinate2DMake(23.132931, 113.375924) fromEyeCoordinate:CLLocationCoordinate2DMake(23.135931, 113.375924) eyeAltitude:10];

    self.mapView.camera = camera;
}

-(void)beginNav
{
    [self.goC geocodeAddressString:@"广州" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark* gzP = [placemarks firstObject];
        
        [self.goC geocodeAddressString:@"上海" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark* shP = [placemarks firstObject];
            
            [self beginWithNavBpl:gzP andEndP:shP];
        }];
        
    }];
}

-(void)beginWithNavBpl:(CLPlacemark*)beginP andEndP :(CLPlacemark*)endP
{
    //    地图想数组
    CLPlacemark* clpB = beginP;
    MKPlacemark* mkpB = [[MKPlacemark alloc]initWithPlacemark:clpB];
    MKMapItem* beginI = [[MKMapItem alloc]initWithPlacemark:mkpB];
    
    CLPlacemark* clp = endP;
    MKPlacemark* mkp = [[MKPlacemark alloc]initWithPlacemark:clp];
    MKMapItem* endI  = [[MKMapItem alloc]initWithPlacemark:mkp];
    
    NSArray* items = @[beginI,endI];
    //    启动字典
    NSDictionary* dic =@{
                         MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                         MKLaunchOptionsMapTypeKey: @(MKMapTypeHybrid),
                         MKLaunchOptionsShowsTrafficKey: @(YES)
                         };
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}

@end
