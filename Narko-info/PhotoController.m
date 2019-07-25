
#import "PhotoController.h"
#import "SaveDataSingleton.h"

@interface PhotoController ()
@end

@implementation PhotoController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Помилка!"
                                                              message:@"Ваш пристрiй без камери - неможливо додати фото. Будь ласка, натиснiть кнопку 'Далi'."
                                                             delegate:nil
                                                    cancelButtonTitle:@"Закрити"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
}

- (IBAction)takePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    self.imageView.image = chosenImage;
    
    NSString *imageString = [UIImagePNGRepresentation(chosenImage) base64Encoding];
    
    NSLog(@"IMAGE3: %@", imageString);
    
    SaveDataSingleton *sharedManager = [SaveDataSingleton sharedManager];
    [sharedManager.dataList setObject:[NSString stringWithFormat:@"%@", imageString] forKey:@"photo"];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)nextStep:(id)sender {
    
    NSLog(@"go to result");
    
    [SaveDataSingleton sendDataByAPI];
    
    [self performSegueWithIdentifier:@"goToResultStep" sender:self];
    
}

@end
