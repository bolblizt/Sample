//
//  PlacesTableViewCell.m
//  TravelAssignment
//
//  Created by user on 18/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PlacesTableViewCell.h"



@implementation PlacesTableViewCell

@synthesize imageView;
@synthesize nameLabel;
@synthesize category;
@synthesize yearPublish;
@synthesize ratingView;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    self.ratingView.emptyImage = [UIImage imageNamed:@"StarEmpty"];
    self.ratingView.fullImage =[UIImage imageNamed:@"StarFull"];
                                                                   
    // Optional params
    self.ratingView.delegate = self;
    self.ratingView.contentMode =  UIViewContentModeScaleAspectFit;
    //self.ratingView.maxRating = 5;
    //self.ratingView.minRating = 1;

    self.ratingView.editable = false;
    self.ratingView.halfRatings = false;
    self.ratingView.floatRatings = false;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// MARK: FloatRatingViewDelegate


- (void)floatRatingView:(FloatRatingView *)ratingView didUpdate:(float)rating{
    
    
}


- (void)floatRatingView:(FloatRatingView *)ratingView isUpdating:(float)rating{
    
}






@end
