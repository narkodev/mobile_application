
#import "ReportController.h"
#import "SaveDataSingleton.h"

@interface ReportController ()

@end

@implementation ReportController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.title = @"";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
}

- (IBAction)nextStep:(id)sender {
    
    SaveDataSingleton *sharedManager = [SaveDataSingleton sharedManager];
    
    [sharedManager.dataList setObject:[NSString stringWithFormat:@"%@", self.subject.text] forKey:@"subject"];
    
    [sharedManager.dataList setObject:[NSString stringWithFormat:@"%@", self.phone.text] forKey:@"phone"];
    
    [self performSegueWithIdentifier:@"goToGetLocation" sender:self];
    
}

@end
