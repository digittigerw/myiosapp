//
//  Calc_Brain.h
//  Calculator
//
//  Created by Ling Wang on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calc_Brain : NSObject

-(void)pushOperand:(double)number; 

-(void)setOperator:(NSString*)op; 

// Clear all operands and operator
-(void)clear;

// Check if operator key is just pressed.
// If user keeps pressing operator key, only honor the 
// the latest one.
-(BOOL)operatorJustPressed;

// Perform operation.
// If not enough operands or no operator yet, do nothing and return nil. Otherwise return the result string.
-(NSString*)performOperation;

@end
