
#import "CriminalLawController.h"
#import "DrugLawDetailController.h"

@interface CriminalLawController ()

@end

@implementation CriminalLawController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"Кримiнальний кодекс";
    
    [self uploadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Кримiнальний кодекс";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.lawList count];
}

- (void)uploadData {
    
    NSString *url_string = [NSString stringWithFormat:@"https://narko-info.space/api/criminal-law"];
    
    NSURL *url = [NSURL URLWithString:url_string];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *error;
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingMutableLeaves
                                                      error:&error];
    
    if(error == NULL) {
        self.lawList = [[NSArray alloc] initWithArray:json];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.lawList objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"showDrugLawDetailViewForCriminal"]) {
        
        self.title = @"Назад";
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        DrugLawDetailController *drugDetailLawViewController = [segue destinationViewController];
        
        NSDictionary *selectedRowDictionary = [self.lawList objectAtIndex:indexPath.row];
        
        drugDetailLawViewController.dataDictionary = selectedRowDictionary;
        
    }
    
}

@end
