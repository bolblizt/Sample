//
//  MainTableViewController.m
//  TravelAssignment
//
//  Created by Priority Wealth on 15/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MainTableViewController.h"
#import "PlacesTableViewCell.h"
#import "DataModel.h"
#import "DataHandler.h"


@interface MainTableViewController (){
    
    CGFloat pWidth;
    UISearchController *searchController;
   // UISearchDisplayController *searchController;
     NSArray *searchResults;
}

@property(nonatomic, strong)NSArray *listOfGames;
@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, strong) NSArray *searchResults;
@end




@implementation MainTableViewController


@synthesize listOfGames = _listOfGames;
@synthesize searchController;
@synthesize  searchResults;
#pragma mark - search results




- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope { //(searchText: String, scope: String = "All") {
    
    NSMutableArray *tempArr = [[NSMutableArray alloc]initWithCapacity:[self.listOfGames count]];
    
    
  NSString*  strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@",strippedString];
    self.searchResults = [tempArr filteredArrayUsingPredicate:bPredicate];

 //   self.listOfGames = sortedArray;
    
    
    
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(dispatchQueue, ^(void){
        
        [self filterContentForSearchText:self.searchController.searchBar.text scope:@"ALL"];
        
        dispatch_async(dispatch_get_main_queue(), ^{ 
            
            if (self.searchResults.count > 0){
                
                [self.tableView reloadData];
            }

            
        });
        
    });
    
    
    return YES;

}





- (void)GetData{
    
     self.listOfGames = [DataHandler database].gameList;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

   // UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
  //  [searchBar sizeToFit];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self];
   // self.searchController.searchResultsUpdater = self;
    //self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.showsCancelButton = true;
   // self.searchController.dimsBackgroundDuringPresentation = true;
    pWidth = [[UIScreen mainScreen]bounds].size.width;
   // self.searchController.delegate = self;
   // self.searchController.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchController.searchBar;
    self.definesPresentationContext = true;
   
    /*
    UISearchBar *searchBar = [[UISearchBar alloc] init] ;
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar
                                        contentsController:self];
    self.searchController.searchResultsDelegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.delegate = self;
    searchBar.frame = CGRectMake(0, 0, 0, 38);
   // self.navigationItem.titleView = searchBar;
    */
    
    self.listOfGames = [DataHandler database].gameList;
    for (DataModel *info in self.listOfGames) {
        NSLog(@"%d: %@, %d, %@", info.gameID, info.name, info.rating, info.category);
        
    }
    
   // self.navigationItem.titleView = searchBar;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    
    NSInteger rowsCount = 0;
    
  //  if (tableView == self.searchController.searchResultsTableView) {
//        return [searchResults count];
        
//    }
//    else
//    {
        if ([self.listOfGames count] > 0) {
            
            rowsCount = self.listOfGames.count;
        }
  //  }
    
  
    return rowsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cellRow" forIndexPath:indexPath];
    
    
    PlacesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRow" forIndexPath:indexPath];
    
    DataModel *info;
    NSLog(@"rating: %d",info.rating);
    
    
  //  if (tableView == self.searchController.searchResultsTableView) {
        info = [self.searchResults objectAtIndex:indexPath.row];
        cell.nameLabel.text = info.name;
        cell.category.text = info.category;
        cell.yearPublish.text = info.date;
        cell.ratingView.rating = info.rating;
        cell.imageView.image = [UIImage imageNamed:info.name];
 //   } else {
     
      info  =   [_listOfGames objectAtIndex:indexPath.row];
        cell.nameLabel.text = info.name;
        cell.category.text = info.category;
        cell.yearPublish.text = info.date;
        cell.ratingView.rating = info.rating;
        cell.imageView.image = [UIImage imageNamed:info.name];
        
 //   }
    
    
    // Configure the cell...
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), tableView.sectionHeaderHeight)];
    
    [customView setBackgroundColor:[UIColor lightGrayColor]];

    UIButton *sButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sButton addTarget:self
                action:@selector(SortbyName:)
      forControlEvents:UIControlEventTouchUpInside];
    [sButton setTitle:@"Sort by Name" forState:UIControlStateNormal];
    [sButton setBackgroundColor:[UIColor greenColor]];
    [sButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sButton setBackgroundImage:[UIImage imageNamed:@"redButton.png"] forState:UIControlStateNormal];
    UIButton *dButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [dButton addTarget:self
                action:@selector(SortList:)
      forControlEvents:UIControlEventTouchUpInside];
    [dButton setTitle:@"Sort by Date" forState:UIControlStateNormal];
     [dButton setBackgroundImage:[UIImage imageNamed:@"redButton.png"] forState:UIControlStateNormal];
    [dButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [filterButton addTarget:self
                action:@selector(FilterList:)
      forControlEvents:UIControlEventTouchUpInside];
    [filterButton setTitle:@"Filter" forState:UIControlStateNormal];
     [filterButton setBackgroundImage:[UIImage imageNamed:@"redButton.png"] forState:UIControlStateNormal];
    [filterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    CGFloat div = pWidth /3;
     CGFloat newLen = (div * 2) + 4;
    
        [sButton setFrame:CGRectMake(0,  0, div, tableView.sectionHeaderHeight)];
        [dButton setFrame:CGRectMake(div + 2,  0, div, tableView.sectionHeaderHeight)];
        [filterButton setFrame:CGRectMake( newLen,  0, div, tableView.sectionHeaderHeight)];
    

    [customView addSubview:sButton];
    [customView addSubview:dButton];
    [customView addSubview:filterButton];
    
    
    
    return  customView;
}




-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 50;
}

