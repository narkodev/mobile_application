
#import <UIKit/UIKit.h>

@interface DrugLawDetailController : UIViewController

@property (strong, nonatomic) NSDictionary *dataDictionary;

@property (weak, nonatomic) IBOutlet UITextView *fullName;

@property (weak, nonatomic) IBOutlet UITextView *summary;

@end
