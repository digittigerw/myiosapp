//
//  Category.h
//  MyEZShop
//
//  Created by  on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

@property (nonatomic) int uniqueId;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) int parentId;

@end
