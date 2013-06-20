//
//  RootViewController.m
//  MKMapView-ZoomLevel-Demo
//
//  Created by Kjuly on 6/20/13.
//  Copyright (c) 2013 Kjuly. All rights reserved.
//

#import "RootViewController.h"

// Zoom level: 0 ~ 20
#define kKYMapViewWithZoomLevelDemoDefaultZoomLevel_ 16

@interface RootViewController () {
 @private
  BOOL _isCurrentLocationLocated;
  NSInteger _zoomLevel;
}

@property (nonatomic, strong) MKMapView         * mapView;
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic, strong) CLLocation        * location;

- (void)_updateMapViewToZoomLevel:(NSInteger)zoomLevel
                         animated:(BOOL)animated;

@end


@implementation RootViewController

@synthesize mapView         = _mapView;
@synthesize locationManager = _locationManager,
            location        = _location;

- (id)init
{
  if (self = [super init]) {
    _isCurrentLocationLocated = NO;
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager setDistanceFilter:100.f];
  }
  return self;
}

- (void)loadView
{
  self.view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, {kKYViewWidth, kKYViewHeight}}];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Map View
  _mapView = [[MKMapView alloc] initWithFrame:(CGRect){CGPointZero, self.view.frame.size}];
  [_mapView setDelegate:self];
  [_mapView setShowsUserLocation:YES];
  [self.view addSubview:_mapView];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // Start tracking user's location
  [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  // Stop tracking user's location
  [self.locationManager stopUpdatingLocation];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  
  self.mapView = nil;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Private

// Update map view to desired zoom level
- (void)_updateMapViewToZoomLevel:(NSInteger)zoomLevel
                         animated:(BOOL)animated
{
  // Use |self.mapView.centerCoordinate| to zoom based on map center point
  // Or use |self.location.coordinate| to zoom based on user's current location point
  [self.mapView setCenterCoordinate:self.mapView.centerCoordinate
                          zoomLevel:zoomLevel
                           animated:animated];
}

#pragma mark - CLLocationManagerDelegate

// Tells the delegate that a new location value is available.
// Available in iOS 2.0 and later.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
  self.location = newLocation;
  
  // Update map view to current user's location with default zoom level
  if (! _isCurrentLocationLocated) {
    [self.mapView setCenterCoordinate:self.location.coordinate
                            zoomLevel:kKYMapViewWithZoomLevelDemoDefaultZoomLevel_
                             animated:YES];
  }
}

// Asks the delegate whether the heading calibration alert should be displayed.
// Available in iOS 3.0 and later.
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
  return YES;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  NSLog(@"Error: %@", [error description]);
}

#pragma mark - MKMapViewDelegate

// Tells the delegate that the region displayed by the map view just changed
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
  _zoomLevel = [self.mapView zoomLevel];
  
  // *** Do actions here for changed map region with zoom level
}

@end
