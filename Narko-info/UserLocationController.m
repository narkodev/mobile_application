
#import "UserLocationController.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "SaveDataSingleton.h"

@interface UserLocationController ()
{
    GMSMarker *marker;
}
@end

@implementation UserLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Увага!"
                                                          message:@"Встановiть точку на карті, на те мicцi де Ви помітили розповсюдження наркотикiв."
                                                         delegate:nil
                                                cancelButtonTitle:@"Закрити"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
    
    [self initLocationManager];
}

- (void)initLocationManager {
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    self.locationManager.delegate = self;
    
    self.locationManager.distanceFilter = 50;
    
    self.location = [[CLLocation alloc] init];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    self.location = locations.lastObject;

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.location.coordinate.latitude
                                                            longitude:self.location.coordinate.longitude
                                                                 zoom:18
                                                              bearing:0
                                                         viewingAngle:0];

    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];

    self.mapView.mapType = kGMSTypeNormal;

    [self.mapView setMinZoom:18 maxZoom:30];

    self.mapView.myLocationEnabled = YES;

    self.mapView.settings.myLocationButton = YES;
    

    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(self.location.coordinate.latitude, self.location.coordinate.longitude);
    
    [self addMarker:position];
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {

    [mapView clear];
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    
    [self addMarker:position];
    
}


- (void)addMarker:(CLLocationCoordinate2D)position {
    
    marker = [GMSMarker markerWithPosition:position];
    
    marker.title = @"Ваше місцеположення";
    
    marker.map = self.mapView;
    
    SaveDataSingleton *sharedManager = [SaveDataSingleton sharedManager];
    
    [sharedManager.dataList setObject:[NSString stringWithFormat:@"%f", position.latitude] forKey:@"latitude"];

    [sharedManager.dataList setObject:[NSString stringWithFormat:@"%f", position.longitude] forKey:@"longitude"];
}

- (IBAction)nextStep:(id)sender {
    
    NSLog(@"go to photo");
    
    //        SaveDataSingleton *sharedManager = [SaveDataSingleton sharedManager];
    //
    //        NSLog(@"%@", [sharedManager.dataList objectForKey:@"latitude"]);
    //        NSLog(@"%@", [sharedManager.dataList objectForKey:@"longitude"]);
    
//    [SaveDataSingleton sendDataByAPI];
    
    [self performSegueWithIdentifier:@"goToAttachPhoto" sender:self];
    
}

@end
