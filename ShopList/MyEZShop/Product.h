//
//  ProductData.h
//  MyEZShop
//
//  Created by  on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic) int uniqueId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *category;

- (id)initWithUniqueId:(int)uniqueID name:(NSString *)name category:(NSString *)category;

- (NSString *)description;

@end
