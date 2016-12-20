//
//  DataModel.h
//  TravelAssignment
//
//  Created by user on 14/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject{
    
    int gameID;
    NSString *name;
    NSString *category;
    NSString *date;
    int rating;
    NSString *info;
    NSDate  *dateObj;
    
    
    
}

+ (id)sharedManager;
@property(nonatomic, assign) int gameID;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *category;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, assign) int rating;
@property(nonatomic, strong) NSString *info;
@property(nonatomic, strong)  NSDate  *dateObj;
@end
