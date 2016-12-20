//
//  DataHandler.m
//  TravelAssignment
//
//  Created by Priority Wealth on 19/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "DataHandler.h"
#import "DataModel.h"




@implementation DataHandler

static DataHandler *_database;

+ (DataHandler*)database {
    if (_database == nil) {
        _database = [[DataHandler alloc] init];
    }
    return _database;
}


- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"games"
                                                             ofType:@"sqlite3"];
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

- (NSArray *)gameList {
    
    NSMutableArray *retval =  [[NSMutableArray alloc]init];
    NSString *query = @"SELECT * FROM game_list";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *category = (char *) sqlite3_column_text(statement, 2);
           char *detail_info = (char *) sqlite3_column_text(statement, 3);
            char *game_date = (char *) sqlite3_column_text(statement, 4);
            int star_rating = sqlite3_column_int(statement, 5);
          
            
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *gameCategory = [[NSString alloc] initWithUTF8String:category];
            NSString *infoDetail = [[NSString alloc] initWithUTF8String:detail_info];
            NSString *gameDate = [[NSString alloc] initWithUTF8String:game_date];
            
            DataModel *gameInfo = [[DataModel alloc] init];
            gameInfo.gameID =  uniqueId;
            gameInfo.name = name;
            gameInfo.info = infoDetail;
            gameInfo.rating = star_rating;
            gameInfo.date = gameDate;
            gameInfo.category = gameCategory;
            [retval addObject:gameInfo];

        }
        sqlite3_finalize(statement);
    }
    return retval;
    
}





@end
