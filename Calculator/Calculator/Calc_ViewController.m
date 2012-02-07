//
//  Calc_ViewController.m
//  Calculator
//
//  Created by Ling Wang on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Calc_ViewController.h"

#import "Calc_Brain.h"

@interface Calc_ViewController()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property BOOL userEnteringDigit;
@property BOOL operatorJustPressed;

@property (strong, nonatomic) Calc_Brain* brain;
@end

@implementation Calc_ViewController

@synthesize userEnteringDigit = _userEnteringDigit;
@synthesize operatorJustPressed = _operatorJustPressed;

@synthesize label = _label;

- (void)setLabel:(UILabel *)__label {
    _label = __label;
}

@synthesize brain = _brain;

-(Calc_Brain*)brain {
    if (!_brain)
        _brain = [[Calc_Brain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSLog(@"Label: %@", self.label.text);
    self.operatorJustPressed = NO;
    
    if (!self.userEnteringDigit) {
        self.label.text = sender.currentTitle;
        self.userEnteringDigit = YES;
    }
    else
        self.label.text = [self.label.text stringByAppendingString:sender.currentTitle];
}

- (IBAction)clearPressed:(id)sender {
    self.label.text = @"0";
    self.userEnteringDigit = NO;
    self.operatorJustPressed = NO;
    
    [self.brain clear];
}

- (IBAction)operatorPressed:(UIButton *)sender {
    self.userEnteringDigit = NO;
    
    NSString *operator = sender.currentTitle;

    NSLog(@"Operator: %@", operator);
    
    if (! self.operatorJustPressed) {
        self.operatorJustPressed = YES;
        
        // not repeated operator
        NSString *ostr = self.label.text;
        double o = [ostr doubleValue];
        
        [self.brain pushOperand:o];
    }
    else {
        NSLog(@"Invalid: Operator repeated.");
        return;
    }
    
    // perform previous operation if ok
    NSString* previous = [self.brain performOperation];
    if (previous) {
        self.label.text = previous;
        
        [self.brain pushOperand:[previous doubleValue]];
    }
    
    [self.brain setOperator:operator];
}

- (IBAction)equalPressed:(id)sender {
    self.userEnteringDigit = NO;
    self.operatorJustPressed = NO;

    double o = [self.label.text doubleValue];
    [self.brain pushOperand:o];
    
    NSString* r = [self.brain performOperation];
    if (r)
        self.label.text = r;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)actionDigitPressed:(id)sender {
}
@end
