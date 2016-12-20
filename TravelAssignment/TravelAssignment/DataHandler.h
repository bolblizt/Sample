//
//  DataHandler.h
//  TravelAssignment
//
//  Created by Priority Wealth on 19/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DataHandler : NSObject{
    
    sqlite3 *_database;
}



+ (DataHandler*)database;
- (NSArray *)gameList;


@end
