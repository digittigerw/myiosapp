//
//  Calc_Brain.m
//  Calculator
//
//  Created by Ling Wang on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Calc_Brain.h"

@interface Calc_Brain()
@property (strong, nonatomic)NSMutableArray* operandStack;
@property (nonatomic)unichar op;

@end

@implementation Calc_Brain

@synthesize operandStack = _operandStack;

@synthesize op = _op;

-(NSMutableArray*)operandStack {
    if (_operandStack == nil)
        _operandStack = [[NSMutableArray alloc] init];
    
    return _operandStack;
}

-(void)clear {
    [self.operandStack removeAllObjects];
    self.op = 0;
}

-(BOOL)operatorJustPressed {
    return self.op != 0;
}

-(void)pushOperand:(double)number {
    [self.operandStack addObject:[NSNumber numberWithDouble:number]];
}

// Caller must ensure the stack is not empty
-(double)popOperand {
    double r = [[self.operandStack lastObject] doubleValue];
    [self.operandStack removeLastObject];
    return r;
}

-(void)setOperator:(NSString *)__op {
    self.op = [__op characterAtIndex:0];
}

-(NSString*)performOperation {
    NSString* result = nil;
    unichar __op = self.op;
    
    if (__op == 0 || [self.operandStack count] < 2)
        return result;
    
    double n2 = [self popOperand];
    double n1 = [self popOperand];
    double r;
    
    switch (__op) {
        case '+':
            r = n1 + n2; break;
        case '-':
            r = n1 - n2; break;
        case '*':
            r = n1 * n2; break;
        case '/':
            r = n1 / n2; break;
        default:
            NSLog(@"Oops, unknown operator.");
    }
    
    NSLog(@"Operand count: %d", [self.operandStack count]);
    
    // clear operator
    self.op = 0;
    
    result = [NSString stringWithFormat:@"%g", r];
    
    return result;
}

-(NSString *)description {
    return [self.operandStack description];
}

@end
