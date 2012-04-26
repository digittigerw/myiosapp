//
//  Family.h
//  Smiley
//
//  Created by  on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject

@property (nonatomic, strong)  NSString*   name;
@property (nonatomic)  int         happiness;

-(id)initWithName:(NSString*)name andHappiness:(int)happiness;

@end


@interface Family : NSObject

@property (nonatomic, strong)  NSString*   name;
@property (nonatomic, strong)  NSMutableArray*    members;

-(id)initWithName:(NSString*)name;
-(void)addMember:(Member*)m;

@end

/*
 * This manages a global array of families.
 */
@interface FamilyManager : NSObject

+ (NSArray*)getFamilies;

+ (Family*)getFamilyByIndex:(int)index;

@end