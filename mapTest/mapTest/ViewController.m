//
//  ViewController.m
//  mapTest
//
//  Created by 李弋 on 9/2/15.
//  Copyright (c) 2015 LeeYi. All rights reserved.
//

#import "ViewController.h"
#import "BaiduMapAPI/BMKUserLocation.h"

@interface ViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
{
    BMKLocationService *locService;
    BMKPoiSearch *search;
}
@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    CGRect ret = [UIScreen mainScreen].applicationFrame;
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 100,ret.size.width , ret.size.height-100)];
    
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
    [self.mapshowView addSubview:_mapView];
    locService =  [[BMKLocationService alloc]init];
//    [_mapshowView sizeToFit];
    
   
//    NSLog(@"heading is %@",locService.userLocation.heading);
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
}

-(void)viewWillAppear:(BOOL)animated
{

    _mapView.delegate = self;
    _mapView.userTrackingMode =  BMKUserTrackingModeFollow;
    _mapView.zoomLevel = 17;
    
    locService.delegate = self;
    [locService startUserLocationService];
//    BMKLocationViewDisplayParam * testParam = [[BMKLocationViewDisplayParam alloc]init];
     [_mapView viewWillAppear];
    _mapView.showsUserLocation = YES;

//    _mapView updateLocationViewWithParam:(BMKLocationViewDisplayParam *)
    // 此处记得不用的时候需要置nil，否则影响内存的释放
}

//-(void)viewDidAppear:(BOOL)animated {
//    //    _mapView setCenter
//    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(locService.userLocation.location.coordinate.latitude,locService.userLocation.location.coordinate.longitude) animated:YES];
//}

- (IBAction)searchPOI:(id)sender {
}




-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}
@end
