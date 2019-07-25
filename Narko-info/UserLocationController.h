
#import <UIKit/UIKit.h>

@import GoogleMaps;

@interface UserLocationController : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>

@property (strong, nonatomic) GMSMapView *mapView;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) CLLocation *location;

- (IBAction)nextStep:(id)sender;

@end
