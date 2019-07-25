
#import "DrugListController.h"
#import "DrugDetailController.h"

@interface DrugListController ()
{
    BOOL isSearched;
}
@end

@implementation DrugListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"Каталог наркотиків";
    
    isSearched = false;
    
    [self uploadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Каталог наркотиків";
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if(searchText.length == 0) {
        
        isSearched = false;
        
    } else {
    
        isSearched = true;
        
        self.searchDrugs = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < [self.drugs count]; i++) {
            
            NSString *drugSearchNames = [[self.drugs objectAtIndex:i] objectForKey:@"search_name"];
            
            NSRange nameRange = [drugSearchNames rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(nameRange.location != NSNotFound) {
                [self.searchDrugs addObject:[self.drugs objectAtIndex:i]];
            }
            
        }
        
    }
    
    [self.tableView reloadData];
}

- (void)uploadData {
    
    NSString *url_string = [NSString stringWithFormat:@"https://narko-info.space/api/drugs"];
    
    NSURL *url = [NSURL URLWithString:url_string];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *error;
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingMutableLeaves
                                                      error:&error];
    
    if(error == NULL) {
        self.drugs = [[NSArray alloc] initWithArray:json];
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(isSearched) {
        return [self.searchDrugs count];
    } else {
        return [self.drugs count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(isSearched) {
           cell.textLabel.text = [[self.searchDrugs objectAtIndex:indexPath.row] objectForKey:@"name"];
    } else {
           cell.textLabel.text = [[self.drugs objectAtIndex:indexPath.row] objectForKey:@"name"];
    }

    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"showDrugDetailView"]) {
        
        self.title = @"Назад";
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        DrugDetailController *drugDetailViewController = [segue destinationViewController];
        
        NSDictionary *selectedRowDictionary;
        
        if(isSearched) {
            selectedRowDictionary = [self.searchDrugs objectAtIndex:indexPath.row];
        } else {
            selectedRowDictionary = [self.drugs objectAtIndex:indexPath.row];
        }
        
        drugDetailViewController.dataDictionary = selectedRowDictionary;
        
    }
    
}

@end
