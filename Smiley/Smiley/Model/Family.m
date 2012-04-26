//
//  Family.m
//  Smiley
//
//  Created by  on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Family.h"

@implementation Member

@synthesize name = _name;
@synthesize happiness = _happiness;

-(id)initWithName:(NSString *)name andHappiness:(int)happiness {
    self = [super init];
    
    self.name = name;
    self.happiness = happiness;
    return self;
}

@end


@implementation Family

@synthesize name = _name;
@synthesize members = _members;

- (id)initWithName:(NSString *)name {
    self = [super init];
    
    self.name = name;
    self.members = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)addMember:(Member *)m {
    [self.members addObject:m];
}

@end


@implementation FamilyManager

static NSArray* sFamilies = nil;

+ (NSArray *)getFamilies {
    if (sFamilies != nil)
        return sFamilies;
    
    Family* obama = [[Family alloc] initWithName:@"Obama"];
    [obama addMember:[[Member alloc] initWithName:@"Father" andHappiness:10]];
    [obama addMember:[[Member alloc] initWithName:@"Mother" andHappiness:50]];
    [obama addMember:[[Member alloc] initWithName:@"Son" andHappiness:70]];
    [obama addMember:[[Member alloc] initWithName:@"Daughter" andHappiness:90]];
    
    Family* bush = [[Family alloc] initWithName:@"Bush"];
    [bush addMember:[[Member alloc] initWithName:@"Father" andHappiness:90]];
    [bush addMember:[[Member alloc] initWithName:@"Mother" andHappiness:80]];
    [bush addMember:[[Member alloc] initWithName:@"Son" andHappiness:50]];
    [bush addMember:[[Member alloc] initWithName:@"Daughter" andHappiness:20]];

    Family* Chavez = [[Family alloc] initWithName:@"Chavez"];
    [Chavez addMember:[[Member alloc] initWithName:@"Father" andHappiness:90]];
    [Chavez addMember:[[Member alloc] initWithName:@"Mother" andHappiness:70]];
    [Chavez addMember:[[Member alloc] initWithName:@"Son" andHappiness:60]];
    
    Family* Jose = [[Family alloc] initWithName:@"Jose"];
    [Jose addMember:[[Member alloc] initWithName:@"Father" andHappiness:90]];
    [Jose addMember:[[Member alloc] initWithName:@"Son" andHappiness:60]];
    
    sFamilies = [[NSMutableArray alloc] initWithObjects:
        obama, bush, Chavez, Jose, nil];
    
    return sFamilies;
}

+ (Family *)getFamilyByIndex:(int)index {
    @try {
        return [[self getFamilies] objectAtIndex:index];
    }
    @catch (NSException *e) {
        NSLog(@"getFamilyByIndex: index out of range");
        return nil;
    }
}

@end