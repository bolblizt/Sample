//
//  DataModel.m
//  TravelAssignment
//
//  Created by user on 14/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

@synthesize name = _name;
@synthesize category = _category;
@synthesize rating = _rating;
@synthesize date = _date;
@synthesize info = _info;
@synthesize gameID = _gameID;
@synthesize dateObj = _dateObj;

    
+ (id)sharedManager {
    static DataModel *sharedDataModel = nil;
    @synchronized(self) {
        if (sharedDataModel == nil)
        sharedDataModel = [[self alloc] init];
    }
    return sharedDataModel;
}
    
    
- (id)init {
    if (self = [super init]) {
        name = @"";
        category  = @"";
        rating = 0;
        date = @"";
        info = @"";
        gameID = 0;
    }
    return self;
}
    
    
@end
