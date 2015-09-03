//
//  ViewController.m
//  mapTest
//
//  Created by 李弋 on 9/2/15.
//  Copyright (c) 2015 LeeYi. All rights reserved.
//

#import "ViewController.h"
#import "BaiduMapAPI/BMKUserLocation.h"
#import "BaiduMapApi/BMKPoiSearch.h"

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
    search = [[BMKPoiSearch alloc]init];
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
    [self.mapshowView addSubview:_mapView];
    locService =  [[BMKLocationService alloc]init];
//    [_mapshowView sizeToFit];
    
   
//    NSLog(@"heading is %@",locService.userLocation.heading);
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    _mapView.delegate = self;
    _mapView.userTrackingMode =  BMKUserTrackingModeFollow;
    _mapView.zoomLevel = 17;
    search.delegate = self;
    locService.delegate = self;
    [locService startUserLocationService];
    //    BMKLocationViewDisplayParam * testParam = [[BMKLocationViewDisplayParam alloc]init];
    [_mapView viewWillAppear];
    _mapView.showsUserLocation = YES;
    
    
    //    _mapView updateLocationViewWithParam:(BMKLocationViewDisplayParam *)
    // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated
{
    search.delegate = nil;
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}





- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
//    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
}


//-(void)viewDidAppear:(BOOL)animated {
//    //    _mapView setCenter
//    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(locService.userLocation.location.coordinate.latitude,locService.userLocation.location.coordinate.longitude) animated:YES];
//}

- (IBAction)searchPOI:(id)sender {
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 10;
    option.radius = 1000;
   
    option.location = locService.userLocation.location.coordinate;
    
    option.keyword = _searchTextField.text;
    BOOL flag = [search poiSearchNearBy:option];
    
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
}

- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < poiResultList.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [poiResultList.poiInfoList objectAtIndex:i];
//            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//            item.coordinate = poi.pt;
//            item.title = poi.name;
//            [annotations addObject:item];
            NSLog(@"%@",poi.name);
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
        
        
        //在此处理正常结果
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
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
