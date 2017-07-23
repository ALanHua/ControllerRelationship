//
//  ViewController.m
//  77-CoreLocation框架
//
//  Created by yhp on 2017/7/20.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

/** 位置管理者 */
@property(nonatomic,strong)CLLocationManager* lM;
/** 老位置 */
@property(nonatomic,strong)CLLocation* oldL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 使用位置管理者
    [self.lM startUpdatingLocation];
#if 0
    // 唯独相差一度，相距大概110km
    CLLocation* l1 = [[CLLocation alloc]initWithLatitude:21.123 longitude:123.456];
    CLLocation* l2 = [[CLLocation alloc]initWithLatitude:22.123 longitude:123.456];
    CLLocationDistance distance = [l1 distanceFromLocation:l2];
    
    NSLog(@"%lf",distance);
#endif
    
    // [self.lM requestLocation];
    
}

#pragma mark -懒加载
- (CLLocationManager *)lM
{
    if (!_lM) {
        _lM  = [[CLLocationManager alloc]init];
        // 1.1 设置代理
        _lM.delegate = self;
        // 每个多远定位一次
        // _lM.distanceFilter = 100;
        /**
         kCLLocationAccuracyBestForNavigation // 最适合导航
         kCLLocationAccuracyBest; // 最好的
         kCLLocationAccuracyNearestTenMeters; // 10m
         kCLLocationAccuracyHundredMeters; // 100m
         kCLLocationAccuracyKilometer; // 1000m
         kCLLocationAccuracyThreeKilometers; // 3000m
         */
        // 精确度越高, 越耗电, 定位时间越长
        _lM.desiredAccuracy = kCLLocationAccuracyBest;
        
        
        /*********************适配******************************/
        //        if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
        //
        //            //        [_lM requestWhenInUseAuthorization];
        //            [_lM requestAlwaysAuthorization];
        //        }
        
        if ([_lM respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_lM requestWhenInUseAuthorization];
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0){
                _lM.allowsBackgroundLocationUpdates = YES;
            }
            //             [_lM requestAlwaysAuthorization];
        }
        
        
    }
    return _lM;
}

#pragma mark - <<CLLocationManagerDelegate>>
/**
 更新到位置之后调用
 @param manager 位置管理者
 @param locations 位置数组
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    // NSLog(@"更新位置");
    /*
     coordinate: 经纬度坐标
     altitude：海拔
     course:航向
     speed：速度
     */
    CLLocation* location = [locations lastObject];
//    NSLog(@"%@",location);
    
    // 1，获取方向偏向
    NSString* angleStr = nil;
    switch ((int)(location.course / 90)) {
        case 0:
            angleStr = @"北偏东";
            break;
        case 1:
             angleStr = @"东偏南";
            break;
        case 2:
             angleStr = @"南偏西";
            break;
        case 3:
             angleStr = @"西偏北";
            break;
        default:
             angleStr = @"不知道去哪里啦";
            break;
    }
    // 2,偏向角度
    NSInteger angle = 0;
    angle = (int)location.course % 90;
    if (angle == 0) {
        NSRange range = NSMakeRange(0, 1);
        angleStr = [NSString stringWithFormat:@"正%@",[angleStr substringWithRange:range]];
    }
    
    
    // 3，移动多少米
    double distance = 0;
    if (_oldL) {
        distance = [location distanceFromLocation:_oldL];
    }
    _oldL = location;
    // 4,拼串打印
    NSString* noticStr = nil;
    
    if (angle) {
        noticStr = [NSString stringWithFormat:@"%@%zd方向,移动了%lf米",angleStr,angle,distance];
    }else{
        noticStr = [NSString stringWithFormat:@"%@方向,移动了%lf米",angleStr,distance];
    }

    
    NSLog(@"%@",noticStr);
    // 停止更新
    //    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定");
            break;
        }
            // 问受限
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
            // 定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位开启，但被拒");
            }else
            {
                NSLog(@"定位关闭，不可用");
            }
            //            NSLog(@"被拒");
            break;
        }
            // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
            //        case kCLAuthorizationStatusAuthorized: // 失效，不建议使用
        {
            NSLog(@"获取前后台定位授权");
            break;
        }
            // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台定位授权");
            break;
        }
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
}

@end
