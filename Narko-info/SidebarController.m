
#import "SidebarController.h"

@interface SidebarController ()

@end

@implementation SidebarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reportButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Меню";
    
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.title = @"Назад";
}

@end
