
#import "DrugDetailController.h"
#import "DrugLawDetailController.h"

@interface DrugDetailController ()
@end

@implementation DrugDetailController

- (void)setData {
    
    self.name.text = [self.dataDictionary objectForKey:@"name"];
    
    NSString *imageFileName = [[self.dataDictionary objectForKey:@"image"]
                               stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *imageURL = [NSString stringWithFormat:@"%@/%@/%@",
                          @"https://narko-info.space/uploads/drugs",
                          [self.dataDictionary objectForKey:@"id"],
                          imageFileName];
        
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    self.image.image = [UIImage imageWithData:imageData];
    
    self.summary.text = [self.dataDictionary objectForKey:@"summary"];
    
    self.otherNames.text = [self.dataDictionary objectForKey:@"other_name"];
    
    self.takingDrug.text = [self.dataDictionary objectForKey:@"taking_drug"];
    
    self.drugsSymptoms.text = [self.dataDictionary objectForKey:@"drug_symptoms"];
    
    NSArray *categories = [self.dataDictionary objectForKey:@"categories"];
    
    if([categories count] == 1) {
        self.drugCategory.text = [[categories objectAtIndex:0] objectForKey:@"name"];
    } else if([categories count] == 2) {
        self.drugCategory.text = [NSString stringWithFormat:@"%@, %@",
                                  [[categories objectAtIndex:0] objectForKey:@"name"],
                                  [[categories objectAtIndex:1] objectForKey:@"name"]];
    }
        
    self.smallSizeResponsibility.text = [self.dataDictionary objectForKey:@"storage_small_size"];
    
    self.bigSizeResponsibility.text = [self.dataDictionary objectForKey:@"storage_big_size"];
    
    self.largeSizeResponsibility.text = [self.dataDictionary objectForKey:@"storage_large_size"];
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self uploadLawData];
    [self setData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.lawList count];
}

- (void)uploadLawData {
    
    NSString *urlString = [NSString stringWithFormat:@"https://narko-info.space/api/drug-law"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
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
    
    UITableViewCell *cell = [self.customTableView dequeueReusableCellWithIdentifier:@"LawCell" forIndexPath:indexPath];
        
    cell.textLabel.font = [UIFont systemFontOfSize: 14];
    
    cell.textLabel.text = [[self.lawList objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"showDrugLawDetailView"]) {
        
        self.title = @"Назад";
        
        NSIndexPath *indexPath = [self.customTableView indexPathForSelectedRow];
        
        DrugLawDetailController *drugDetailLawViewController = [segue destinationViewController];
        
        NSDictionary *selectedRowDictionary = [self.lawList objectAtIndex:indexPath.row];
        
        drugDetailLawViewController.dataDictionary = selectedRowDictionary;
        
    }
    
}

@end
