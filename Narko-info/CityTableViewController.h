
#import <UIKit/UIKit.h>

@class OrganizationController;

@interface CityTableViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, retain) NSArray* cities;

@property (nonatomic, retain) NSMutableArray *searchCities;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
