//
//  ViewController.h
//  mapTest
//
//  Created by 李弋 on 9/2/15.
//  Copyright (c) 2015 LeeYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonHeaderForMap.h"
@interface ViewController : UIViewController
@property (nonatomic, strong) BMKMapView* mapView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIView *mapshowView;

@end

