
#import "OrganizationController.h"

@interface OrganizationController ()
{
    BOOL isSearched;
}
@end

@implementation OrganizationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isSearched = false;
    
    [self setData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = [self.cityDictionary objectForKey:@"name"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.title = @"Назад";
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
        
        self.searchPhones = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < [self.phones count]; i++) {
            
            NSString *citySearchNames = [[self.phones objectAtIndex:i] objectForKey:@"name"];
            
            NSRange nameRange = [citySearchNames rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(nameRange.location != NSNotFound) {
                [self.searchPhones addObject:[self.phones objectAtIndex:i]];
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
        return [self.searchPhones count];
    } else {
        return [self.phones count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:@"OrganizationCell" forIndexPath:indexPath];
    
    phoneCell.textLabel.font = [UIFont systemFontOfSize: 16];
    
    if(isSearched) {
        phoneCell.textLabel.text = [[self.searchPhones objectAtIndex:indexPath.row] objectForKey:@"name"];
    } else {
        phoneCell.textLabel.text = [[self.phones objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
    
    return phoneCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *phoneNumberString = @"tel:";
    
    NSString *number = [[self.phones objectAtIndex:indexPath.row] objectForKey:@"phone"];
    
    phoneNumberString = [phoneNumberString stringByAppendingString:number];
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [app openURL:[NSURL URLWithString:phoneNumberString] options:@{} completionHandler:nil];
    
}

- (void)setData {
    
    NSString * urlString = [NSString stringWithFormat:@"%@/%@",
                            @"https://narko-info.space/api/city",
                            [self.cityDictionary objectForKey:@"id"]
                            ];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *error;
    
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if(error == NULL) {
        self.phones = [[NSArray alloc] initWithArray:json];
    }

}

@end

