//
//  ProductDatabase.m
//  MyEZShop
//
//  Created by  on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Product.h"
#import "ProductDatabase.h"

@interface ProductDatabase() {
@private
    sqlite3 *_database;
}
@end

@implementation ProductDatabase

#define DATABASE_FILE_NAME  @"groceries_01"

static ProductDatabase *_pdb;

+ (ProductDatabase*)database {
    if (_pdb == nil) {
        _pdb = [[ProductDatabase alloc] init];
    }
    return _pdb;
}

- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:DATABASE_FILE_NAME 
                                                             ofType:@"sqlite3"];
        
        if (! sqLiteDb) {
            NSString* msg = [NSString stringWithFormat:@"Failed to find database: %@", DATABASE_FILE_NAME];

            UIAlertView *anAlert = [[UIAlertView alloc] initWithTitle:@"Hit Home Button to Exit" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [anAlert show];
        }
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

- (void)dealloc {
    sqlite3_close(_database);
    [super dealloc];
}

- (NSArray *)getAllProducts {
    
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT id, name, category FROM groceries ORDER BY category";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) 
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *categoryChars = (char *) sqlite3_column_text(statement, 2);
            
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *category = [[NSString alloc] initWithUTF8String:categoryChars];
            Product *info = [[Product alloc] initWithUniqueId:uniqueId name:name category:category];                        
            [retval addObject:info];
//            [name release];
//            [category release];
//            [info release];
        }
        sqlite3_finalize(statement);
    }
    return retval;
    
}

- (NSArray *)getProductsByNamePrefix:(NSString *)namePrefix upToNumberOfMatch:(int)number
{
#warning TODO
    // Use sql statement:
    //  select id from groceries where name glob 'Ba*';
    return nil;
}

- (Product *)getProductByName:(NSString *)name
{
    Product* result = nil;
    
    NSString *query = [NSString stringWithFormat:
            @"SELECT * FROM groceries where name=\"%@\"", name];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) 
        == SQLITE_OK) 
    {
        int count = 0;
        while (sqlite3_step(statement) == SQLITE_ROW) {
            count++;
            NSAssert1(count <= 1, @"ERROR: Two products with the same name :%@", name);
            
            int uniqueId = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *categoryChars = (char *) sqlite3_column_text(statement, 2);
            
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *category = [[NSString alloc] initWithUTF8String:categoryChars];
            result = [[Product alloc] initWithUniqueId:uniqueId name:name category:category];
        }
        sqlite3_finalize(statement);
    }

    return result;
}

- (NSArray *)getSubCategories:(int)parentId
{
    return nil;
}

- (Product *)getProductByUniqueId:(int)uniqueId
{
    return nil;
}

- (void)addProduct:(Product *)product
{
#warning TODO
}

- (void)removeProduct:(Product *)product
{
    
}

@end
