//
//  ProductData.m
//  MyEZShop
//
//  Created by  on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize uniqueId = _uniqueId;
@synthesize name = _name;
@synthesize category = _category;

- (id)initWithUniqueId:(int)Id name:(NSString *)name category:(NSString *)category 
{
    if ((self = [super init])) {
        self.uniqueId = Id;
        self.name = name;
        self.category = category;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ : %@", self.name, self.category];
}

@end
