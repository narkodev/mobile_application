
#import <UIKit/UIKit.h>

@class DrugLawDetailController;

@interface DrugDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (nonatomic, retain) NSArray *lawList;

@property (strong, nonatomic) NSDictionary *dataDictionary;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UITextView *summary;

@property (weak, nonatomic) IBOutlet UITextView *otherNames;

@property (weak, nonatomic) IBOutlet UITextView *takingDrug;

@property (weak, nonatomic) IBOutlet UITextView *drugsSymptoms;

@property (weak, nonatomic) IBOutlet UITextView *drugCategory;

@property (weak, nonatomic) IBOutlet UILabel *smallSizeResponsibility;

@property (weak, nonatomic) IBOutlet UILabel *bigSizeResponsibility;

@property (weak, nonatomic) IBOutlet UILabel *largeSizeResponsibility;

@end
