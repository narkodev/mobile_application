
#import "CityTableViewController.h"
#import "OrganizationController.h"

@interface CityTableViewController ()
{
    BOOL isSearched;
}
@end

@implementation CityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    isSearched = false;
    
    [self setData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Довiдник";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.title = @"";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
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
        
        self.searchCities = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < [self.cities count]; i++) {
            
            NSString *citySearchNames = [[self.cities objectAtIndex:i] objectForKey:@"name"];
            
            NSRange nameRange = [citySearchNames rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(nameRange.location != NSNotFound) {
                [self.searchCities addObject:[self.cities objectAtIndex:i]];
            }
            
        }
        
    }
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isSearched) {
        return [self.searchCities count];
    } else {
        return [self.cities count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cityCell = [tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    
    if(isSearched) {
        cityCell.textLabel.text = [[self.searchCities objectAtIndex:indexPath.row] objectForKey:@"name"];
    } else {
        cityCell.textLabel.text = [[self.cities objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
    
    return cityCell;
}

- (void)setData {
    
    NSString * urlString = [NSString stringWithFormat:@"https://narko-info.space/api/city"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *error;
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingMutableLeaves
                                                      error:&error];
    
    if(error == NULL) {
        self.cities = [[NSArray alloc] initWithArray:json];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"showCityOrganization"]) {
        
        self.title = @"Назад";
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        OrganizationController *organizationController = [segue destinationViewController];
        
        NSDictionary *selectedRowDictionary;
        
        if(isSearched) {
            selectedRowDictionary = [self.searchCities objectAtIndex:indexPath.row];
        } else {
            selectedRowDictionary = [self.cities objectAtIndex:indexPath.row];
        }
        
        organizationController.cityDictionary = selectedRowDictionary;
        
    }
    
}

@end
