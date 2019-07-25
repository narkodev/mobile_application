
#import <UIKit/UIKit.h>

@interface ReportController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *subject;

@property (weak, nonatomic) IBOutlet UITextField *phone;

- (IBAction)nextStep:(id)sender;

@end
