//
//  RootViewController.h
//  MKMapView-ZoomLevel-Demo
//
//  Created by Kjuly on 6/20/13.
//  Copyright (c) 2013 Kjuly. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKMapView+ZoomLevel.h"

@interface RootViewController : UIViewController <
  MKMapViewDelegate,
  CLLocationManagerDelegate
>

@end
