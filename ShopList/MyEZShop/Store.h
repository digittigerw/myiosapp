//
//  Store.h
//  MyEZShop
//
//  Created by  on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject

@property (atomic) int uniqueId;
@property (atomic, strong) NSString* name;
@property (atomic, strong) NSString* address;
@property (atomic) double longitude;
@property (atomic) double latitude;

@end
