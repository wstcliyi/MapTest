//
//  AppDelegate.h
//  mapTest
//
//  Created by 李弋 on 9/2/15.
//  Copyright (c) 2015 LeeYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonHeaderForMap.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BMKMapManager * mapManager;


@end

