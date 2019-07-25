
#import <UIKit/UIKit.h>

@class DrugDetailController;

@interface DrugListController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, retain) NSArray *drugs;

@property (nonatomic, retain) NSMutableArray *searchDrugs;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
