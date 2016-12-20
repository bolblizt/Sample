//
//  MainTableViewController.h
//  TravelAssignment
//
//  Created by Priority Wealth on 15/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UITableViewController <UISearchBarDelegate,UISearchControllerDelegate, UISearchDisplayDelegate,UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) UISearchController *searchDisplayController;

@end
