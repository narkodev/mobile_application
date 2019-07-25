
#import "DrugLawDetailController.h"

@interface DrugLawDetailController ()

@end

@implementation DrugLawDetailController


-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.title = @"";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
}

- (void)setData {
    self.fullName.text = [self.dataDictionary objectForKey:@"full_name"];
    self.summary.text = [self.dataDictionary objectForKey:@"summary"];
}

@end
