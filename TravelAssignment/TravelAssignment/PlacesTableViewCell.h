//
//  PlacesTableViewCell.h
//  TravelAssignment
//
//  Created by user on 18/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FloatRatingView.swift"
#import "TravelAssignment-swift.h"

@interface PlacesTableViewCell : UITableViewCell <FloatRatingViewDelegate>


@property(nonatomic, weak) IBOutlet UIImageView *imageView;
//@property(nonatomic, weak) IBOutlet UILabel *nameLabel;
@property(nonatomic, weak) IBOutlet FloatRatingView *ratingView;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *category;
@property(weak, nonatomic) IBOutlet UILabel *yearPublish;
//@property(nonatomic, weak) IBOutlet FloatRatingView *floatView;



@end