#pragma - Sorting Functions

- (void)SortList:(UIButton *)sender{
    
    
    [self Sorting:@"Dates" Title:@"Date" Msg:@"Select date sorting options."];
 
}


- (void)SortbyName:(UIButton *)sender{
    
    [self Sorting:@"Names" Title:@"Names" Msg:@"Select name sorting mode."];
   
}


- (void)FilterList:(UIButton *)sender{
    
    [self FilterTheList:@"" Title:@"Filter" Msg:@"Select a game category."];
}


- (void) receiveTestNotification:(NSNotification *) notification
{
   
    
    if ([[notification name] isEqualToString:@"ReloadNotification"])
       [ self.tableView reloadData];
      
}


- (NSArray *)SortList2:(BOOL)mode{
    NSMutableArray *unSortedList;
    NSArray *sortedArray;
    NSMutableArray *tempArr;
    NSDate *cDate;
    DataModel *trans;
    NSDateFormatter *dateFormatter;
    
    unSortedList = [[NSMutableArray alloc]initWithArray:self.listOfGames];
    
    if (!mode){
        
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy"];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        
        tempArr = [[NSMutableArray alloc]initWithCapacity:[self.listOfGames count]];
        
        for (int i = 0; i < [self.listOfGames count]; i++) {
            trans = [unSortedList objectAtIndex:i];
            //cDate = [NSDate dateWithTimeIntervalSinceReferenceDate:162000];
            cDate = [dateFormatter dateFromString:trans.date];
           // NSLog(@"xxx: %@", trans.dteregistration);
            NSLog(@"Date: %@", [cDate description]);
            trans.dateObj = cDate;
            [tempArr addObject:trans];
            
        }
        
        
        
        sortedArray = [tempArr sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSDate *first = [(DataModel *)a dateObj];
            NSDate *second = [(DataModel *)b dateObj];
            return [first compare:second];
        }];
        
    }
    else{
        
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MMMM yyyy"];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        
        tempArr = [[NSMutableArray alloc]initWithCapacity:[self.listOfGames count]];
        
        for (int i = 0; i < [self.listOfGames count]; i++) {
            trans = [unSortedList objectAtIndex:i];
            cDate = [NSDate dateWithTimeIntervalSinceReferenceDate:162000];
            cDate = [dateFormatter dateFromString:trans.date];
           
            NSLog(@"Date: %@", [cDate description]);
            trans.dateObj = cDate;
            [tempArr addObject:trans];
            
        }
        
        
        
        sortedArray = [tempArr sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSDate *first = [(DataModel *)a dateObj];
            NSDate *second = [(DataModel *)b dateObj];
            return [second compare:first];
        }];

        
    }
    
    return sortedArray;
    
}

