//
//  ProductDatabase.h
//  MyEZShop
//
//  Created by  on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface ProductDatabase : NSObject

// The database singleton instance.
//
+ (ProductDatabase*)database;

// Get all products in the data base
//
- (NSArray*)getAllProducts;

// Get subcategories immediately under the parent.
// parentId == -1 means to get top level categories
//
- (NSArray*)getSubCategories:(int)parentId;

// Given a prefix, get the products and categories whose name 
// begins with the prefix. 
// As the number of matches can be big, the "upToNumberOfMatch"
// argument restricts how many matches to return.
//
- (NSArray *)getProductsByNamePrefix:(NSString*)namePrefix upToNumberOfMatch:(int)number;

- (Product*)getProductByName:(NSString*)name;

- (Product*)getProductByUniqueId:(int)uniqueId;

- (void)addProduct:(Product*)product;

- (void)removeProduct:(Product*)product;

@end
