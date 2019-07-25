
#import <UIKit/UIKit.h>

@interface OrganizationController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, assign) NSDictionary* cityDictionary;

@property (nonatomic, retain) NSArray* phones;

@property (nonatomic, retain) NSMutableArray *searchPhones;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