- (void)FilterTheList:(NSString *)selection Title:(NSString *)title Msg:(NSString *)msg{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:msg
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *rtsButton = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"RTS", @"RTS action")
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action)
                             {
                                 NSLog(@"Cancel action");
                                 
                                 NSMutableArray *unSortedList;
                                 NSArray *sortedArray;
                                 NSMutableArray *tempArr;
                                 
                                 tempArr = [[NSMutableArray alloc]initWithCapacity:[ _listOfGames count]];
                                 unSortedList = [[NSMutableArray alloc]initWithArray: _listOfGames];
                                 
                                 NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[cd] %@", @"rts"];
                                 sortedArray = [unSortedList filteredArrayUsingPredicate:bPredicate];
                                 NSLog(@"HERE %@",sortedArray);
                                
                                 self.listOfGames = sortedArray;
                                 [self.tableView reloadData];
                                 
                             }];
    
    UIAlertAction *cityBuildButton = [UIAlertAction
                              actionWithTitle:NSLocalizedString(@"City Building", @"City Building action")
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction *action)
                              {
                                 
                                  NSMutableArray *unSortedList;
                                  NSArray *sortedArray;
                                  NSMutableArray *tempArr;
                                  
                                  tempArr = [[NSMutableArray alloc]initWithCapacity:[ _listOfGames count]];
                                  unSortedList = [[NSMutableArray alloc]initWithArray: _listOfGames];
                                  
                                  NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[cd] %@", @"City Building"];
                                  sortedArray = [unSortedList filteredArrayUsingPredicate:bPredicate];
                                  NSLog(@"HERE %@",sortedArray);
                                  
                                  self.listOfGames = sortedArray;
                                  [self.tableView reloadData];
                              }];
    
    
    UIAlertAction* adventureButton = [UIAlertAction
                                      actionWithTitle:NSLocalizedString(@"Adventure", @"Adventure action")
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          NSMutableArray *unSortedList;
                                          NSArray *sortedArray;
                                          NSMutableArray *tempArr;
                                          
                                          tempArr = [[NSMutableArray alloc]initWithCapacity:[ _listOfGames count]];
                                          unSortedList = [[NSMutableArray alloc]initWithArray: _listOfGames];
                                          
                                          NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[cd] %@", @"Adventure"];
                                          sortedArray = [unSortedList filteredArrayUsingPredicate:bPredicate];
                                          NSLog(@"HERE %@",sortedArray);
                                          
                                          self.listOfGames = sortedArray;
                                          [self.tableView reloadData];
                                          
                                      }];

    
    UIAlertAction* shooterButton = [UIAlertAction
                         actionWithTitle:NSLocalizedString(@"Shooter Game", @"Shooter action")
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             NSMutableArray *unSortedList;
                             NSArray *sortedArray;
                             NSMutableArray *tempArr;
                             
                             tempArr = [[NSMutableArray alloc]initWithCapacity:[ _listOfGames count]];
                             unSortedList = [[NSMutableArray alloc]initWithArray: _listOfGames];
                             
                             NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[cd] %@", @"First Shooter"];
                             sortedArray = [unSortedList filteredArrayUsingPredicate:bPredicate];
                             NSLog(@"HERE %@",sortedArray);
                             
                             self.listOfGames = sortedArray;
                             [self.tableView reloadData];
                         }];
    
    
    UIAlertAction* rtt = [UIAlertAction
                                      actionWithTitle:NSLocalizedString(@"Real Time Tactics", @"Real Time Tactics")
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          NSMutableArray *unSortedList;
                                          NSArray *sortedArray;
                                          NSMutableArray *tempArr;
                                          
                                          tempArr = [[NSMutableArray alloc]initWithCapacity:[ _listOfGames count]];
                                          unSortedList = [[NSMutableArray alloc]initWithArray: _listOfGames];
                                          
                                          NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[cd] %@", @"RTT"];
                                          sortedArray = [unSortedList filteredArrayUsingPredicate:bPredicate];
                                          NSLog(@"HERE %@",sortedArray);
                                          
                                          self.listOfGames = sortedArray;
                                          [self.tableView reloadData];                                      }];
    
    
    UIAlertAction* action = [UIAlertAction
                                    actionWithTitle:NSLocalizedString(@"Action", @"Action")
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                       
                                        NSMutableArray *unSortedList;
                                        NSArray *sortedArray;
                                        NSMutableArray *tempArr;
                                        
                                        tempArr = [[NSMutableArray alloc]initWithCapacity:[ _listOfGames count]];
                                        unSortedList = [[NSMutableArray alloc]initWithArray: _listOfGames];
                                        
                                        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[cd] %@", @"Action"];
                                        sortedArray = [unSortedList filteredArrayUsingPredicate:bPredicate];
                                        NSLog(@"HERE %@",sortedArray);
                                        
                                        self.listOfGames = sortedArray;
                                        [self.tableView reloadData];
                                    }];
    
   
    
    
    
    UIAlertAction* getData = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Reload Data", @"Get Data")
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [self GetData];
                                 
                                 
                             }];
    

    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel")
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [self dismissViewControllerAnimated:true completion:nil];
                                 
                                 
                             }];
    
    
    
    [alertController addAction:rtsButton];
    [alertController addAction:cityBuildButton];
    [alertController addAction:adventureButton];
    [alertController addAction:shooterButton];
    [alertController addAction:rtt];
    [alertController addAction:action];
    [alertController addAction:getData];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



