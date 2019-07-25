
#import <UIKit/UIKit.h>

@interface PhotoController : UIViewController <UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:(id)sender;

- (IBAction)selectPhoto:(id)sender;

- (IBAction)nextStep:(id)sender;

@end