- (void)Sorting:(NSString *)selection Title:(NSString *)title Msg:(NSString *)msg{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:msg
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ascend = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Ascending", @"Ascending action")
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action)
                             {
                                 NSLog(@"Cancel action");
                                 
                                 NSMutableArray *unSortedList;
                                 NSArray *sortedArray;
                                 NSMutableArray *tempArr;
                                 NSDate *cDate;
                                 DataModel *trans;
                                 NSDateFormatter *dateFormatter;
                                 
                                 tempArr = [[NSMutableArray alloc]initWithCapacity:[ _listOfGames count]];
                                 unSortedList = [[NSMutableArray alloc]initWithArray: _listOfGames];
                                 
                                 if(![selection isEqualToString:@"Names"]){
                                     
                                     dateFormatter = [[NSDateFormatter alloc]init];
                                     [dateFormatter setDateFormat:@"yyyy"];
                                     [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
                                     
                                     
                                     for (int i = 0; i < [ unSortedList count]; i++) {
                                         trans = [unSortedList objectAtIndex:i];
                                         
                                         cDate = [dateFormatter dateFromString:trans.date];
                                         // NSLog(@"xxx: %@", trans.dteregistration);
                                         NSLog(@"Date: %@", [cDate description]);
                                         trans.dateObj = cDate;
                                         [tempArr addObject:trans];
                                         
                                     }
                                     
                                     sortedArray = [tempArr sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                                         NSDate *first = [(DataModel *)a dateObj];
                                         NSDate *second = [(DataModel *)b dateObj];
                                         return [first compare:second];
                                     }];
                                     
                                     
                                 }
                                 else
                                 {
                                     sortedArray = [unSortedList sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                                         NSString *first = [(DataModel *)a name];
                                         NSString *second = [(DataModel *)b name];
                                         return [first compare:second];
                                     }];
                                 }
                                 
                                 
                                 
                                 
                                 self.listOfGames = sortedArray;
                                 
                                 [self.tableView reloadData];
                                 
                             }];
    
    UIAlertAction *descend = [UIAlertAction
                              actionWithTitle:NSLocalizedString(@"Descending", @"Descending action")
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction *action)
                              {
                                  NSLog(@"OK action");
                                  NSMutableArray *unSortedList;
                                  NSArray *sortedArray;
                                  NSMutableArray *tempArr;
                                  NSDate *cDate;
                                  DataModel *trans;
                                  NSDateFormatter *dateFormatter;
                                  
                                  tempArr = [[NSMutableArray alloc]initWithCapacity:[_listOfGames count]];
                                  unSortedList = [[NSMutableArray alloc]initWithArray:_listOfGames];
                                  
                                  
                                  
                                  
                                  //[[NSNotificationCenter defaultCenter] addObserver:self
                                  //                                       selector:@selector(receiveTestNotification:)
                                  //                                           name:@"ReloadNotification"
                                  //                                         object:nil];
                                  
                                  
                                  if (![selection isEqualToString:@"Names"]){
                                      
                                      dateFormatter = [[NSDateFormatter alloc]init];
                                      [dateFormatter setDateFormat:@"yyyy"];
                                      [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
                                      
                                      for (int i = 0; i < [unSortedList count]; i++) {
                                          trans = [unSortedList objectAtIndex:i];
                                          cDate = [dateFormatter dateFromString:trans.date];
                                          NSLog(@"Date: %@", [cDate description]);
                                          trans.dateObj = cDate;
                                          [tempArr addObject:trans];
                                          
                                      }
                                      
                                      sortedArray = [tempArr sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                                          NSDate *first = [(DataModel *)a dateObj];
                                          NSDate *second = [(DataModel *)b dateObj];
                                          return [second compare:first];
                                      }];
                                  }
                                  else{
                                      sortedArray = [tempArr sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                                          NSString *first = [(DataModel *)a name];
                                          NSString *second = [(DataModel *)b name];
                                          return [second compare:first];
                                      }];
                                      
                                  }
                                  
                                  self.listOfGames = sortedArray;
                                  [self.tableView reloadData];
                              }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel")
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                                // [self GetData];
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }];

    
    
    [alertController addAction:ascend];
    [alertController addAction:descend];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

//- (UIModalPresentationStyle) daptivePresentationStyleForPresentationController:( UIPresentationController *) {
  //  return UIModalPresentationStyle.FullScreen
    //        return UIModalPresentationStyle.None
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
